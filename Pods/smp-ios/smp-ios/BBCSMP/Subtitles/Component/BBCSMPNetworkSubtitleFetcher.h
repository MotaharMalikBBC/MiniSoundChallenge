//
//  BBCSMPSubtitleFetcher.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleFetcher.h"

@protocol BBCHTTPClient;

@interface BBCSMPNetworkSubtitleFetcher : NSObject <BBCSMPSubtitleFetcher>

- (instancetype)initWithHttpClient:(id<BBCHTTPClient>)httpClient;

@end
