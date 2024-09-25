//
//  BBCMediaSelectorRequestHeadersBuilder.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 27/07/2015.
//  Copyright (c) 2015 Michael Emmens. All rights reserved.
//

#import "BBCMediaSelectorRequestHeadersBuilder.h"

@interface BBCMediaSelectorRequestHeadersBuilder ()

@property (weak,nonatomic) id<BBCMediaSelectorConfiguring> configuring;

@end

@implementation BBCMediaSelectorRequestHeadersBuilder

- (instancetype)initWithConfiguring:(id<BBCMediaSelectorConfiguring>)configuring
{
    if ((self = [super init])) {
        self.configuring = configuring;
    }
    return self;
}

- (NSDictionary *)headersForRequest:(BBCMediaSelectorRequest *)request
{
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    if (request.authentication) {
        NSDictionary *authHeader = request.authentication.toHeader;
        
        [headers setValue:authHeader[BBCMediaSelectorAuthenticationHeaderValue]
                   forKey:authHeader[BBCMediaSelectorAuthenticationHeaderKey]];
    }
    return [NSDictionary dictionaryWithDictionary:headers];
}

@end
