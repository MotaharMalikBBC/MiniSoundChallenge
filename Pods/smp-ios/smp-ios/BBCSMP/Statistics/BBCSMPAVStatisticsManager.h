//
//  BBCSMPStatisticsManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPErrorObserver.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPNetworkStatusManager.h"
#import "BBCSMPPlayerSizeObserver.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPNetworkStatusObserver.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPAVStatisticsHeartbeatGenerator.h"
#import "BBCSMPVolumeObserver.h"
#import "BBCSMPEventBus.h"

@protocol BBCSMPAVStatisticsConsumer;

@interface BBCSMPAVStatisticsManager : NSObject <BBCSMPItemObserver,
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
                                        BBCSMPStateObserver,
#pragma GCC diagnostic pop
                                                 BBCSMPTimeObserver,
                                                 BBCSMPSubtitleObserver,
                                                 BBCSMPErrorObserver,
                                                 BBCSMPPlayerSizeObserver,
                                                 BBCSMPNetworkStatusObserver,
                                                 BBCSMPPreloadMetadataObserver,
                                                 BBCSMPVolumeObserver>

- (instancetype)initWithHeartbeatGenerator:(id<BBCSMPAVStatisticsHeartbeatGenerator>)heartbeatGenerator;
- (void)setEventBus:(BBCSMPEventBus*)eventBus;

@property (nonatomic, weak) id<BBCSMPAVStatisticsConsumer> avStatisticsConsumer;

@end
