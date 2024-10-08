//
//  BBCSMPPlayerBuilder.m
//  BBCSMP
//
//  Created by Al Priest on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "AVAudioSession+AVAudioSessionProtocolConformance.h"
#import "BBCSMPAVAudioSessionAdapter.h"
#import "BBCSMPAVStatisticsManager.h"
#import "BBCSMPAirplayManager.h"
#import "BBCSMPAudioManager.h"
#import "BBCSMPBackgroundManagerNotificationAdapter.h"
#import "BBCSMPDefaultPlayerViewFactory.h"
#import "BBCSMPLibraryUserAgentProvider.h"
#import "BBCSMPNowPlayingInfoManager.h"
#import "BBCSMPPlayer.h"
#import "BBCSMPPlayerBuilder.h"
#import "BBCSMPPlayerInitialisationContext.h"
#import "BBCSMPSettingsPersistenceFilesystem.h"
#import "BBCSMPSystemVolumeProvider.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "MPNowPlayingInfoCenterProtocol.h"
#import "MPNowPlayingInfoCenter+Compatibility.h"
#import "BBCSMPTimerFactory.h"
#import "BBCSMPSuspendRule.h"
#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPSystemAirplayAvailabilityProvider.h"
#import "BBCSMPPlayerBuilder+Internal.h"
#import "BBCSMPClock.h"
#import "BBCSMPNSTimerClock.h"
#import "BBCSMPUUIDSessionInformationProvider.h"
#import "BBCSMPRDotCommonAVReporting.h"
#import "BBCSMPNetworkStatusManager.h"
#import "BBCSMPRemoteCommandCenterAdapter.h"
#import "BBCSMPBackgroundTaskScheduler.h"
#import "BBCSMPUIApplicationBackgroundTaskScheduler.h"
#import "BBCSMPRemoteCommandCenter.h"
#import "BBCSMPLegacyUIComposer.h"
#import "BBCSMPElapsedPlaybackHeartbeat.h"
#import "BBCSMPAVSystemSuspension.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPPlayerBuilder ()

@property (nonatomic, strong) id<BBCSMPItemProvider> playerItemProvider;
@property (nonatomic, strong) id<BBCSMPNetworkStatusProvider> networkStatusProvider;
@property (nonatomic, strong) id<BBCSMPPeriodicExecutorFactory> periodicExecutorFactory;
@property (nonatomic, strong) id<BBCSMPVolumeProvider> volumeProvider;
@property (nonatomic, strong) BBCSMPAudioManager* audioManager;
@property (nonatomic, strong) id<MPNowPlayingInfoCenterProtocol> nowPlayingInfoCenter;
@property (nonatomic, strong) id<BBCSMPTimerFactoryProtocol> timerFactory;
@property (nonatomic, strong) BBCSMPSuspendRule* suspendRule;
@property (nonatomic, strong) id<BBCSMPBackgroundStateProvider> backgroundStateProvider;
@property (nonatomic, strong) id<BBCSMPSwiftPeriodicExecutorFactory> swiftPeriodicExecutorFactory;
@property (nonatomic, strong) id<BBCSMPAirplayAvailabilityProvider> airplayAvailabilityProvider;
@property (nonatomic, strong) id<BBCSMPCommonAVReporting> avMonitoringClient;
@property (nonatomic, strong) id<BBCSMPClock> clock;
@property (nonatomic, assign) BOOL rDotEnabled;
@property (nonatomic, strong) NSString *rDotBaseUrl;
@property (nonatomic, strong) id<BBCSMPRemoteCommandCenter> remoteCommandCenter;
@property (nonatomic, strong) id<BBCSMPBackgroundTaskScheduler> backgroundResourceProvider;
@property (nonatomic, strong) id<BBCSMPAVStatisticsHeartbeatGenerator> heartbeatGenerator;
@property (nonatomic, strong) id<BBCSMPSettingsPersistenceFactory> settingsPersistenceFactory;
@property (nonatomic, strong) id<BBCSMPSystemSuspension> systemSuspension;
@property (nonatomic, assign) BOOL unsetDefaultSubtitlesState;
@end

#pragma mark -

@implementation BBCSMPPlayerBuilder {
    BBCSMPInterruptionEndedBehaviour _interruptionEndedBehaviour;
    id<BBCSMPUIComposer> _uiComposer;
}

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self) {
        self.settingsPersistenceFactory = [BBCSMPSettingsPersistenceFilesystemFactory new];

        BBCSMPAVAudioSessionAdapter* audioSession = [[BBCSMPAVAudioSessionAdapter alloc] initWithAudioSession:[AVAudioSession sharedInstance] notificationCenter:[NSNotificationCenter defaultCenter] operationQueue:[NSOperationQueue mainQueue]];
        _audioManager = [[BBCSMPAudioManager alloc] initWithAudioSession:audioSession];
        
        _nowPlayingInfoCenter = [MPNowPlayingInfoCenter defaultCenter];

        _timerFactory = [[BBCSMPTimerFactory alloc] init];
        
        _backgroundStateProvider = [BBCSMPBackgroundManagerNotificationAdapter new];
        _airplayAvailabilityProvider = [BBCSMPSystemAirplayAvailabilityProvider new];
        _rDotEnabled = YES;
        _remoteCommandCenter = [[BBCSMPRemoteCommandCenterAdapter alloc] init];
        _backgroundResourceProvider = [[BBCSMPUIApplicationBackgroundTaskScheduler alloc] init];
        _interruptionEndedBehaviour = BBCSMPInterruptionEndedBehaviourAutoresume;
        _heartbeatGenerator = [[BBCSMPElapsedPlaybackHeartbeat alloc] init];
        _systemSuspension = [[BBCSMPAVSystemSuspension alloc] init];
        _unsetDefaultSubtitlesState = NO;
        _swiftPeriodicExecutorFactory = [[BBCSMPSwiftTimerBasedPeriodicExecutorFactory alloc] init];
        [self withUIComposer:[[BBCSMPLegacyUIComposer alloc] init]];
    }
    
    return self;
}

#pragma mark Public

- (instancetype)withPlayerItemProvider:(id<BBCSMPItemProvider>)playerItemProvider
{
    self.playerItemProvider = playerItemProvider;
    return self;
}

- (instancetype)withSubtitlesDefaultedOn
{
    _unsetDefaultSubtitlesState = YES;
    return self;
}

- (instancetype)withSettingsPersistenceFactory:(id<BBCSMPSettingsPersistenceFactory>)
settingsPersistenceFactory
{
    self.settingsPersistenceFactory = settingsPersistenceFactory;
    return self;
}

- (instancetype)withNetworkStatusProvider:(id<BBCSMPNetworkStatusProvider>)networkStatusProvider
{
    self.networkStatusProvider = networkStatusProvider;
    return self;
}

- (instancetype)withPeriodicExecutorFactory:(id)periodicExecutorFactory
{
    self.periodicExecutorFactory = periodicExecutorFactory;
    return self;
}

- (instancetype)withVolumeProvider:(id)volumeProvider
{
    self.volumeProvider = volumeProvider;
    return self;
}

- (instancetype)withAudioManager:(BBCSMPAudioManager*)audioManager
{
    _audioManager = audioManager;
    return self;
}

- (instancetype)withNowPlayingInfoCenter:(id<MPNowPlayingInfoCenterProtocol>)infoCenter
{
    _nowPlayingInfoCenter = infoCenter;
    return self;
}

- (instancetype)withInterruptionEndedBehaviour:(BBCSMPInterruptionEndedBehaviour)telephoneBehaviour
{
    _interruptionEndedBehaviour = telephoneBehaviour;
    return self;
}

- (instancetype)withTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
{
    _timerFactory = timerFactory;
    return self;
}

- (instancetype)withSuspendRule:(BBCSMPSuspendRule*)suspendRule
{
    _suspendRule = suspendRule;
    return self;
}

- (instancetype)withBBCSMPClock:(id<BBCSMPClock>)clock
{
    _clock = clock;
    return self;
}

- (instancetype)withRemoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
{
    _remoteCommandCenter = remoteCommandCenter;
    
    return self;
}

#pragma mark Internal

- (instancetype)withSwiftPeriodicExecutorFactory:(id<BBCSMPSwiftPeriodicExecutorFactory>) swiftPeriodicExecutorFactory {
    _swiftPeriodicExecutorFactory = swiftPeriodicExecutorFactory;
    return self;
}

- (instancetype)withBackgroundStateProvider:(id<BBCSMPBackgroundStateProvider>)backgroundStateProvider
{
    _backgroundStateProvider = backgroundStateProvider;
    return self;
}

- (instancetype)withAirplayAvailabilityProvider:(id<BBCSMPAirplayAvailabilityProvider>)airplayAvailabilityProvider
{
    _airplayAvailabilityProvider = airplayAvailabilityProvider;
    return self ;
}

- (instancetype)withHeartbeatGenerator:(id<BBCSMPAVStatisticsHeartbeatGenerator>)hbg
{
    _heartbeatGenerator = hbg;
    return self;
}

- (instancetype)withCommonAVReportingClient:(id<BBCSMPCommonAVReporting>)AVMonitoringClient
{
    _avMonitoringClient = AVMonitoringClient;
    return self;
}

- (void)disableRdot
{
    _rDotEnabled = NO;
}

- (instancetype)withMonitoringBaseUrl:(NSString *)baseUrl
{
    _rDotBaseUrl = baseUrl;
    return self;
}

- (instancetype)withBackgroundResourceProvider:(id<BBCSMPBackgroundTaskScheduler>)backgroundTimeProvider
{
    _backgroundResourceProvider = backgroundTimeProvider;
    return self;
}

- (instancetype)withUIComposer:(id<BBCSMPUIComposer>)uiComposer
{
    _uiComposer = uiComposer;
    return self;
}

- (instancetype)withSystemSuspension:(id<BBCSMPSystemSuspension>)systemSuspension {
    _systemSuspension = systemSuspension;
    return self;
}

#pragma mark Private

- (BBCSMPPlayerInitialisationContext*)buildContext
{
    BBCSMPPlayerInitialisationContext* context = [BBCSMPPlayerInitialisationContext new];
    context.nowPlayingInfoCenter = _nowPlayingInfoCenter;

    context.audioManager = _audioManager;
    context.airplayAvailabilityProvider = _airplayAvailabilityProvider;
    context.backgroundStateProvider = _backgroundStateProvider;

    context.playerItemProvider = self.playerItemProvider;

    context.settingsPersistence = [self.settingsPersistenceFactory createWithDefaultValue:_unsetDefaultSubtitlesState];
    context.networkStatusProvider = self.networkStatusProvider ? self.networkStatusProvider : [BBCSMPNetworkStatusManager sharedManager];

    context.volumeProvider = self.volumeProvider ? self.volumeProvider : [BBCSMPSystemVolumeProvider new];

    context.timerFactory = _timerFactory;
    context.suspendRule = _suspendRule;
    
    context.avMonitoringService = _avMonitoringClient;
    context.swiftPeriodicExecutorFactory = _swiftPeriodicExecutorFactory;
    
    if(!_clock) {
        _clock = [BBCSMPNSTimerClock new];
    }
    
    context.clock = _clock;
    
    if (_rDotEnabled && !_avMonitoringClient) {
        BBCSMPRDotCommonAVReporting* telemetryService = [BBCSMPRDotCommonAVReporting new];
        context.avMonitoringService = telemetryService;
        if (_rDotBaseUrl != nil) {
            [telemetryService overrideBaseUrl:_rDotBaseUrl];
        }
    }
    
    context.remoteCommandCenter = _remoteCommandCenter;
    context.backgroundTimeProvider = _backgroundResourceProvider;
    context.interruptionEndedBehaviour = _interruptionEndedBehaviour;
    context.uiComposer = _uiComposer;
    context.heartbeatGenerator = _heartbeatGenerator;
    context.systemSuspension = _systemSuspension;

    return context;
}



- (id<BBCSMP>)build
{
    BBCSMPPlayer *smp = [[BBCSMPPlayer alloc] initWithContext:[self buildContext]];
    
    [_clock addClockDelegate:smp];
    
    return smp;
}

@end
