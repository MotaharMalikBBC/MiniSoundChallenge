//
//  BBCHTTPDeviceInformation-iOS.m
//  BBCHTTPClient
//
//  Created by Timothy James Condon on 03/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#include <TargetConditionals.h>
#if TARGET_OS_IPHONE

#import "BBCHTTPDeviceInformation.h"
@import UIKit;

@implementation BBCHTTPDeviceInformation

+ (NSString*)deviceSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString*)deviceSystemName
{
    return [UIDevice currentDevice].systemName;
}

@end

#endif
