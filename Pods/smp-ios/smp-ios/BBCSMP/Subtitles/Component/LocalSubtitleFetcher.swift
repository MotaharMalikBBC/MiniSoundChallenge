//
//  LocalSubtitleFetcher.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 31/08/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

final class LocalSubtitleFetcher: NSObject, BBCSMPSubtitleFetcher {
    func fetchSubtitles(url: URL, success: BBCSMPSubtitleFetchSuccess, failure: BBCSMPSubtitleFetchFailure) {
        do {
            let subtitleData = try Data(contentsOf: url)
            success(subtitleData)
        } catch {
            failure(error)
        }
    }
}
