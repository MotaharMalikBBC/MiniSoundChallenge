//
//  PlainSubtitleHandler.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 20/08/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

final class PlainSubtitleHandler: NSObject, SubtitleHandler {
    
    enum FetchState {
        case fetching
        case success(BBCSMPSubtitleParserResult)
        case failure
    }
    
    weak var delegate: SubtitleHandlerDelegate? {
        didSet { updateResult() }
    }
    
    private let subtitlesUrl: URL
    
    private var fetcher: BBCSMPSubtitleFetcher
    private var fetchState: FetchState? {
        didSet { updateResult() }
    }
    
    private let parser: BBCSMPSubtitleParser
    
    init(url: URL,
         parser: BBCSMPSubtitleParser = BBCSMPSubtitleParser(),
         fetcher: BBCSMPSubtitleFetcher = BBCSMPNetworkSubtitleFetcher()) {
        self.subtitlesUrl = url
        self.parser = parser
        self.fetcher = fetcher 
        super.init()
    }
    
    func handleProgress(_ mediaProgress: MediaProgress) {
        fetchState == nil ? fetchSubtitles() : updateResult()
    }
    
    private func fetchSubtitles() {
        fetchState = .fetching
        fetcher.fetchSubtitles(url: subtitlesUrl, success: { [weak self] data in
            guard let self = self, let result = self.parser.parse(data) else {
                self?.fetchState = .failure
                return
            }
            self.fetchState = .success(result)
        }, failure: { [weak self] _ in
            self?.fetchState = .failure
        })
    }
    
    private func updateResult() {
        guard let fetchState = fetchState else { return }
        
        switch fetchState {
        case .fetching: return
        case .success(let result): delegate?.updateSuccess(result)
        case .failure: delegate?.updateFailure()
        }
    }
}
