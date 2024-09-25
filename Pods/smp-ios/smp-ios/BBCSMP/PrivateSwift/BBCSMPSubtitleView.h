//
//  BBCSMPSubtitleView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPSubtitleScene.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPSubtitlesUIConfiguration;

@protocol BBCSMPSubtitleColorParsing <NSObject>

- (nonnull UIColor*)colorFromString:(nullable NSString*)name;

@end

@interface BBCSMPSubtitleColorParser : NSObject <BBCSMPSubtitleColorParsing>

@end

@protocol BBCSMPSubtitleStyle;

typedef id<BBCSMPSubtitleStyle> _Nonnull (^BBCSMPSubtitleStyleBuilder)(NSMutableDictionary *styles);

@interface BBCSMPSubtitleView : UIView <BBCSMPSubtitleObserver, BBCSMPSubtitleScene>

@property (nonatomic, strong, nullable) id<BBCSMPSubtitlesUIConfiguration> configuration;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame styleBuilder:(BBCSMPSubtitleStyleBuilder)styleBuilder NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
