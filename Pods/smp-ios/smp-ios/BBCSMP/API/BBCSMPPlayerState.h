//
//  BBCSMPPlayerState.h
//  BBCSMP
//
//  Created by Jon Blower on 06/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCSMPDefines.h"

@class BBCSMPDuration;
@class BBCSMPTime;

@protocol BBCSMPPlayerState <NSObject>

@property (nonatomic, strong, readonly) BBCSMPDuration* duration;
@property (nonatomic, strong, readonly) BBCSMPTime* time;

@end
