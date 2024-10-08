//
//  BBCSMPVolumeStatisticsTracer.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 03/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPVolumeStatisticsTracer.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPVolumeObserver.h"
#import "BBCSMPPresentationControllers.h"

@interface BBCSMPVolumeStatisticsTracer () <BBCSMPVolumeObserver>
@end

#pragma mark -

@implementation BBCSMPVolumeStatisticsTracer {
    BBCSMPUserInteractionsTracer *_userInteractionsTracer;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _userInteractionsTracer = context.presentationControllers.userInteractionsTracer;
        [context.player addObserver:self];
    }
    
    return self;
}


#pragma mark BBCSMPVolumeObserver

- (void)playerVolumeChanged:(NSNumber *)volume
{
    [_userInteractionsTracer notifyObserversUsingBlock:^(id<BBCSMPUserInteractionObserver> observer) {
        if ([observer respondsToSelector:@selector(volumeChanged:)]) {
            [observer volumeChanged:volume];
        }
    }];
}

@end
