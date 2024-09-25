//
//  DashSubtitleHandler.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 04/08/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

enum MdatExtractionError: Error {
    case asciiEncodingError
    case mdatStructureError
    
    func description() -> String {
        switch self {
        case .asciiEncodingError:
            return "Ascii encoding error"
        case .mdatStructureError:
            return "Mdat structure error"
        }
    }
}

final class DashSubtitleHandler: NSObject, SubtitleHandler {
    
    enum SegmentState {
        case fetching
        case success(BBCSMPSubtitleParserResult)
        case failure
    }
    
    private let subtitleTemplate: URL?
    private let fetcher: BBCSMPSubtitleFetcher
    private let parser: BBCSMPSubtitleParser
    
    weak public var delegate: SubtitleHandlerDelegate?

    private var noOfSegmentsFetched = 0 { didSet { noOfConsecutiveSegmentsFailed = 0 } }
    private var noOfConsecutiveSegmentsFailed = 0

    private var segmentStates = [Int: SegmentState]()
    
    init(segmentTemplateUrl: URL,
         fetcher: BBCSMPSubtitleFetcher = BBCSMPNetworkSubtitleFetcher(),
         parser: BBCSMPSubtitleParser = BBCSMPSubtitleParser()) {
        self.subtitleTemplate = segmentTemplateUrl
        self.fetcher = fetcher
        self.parser = parser
    }
    
    func handleProgress(_ mediaProgress: MediaProgress) {
        let mediaPositionInSeconds = mediaProgress.mediaPosition.seconds
        guard mediaPositionInSeconds != 0, mediaPositionInSeconds < Date().timeIntervalSince1970 else { return }
        
        let segmentIndex = segmentIndex(from: mediaPositionInSeconds)

        // Temporary fix for PseudoVOD
        // TODO: Will be fixed in https://jira.dev.bbc.co.uk/browse/MOBILE-8080
        guard segmentIndex > 99_999 else { return }
        
        fetchSubtitles(for: segmentIndex)
        fetchSubtitles(for: segmentIndex + 1)
        
        if case let .success(result) = segmentStates[segmentIndex] {
            delegate?.updateSuccess(result)
        }
    }
    
    private func fetchSubtitles(for segmentIndex: Int) {
        guard
            segmentStates[segmentIndex] == nil,
            let url = formatSubtitleUrl(with: segmentIndex)
        else {
            return
        }
        segmentStates[segmentIndex] = .fetching
        
        fetcher.fetchSubtitles(url: url, success: { [weak self] data in
            do {
                if let self = self,
                      let sampleContainerData = data,
                      let ttmlSampleData = try self.extractMdat(from: sampleContainerData),
                    let result = self.parser.parse(ttmlSampleData) {
                    self.segmentStates[segmentIndex] = .success(result)
                    self.noOfSegmentsFetched += 1
                } else {
                    self?.updateFailure()
                    return
                }
            } catch {
                self?.updateFailure()
                return
            }
        }, failure: { [weak self] _ in
            guard let self = self else { return }
            self.segmentStates[segmentIndex] = .failure
            self.noOfConsecutiveSegmentsFailed += 1
            self.updateFailure()
        })
    }
    
    private func updateFailure() {
        if noOfSegmentsFetched == 0 || noOfConsecutiveSegmentsFailed == Constant.maxSegmentFetchFailures {
            delegate?.updateFailure()
        }
    }
    
    private func extractMdat(from data: Data) throws -> Data? {
        guard let dataAsAscii = String(data: data, encoding: .ascii) else {
            throw MdatExtractionError.asciiEncodingError
        }

        var mdatBoxStart = 0
        for index in stride(from: 0, to: dataAsAscii.count, by: Constant.mdatChunkSizeInBytes) {
            if dataAsAscii.dropFirst(index).prefix(Constant.mdatChunkSizeInBytes) == "mdat" {
                mdatBoxStart = index + Constant.mdatChunkSizeInBytes
                break
            }
        }
        
        guard mdatBoxStart > Constant.mdatBoxHeaderSize else {
            throw MdatExtractionError.mdatStructureError
        }
        
        let bigEndianUInt32 = data.dropFirst(mdatBoxStart - Constant.mdatBoxHeaderSize).prefix(Constant.mdatChunkSizeInBytes).withUnsafeBytes { $0.load(as: UInt32.self) }
        
        // 4 bytes for length descriptor
        // 4 bytes for "mdat" itself
        let mdatSize = (CFByteOrderGetCurrent() == CFByteOrder(CFByteOrderLittleEndian.rawValue)
                        ? UInt32(bigEndian: bigEndianUInt32)
                        : bigEndianUInt32) - UInt32(Constant.mdatBoxHeaderSize)
        
        return data.dropFirst(mdatBoxStart).prefix(Int(mdatSize))
    }
    
    private func formatSubtitleUrl(with segmentIndex: Int) -> URL? {
        guard let subtitleTemplate = subtitleTemplate else { return nil }
        
        let url = subtitleTemplate.absoluteString.replacingOccurrences(of: "$Number$", with: "\(segmentIndex)")
        return URL(string: url)
    }
    
    private func segmentIndex(from time: TimeInterval) -> Int {
        let nSegmentsSinceEpoch = floor(time / Constant.segmentLength)
        let segmentIndex = Constant.segmentBaseIndex + Int(nSegmentsSinceEpoch)
        return segmentIndex
    }
    
    private struct Constant {
        // DASH segments are 1-indexed
        static let segmentBaseIndex = 1
        
        // The length of a DASH segment is defined in the DASH manifest (.mpd)
        // At the time of implementation, BBC DASH segment length is 96 (duration) % 25 (timescale) = 3.84 s
        static let segmentLength: Double = 96 / 25
        
        static let maxSegmentFetchFailures = 3
                
        // an ISO BMFF box starts with 8 bytes; 4 for size and 4 for type
        static let mdatBoxHeaderSize = 8
        
        static let mdatChunkSizeInBytes = 4
    }
}
 
