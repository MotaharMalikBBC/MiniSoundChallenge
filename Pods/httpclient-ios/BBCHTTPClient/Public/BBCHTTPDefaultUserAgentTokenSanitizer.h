//
//  BBCHTTPDefaultUserAgentTokenSanitizer.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPUserAgentTokenSanitizer.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DefaultUserAgentTokenSanitizer)
@interface BBCHTTPDefaultUserAgentTokenSanitizer : NSObject <BBCHTTPUserAgentTokenSanitizer>

@property (class, nonatomic, readonly) id<BBCHTTPUserAgentTokenSanitizer> defaultTokenSanitizer NS_SWIFT_NAME(default);

@end

NS_ASSUME_NONNULL_END
