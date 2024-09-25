//
//  BBCSMPItemProvider.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBCSMPItemPreloadMetadata;
@protocol BBCSMPItem;
@protocol BBCSMPAVStatisticsConsumer;

typedef void (^BBCSMPItemProviderSuccess)(id<BBCSMPItem> _Null_unspecified playerItem);
typedef void (^BBCSMPItemProviderFailure)(NSError* _Null_unspecified error);
typedef void (^BBCSMPItemProviderPreloadMetadataSuccess)(BBCSMPItemPreloadMetadata* _Null_unspecified preloadMetadata);

@protocol BBCSMPItemProvider <NSObject>

@property (strong, nonatomic, readonly) _Null_unspecified id<BBCSMPAVStatisticsConsumer> avStatisticsConsumer;

- (void)requestPreloadMetadata:(_Null_unspecified BBCSMPItemProviderPreloadMetadataSuccess)success failure:(_Null_unspecified BBCSMPItemProviderFailure)failure NS_SWIFT_NAME(requestPreloadMetadata(success:failure:));

- (void)requestPlayerItem:(_Null_unspecified BBCSMPItemProviderSuccess)success failure:(_Null_unspecified BBCSMPItemProviderFailure)failure NS_SWIFT_NAME(requestPlayerItem(success:failure:));

/**
 Provide items for SMP to play when the initial item provided by requestPlayerItemProvider:failure: fails to
 play. Provide an error in the failure callback to signal there are no more available items to attempt
 playback with.
 */
- (void)requestFailoverPlayerItem:(_Null_unspecified BBCSMPItemProviderSuccess)success failure:(_Null_unspecified BBCSMPItemProviderFailure)failure NS_SWIFT_NAME(requestFailoverPlayerItem(success:failure:));

- (void)requestNextCaptionsItem:(nonnull BBCSMPItemProviderSuccess)success failure:(nonnull BBCSMPItemProviderFailure)failure NS_SWIFT_NAME(requestNextCaptionsItem(success:failure:));

@optional
- (NSTimeInterval) initialPlayOffset;

@end
