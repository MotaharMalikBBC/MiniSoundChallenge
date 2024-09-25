//
//  BBCSMPControllable.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@class BBCSMPBitrate;
@protocol BBCSMPItemProvider;
@class BBCSMPRate;

@protocol BBCSMPControllable <NSObject>

@property (nonatomic, strong) id<BBCSMPItemProvider> _Nullable playerItemProvider;

@property (nonatomic, strong) BBCSMPRate * _Nonnull targetRate;

- (void)prepareToPlay;
- (void)play;
- (void)pause;
- (void)stop;
- (void)scrubToPosition:(NSTimeInterval)position NS_SWIFT_NAME(scrub(to:));
- (void)activateSubtitles;
- (void)deactivateSubtitles;
- (void)transitionToPictureInPicture;
- (void)exitPictureInPicture;
- (void)limitMaximumPeakPlaybackBitrateToBitrate:(BBCSMPBitrate * _Nonnull)maximumPeakPlaybackBitrate;
- (void)removeMaximumPeakPlaybackBitrateLimit;

@end
