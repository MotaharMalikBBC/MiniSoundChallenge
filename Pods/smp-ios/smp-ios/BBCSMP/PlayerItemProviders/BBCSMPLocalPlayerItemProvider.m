//
//  BBCSMPLocalPlayerItemProvider.m
//  SMP
//
//  Created by Stuart Thomas on 15/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPNetworkArtworkFetcher.h"
#import "BBCSMPLocalPlayerItemProvider.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPLocalItem.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPLocalPlayerItemProvider ()

@property (nonatomic, copy) NSURL* URL;
@property (nonatomic, copy) NSURL* subtitleURL;

@end

@implementation BBCSMPLocalPlayerItemProvider

- (instancetype)initWithURL:(NSURL*)URL andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer
{
    if ((self = [super init])) {
        _URL = URL;
        _avStatisticsConsumer = avStatisticsConsumer;
        _decoderFactory = [[BBCSMPLocalLegacyDecoderFactoryAdapter alloc] init];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL andSubtitleURL:(NSURL *)subtitleURL andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer
{
    if (self = [self initWithURL:URL andAVStatisticsConsumer:avStatisticsConsumer]) {
        _subtitleURL = subtitleURL;
    }
    return self;
}

#pragma - Item - provider implementation

- (void)requestFailoverPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure { 
    NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    failure(error);
}

- (void)requestPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure {
    
    BBCSMPLocalItem* item = [[BBCSMPLocalItem alloc] init];
    item.mediaURL = _URL;
    item.decoder = [_decoderFactory createDecoderForContentAtLocalURL:_URL videoTrackSubscriber:_videoTrackSubscriber];
    if(_subtitleURL != nil) {
        item.subtitleProvider = [BBCSMPSubtitleProviderFactory providerWithUrl:_subtitleURL transferFormat:@"plain" settings:[BBCSMPSettingsPersistenceFilesystem new]];
    }
    [self configurePreloadMetadata:item.metadata.preloadMetadata];
    [self configureMetadata:item.metadata];
    success(item);
    
    //failure not implemented - locally downloaded content failing is an edge case that wasnt considered a priority.
}

- (void)requestPreloadMetadata:(BBCSMPItemProviderPreloadMetadataSuccess)success failure:(BBCSMPItemProviderFailure)failure {
    BBCSMPItemPreloadMetadata* preloadMetadata = [[BBCSMPItemPreloadMetadata alloc] init];
    [self configurePreloadMetadata:preloadMetadata];
    success(preloadMetadata);
}

- (void)configureMetadata:(BBCSMPItemMetadata*)metadata
{
    metadata.avType = _avType;
    metadata.supplier = @"localdisk";
}

- (void)configurePreloadMetadata:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    [self configureMetadata:preloadMetadata.partialMetadata];
    preloadMetadata.title = _title;
    preloadMetadata.subtitle = _subtitle;
    preloadMetadata.duration = _duration;
    preloadMetadata.customAvStatsLabels = self.customAvStatsLabels;
    if (self.artworkURLProvider) {
        BBCSMPNetworkArtworkFetcher* bbcSMPNetworkArtworkFetcher = [[BBCSMPNetworkArtworkFetcher alloc] init];
        bbcSMPNetworkArtworkFetcher.artworkURLProvider = _artworkURLProvider;
        preloadMetadata.artworkFetcher = bbcSMPNetworkArtworkFetcher;
    }
}

-(NSTimeInterval)initialPlayOffset {
    return self.playOffset;
}

// MARK: - Captions

- (void)requestNextCaptionsItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure {
    // TODO: https://jira.dev.bbc.co.uk/browse/MOBILE-8059
    // Would be good to align error here and in FailoverPlayerItem potentially see L46
}

@synthesize avStatisticsConsumer = _avStatisticsConsumer;

@end
