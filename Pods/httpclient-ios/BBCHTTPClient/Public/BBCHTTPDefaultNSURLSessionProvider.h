//
//  BBCHTTPDefaultNSURLSessionProvider.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//
#import "HTTPClientDefines.h"

#import "BBCHTTPNSURLSessionProviding.h"

@protocol BBCHTTPNSURLSessionProviding;

NS_SWIFT_NAME(HTTPSessionProvider)
@interface BBCHTTPDefaultNSURLSessionProvider : NSObject <BBCHTTPNSURLSessionProviding>
@end
