//
//  BBCSMPNetworkSubtitleFetcher.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPLibraryUserAgent.h>
#import <HTTPClient/BBCHTTPNetworkClient.h>
#import <HTTPClient/BBCHTTPNetworkRequest.h>
#import "BBCSMPNetworkSubtitleFetcher.h"
#import "BBCSMPSubtitleParser.h"
#import "BBCSMPVersion.h"

@interface BBCSMPNetworkSubtitleFetcher ()

@property (nonatomic, strong) id<BBCHTTPClient> httpClient;
@property (nonatomic, strong) id<BBCHTTPUserAgent> userAgent;

@end

@implementation BBCSMPNetworkSubtitleFetcher

- (id)init
{
    return [self initWithHttpClient:[[BBCHTTPNetworkClient alloc] init]];
}


- (instancetype)initWithHttpClient:(id<BBCHTTPClient>)httpClient
{
    if ((self = [super init])) {
        _httpClient = httpClient;
        _userAgent = [BBCHTTPLibraryUserAgent userAgentWithLibraryName:@"BBCSMP" libraryVersion:@BBC_SMP_VERSION];
    }
    return self;
}

- (void)fetchSubtitles:(NSURL *)url success:(BBCSMPSubtitleFetchSuccess)success failure:(BBCSMPSubtitleFetchFailure)failure
{
    __weak typeof(self) weakSelf = self;
    [_httpClient sendRequest:[[[BBCHTTPNetworkRequest alloc] initWithURL:url] withUserAgent:_userAgent]
        success:^(id<BBCHTTPRequest> request, id<BBCHTTPResponse> response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(response.body);
            });
        }
        failure:^(id<BBCHTTPRequest> request, id<BBCHTTPError> error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", weakSelf);
                failure(error.error);
            });
        }];
}

@end
