//
//  BBCSMPPluginEnvironment.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 03/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPButtonPosition.h"
#import "BBCSMPOverlayPosition.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIView;
@class UIViewController;
@protocol BBCSMPControllable;
@protocol BBCSMPObserver;
@protocol BBCSMPPlayerState;
@protocol BBCSMPPlayerObservable;

@protocol BBCSMPPluginEnvironment <NSObject>

- (id<BBCSMPControllable>)playerControl;
- (id<BBCSMPPlayerObservable>)observablePlayer;
- (id<BBCSMPPlayerState>)playerState;

- (void)addButton:(UIView*)button inPosition:(BBCSMPButtonPosition)position NS_SWIFT_NAME(add(button:in:));
- (void)removeButton:(UIView*)button NS_SWIFT_NAME(remove(button:));

- (void)addOverlayView:(UIView*)overlayView inPosition:(BBCSMPOverlayPosition)position NS_SWIFT_NAME(add(overlayView:in:));
- (void)removeOverlayView:(UIView*)overlayView NS_SWIFT_NAME(remove(overlayView:));

- (void)suppressControlAutohideForReason:(NSString*)reason NS_SWIFT_NAME(suppressControlAutohide(forReason:));
- (void)stopSuppressingControlAutohideForReason:(NSString*)reason NS_SWIFT_NAME(stopSuppressingControlAutohide(forReason:));

- (void)leaveFullscreen;

- (void)presentPluginViewController:(UIViewController*)viewControllerToPresent NS_SWIFT_NAME(present(_:));

- (void)setContentFit;
- (void)setContentFill;

@end

NS_ASSUME_NONNULL_END
