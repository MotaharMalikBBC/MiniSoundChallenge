//
//  SubtitleProviderFactory.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 20/07/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

import UIKit

@objc(BBCSMPSubtitleProviderFactory)
public class SubtitleProviderFactory: NSObject {
    @objc
    public static func provider(url: URL,
                                transferFormat: String,
                                settings: BBCSMPSettingsPersistence = BBCSMPSettingsPersistenceFilesystem()) -> SubtitleProvider? {
        let handler: SubtitleHandler
        
        switch transferFormat {
        case "plain":
            handler = PlainSubtitleHandler(url: url)
        case "dash":
            handler = DashSubtitleHandler(segmentTemplateUrl: url)
        default:
            return nil
        }
        
        return DefaultSubtitleProvider(settings: settings, subtitleHandler: handler)
    }
    
    @objc
    public static func localProvider(url: URL, settings: BBCSMPSettingsPersistence = BBCSMPSettingsPersistenceFilesystem()) -> SubtitleProvider? {
        return DefaultSubtitleProvider(settings: settings,
                                       subtitleHandler: PlainSubtitleHandler(url: url,
                                                                             fetcher: LocalSubtitleFetcher()))
    }
}
