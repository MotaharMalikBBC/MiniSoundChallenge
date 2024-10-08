//
//  BBCSMPTelemetryErrorManager.m
//  Pods
//
//  Created by Ryan Johnstone on 26/06/2017.
//
//

#import "BBCSMPTelemetryErrorManager.h"
#import "BBCSMPInternalErrorEvent.h"
#import "BBCSMPItemPreloadMetadataUpdatedEvent.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPTime.h"
#import "BBCSMPDuration.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPCommonAVReporting.h"
#import "BBCSMPTelemetryLastRequestedItemTracker.h"
#import "BBCSMPAttemptCDNFailoverEvent.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPTelemetryErrorManager {
    id<BBCSMPCommonAVReporting> _AVMonitoringClient;
    id<BBCSMPSessionInformationProvider> _sessionInformationProvider;
    BBCSMPTelemetryLastRequestedItemTracker *_lastRequestedItemTracker;
    BBCSMPMediaBitrate* _mediaBitrate;
}

- (instancetype)initWithAVMonitoringClient:(id<BBCSMPCommonAVReporting>)AVMonitoringClient
                                  eventBus:(BBCSMPEventBus *)eventBus
                 sessionInformationProvider:(id<BBCSMPSessionInformationProvider>)sessionInformationProvider
                  lastRequestedItemTracker:(BBCSMPTelemetryLastRequestedItemTracker *)lastRequestedItemTracker
{
    self = [super init];
    
    if (self) {
        _AVMonitoringClient = AVMonitoringClient;
        _sessionInformationProvider = sessionInformationProvider;
        
        [eventBus addTarget:self
                   selector:@selector(handleInternalErrorEvent:)
               forEventType:[BBCSMPInternalErrorEvent class]];
        
        [eventBus addTarget:self selector:@selector(reportAttemptingCDNFailover) forEventType:[BBCSMPAttemptCDNFailoverEvent class]];
        [eventBus addTarget:self selector:@selector(reportSeekingTimeOutError) forEventType:[BBCSMPSeekingTimeOutEvent class]];
        
        _lastRequestedItemTracker = lastRequestedItemTracker;
    }
    
    return self;
}

#pragma mark Private

- (void)handleInternalErrorEvent:(BBCSMPInternalErrorEvent *)event
{
    [_AVMonitoringClient trackErrorWithVPID:_lastRequestedItemTracker.vpidForCurrentItem
                                     AVType:_lastRequestedItemTracker.avType
                                 streamType:_lastRequestedItemTracker.streamType
                                currentTime:[[BBCSMPTime alloc] init]
                                   duration:[[BBCSMPDuration alloc] init]
                              seekableRange:[[BBCSMPTimeRange alloc] init]
                                   smpError:event.smpError
                                   supplier:_lastRequestedItemTracker.supplier
                             transferFormat:_lastRequestedItemTracker.transferFormat
                                   mediaSet:_lastRequestedItemTracker.mediaSet
                               mediaBitrate:_mediaBitrate
                            libraryMetadata:[[BBCSMPCommonAVReportingLibraryMetadata alloc] initWithLibraryName:_lastRequestedItemTracker.libraryName andVersion:_lastRequestedItemTracker.libraryVersion]];
}

- (void)reportAttemptingCDNFailover
{
    
    NSError *nsError7200 = [NSError errorWithDomain:BBCSMPErrorDomain code:[BBCSMPErrorCodes attemptingCDNFailover] userInfo:nil];
    BBCSMPError *errorCode7200 = [BBCSMPError recoverableError:nsError7200];
    
    [_AVMonitoringClient trackErrorWithVPID:_lastRequestedItemTracker.vpidForCurrentItem
                                     AVType:_lastRequestedItemTracker.avType
                                 streamType:_lastRequestedItemTracker.streamType
                                currentTime:[[BBCSMPTime alloc] init]
                                   duration:[[BBCSMPDuration alloc] init]
                              seekableRange:[[BBCSMPTimeRange alloc] init]
                                   smpError:errorCode7200
                                   supplier:_lastRequestedItemTracker.supplier
                             transferFormat:_lastRequestedItemTracker.transferFormat
                                   mediaSet:_lastRequestedItemTracker.mediaSet
                               mediaBitrate:_mediaBitrate
                        libraryMetadata:[[BBCSMPCommonAVReportingLibraryMetadata alloc] initWithLibraryName:_lastRequestedItemTracker.libraryName andVersion:_lastRequestedItemTracker.libraryVersion]];
}

- (void)reportSeekingTimeOutError
{
    NSError *nsError7201 = [NSError errorWithDomain:BBCSMPErrorDomain code:[BBCSMPErrorCodes seekTimedOut] userInfo:nil];
    BBCSMPError *error7201 = [BBCSMPError recoverableError:nsError7201];
    [_AVMonitoringClient trackErrorWithVPID:_lastRequestedItemTracker.vpidForCurrentItem
                                     AVType:_lastRequestedItemTracker.avType
                                 streamType:_lastRequestedItemTracker.streamType
                                currentTime:[[BBCSMPTime alloc] init]
                                   duration:[[BBCSMPDuration alloc] init]
                              seekableRange:[[BBCSMPTimeRange alloc] init]
                                   smpError:error7201
                                   supplier:_lastRequestedItemTracker.supplier
                             transferFormat:_lastRequestedItemTracker.transferFormat
                                   mediaSet:_lastRequestedItemTracker.mediaSet
                               mediaBitrate:_mediaBitrate
                            libraryMetadata:[[BBCSMPCommonAVReportingLibraryMetadata alloc] initWithLibraryName:_lastRequestedItemTracker.libraryName andVersion:_lastRequestedItemTracker.libraryVersion]];
}

#pragma mark BBCSMPPlayerBitrateObserver

- (void)playerBitrateChanged:(double)bitrate
{
    _mediaBitrate = [[BBCSMPMediaBitrate alloc] initWithBitrate:bitrate];
}

@end
