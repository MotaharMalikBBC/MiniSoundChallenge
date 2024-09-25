//
//  BBCSMPLocalItem.h
//  SMP
//
//  Created by Stuart Thomas on 15/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPItem.h"

@interface BBCSMPLocalItem : NSObject <BBCSMPItem>

@property (nonatomic, strong) BBCSMPItemMetadata* _Null_unspecified metadata;
@property (nonatomic, strong) NSURL* _Null_unspecified mediaURL;
@property (nonatomic, strong, nullable) id<BBCSMPDecoder> decoder;
@property (nonatomic, strong, nullable) id<BBCSMPSubtitleProvider> subtitleProvider;

@end
