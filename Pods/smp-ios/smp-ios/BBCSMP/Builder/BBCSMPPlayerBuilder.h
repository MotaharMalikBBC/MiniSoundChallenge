//
//  BBCSMPPlayerBuilder.h
//  BBCSMP
//
//  Created by Al Priest on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPInterruptionEndedBehaviour.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIImage;
@class BBCSMPSuspendRule;
@protocol BBCSMP;
@protocol BBCSMPItemProvider;
@protocol BBCSMPObserver;
@protocol BBCSMPNetworkStatusProvider;
@protocol BBCSMPBackgroundPlaybackObserver;
@protocol BBCSMPSettingsPersistence;
@protocol BBCSMPRemoteCommandCenter;
@protocol MPNowPlayingInfoCenterProtocol;
@protocol BBCSMPSettingsPersistenceFactory;
@protocol BBCSMPSystemSuspension;

@interface BBCSMPPlayerBuilder : NSObject

/**
 @returns This returns a BBCSMPPlayerBuilder which allows you to build an SMPPlayer with aspects of it customised. For each aspect you wish to customise call the relevant "with" method.
 
 If you want the "default" SMP player, then you can ignore the "with" builder methods and just call the -(BBCSMPPlayer *)build method
 */
- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (id<BBCSMP>)build;

- (instancetype)withPlayerItemProvider:(id<BBCSMPItemProvider>)playerItemProvider NS_SWIFT_NAME(withPlayerItemProvider(_:));
- (instancetype)withMonitoringObservers:(nullable NSArray<id<BBCSMPObserver> >*)observers NS_SWIFT_NAME(withMonitoringObservers(_:));
- (instancetype)withNetworkStatusProvider:(id<BBCSMPNetworkStatusProvider>)networkStatusProvider NS_SWIFT_NAME(withNetworkStatusProvider(_:));
- (instancetype)withPeriodicExecutorFactory:(id)periodicExecutorFactory NS_SWIFT_NAME(withPeriodicExecutorFactory(_:));
- (instancetype)withVolumeProvider:(id)volumeProvider NS_SWIFT_NAME(withVolumeProvider(_:));
- (instancetype)withSuspendRule:(BBCSMPSuspendRule*)suspendRule NS_SWIFT_NAME(withSuspendRule(_:));
- (instancetype)withRemoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter;
- (instancetype)withNowPlayingInfoCenter:(id<MPNowPlayingInfoCenterProtocol>)infoCenter;
- (instancetype)withInterruptionEndedBehaviour:(BBCSMPInterruptionEndedBehaviour)telephoneBehaviour;
- (instancetype)withSettingsPersistenceFactory:(nullable id<BBCSMPSettingsPersistenceFactory>)settingsPersistenceFactory;
- (instancetype)withSubtitlesDefaultedOn;
- (instancetype)withMonitoringBaseUrl:(NSString *)baseUrl;

@end

NS_ASSUME_NONNULL_END
