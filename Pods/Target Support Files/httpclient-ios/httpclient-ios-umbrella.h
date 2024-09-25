#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BBCHTTPCapturingNetworkObserver.h"
#import "BBCHTTPClient.h"
#import "BBCHTTPConsoleLogger.h"
#import "BBCHTTPConsoleLoggingNetworkObserver.h"
#import "BBCHTTPDefaultNSURLSessionProvider.h"
#import "BBCHTTPDefaultUserAgent.h"
#import "BBCHTTPDefaultUserAgentTokenSanitizer.h"
#import "BBCHTTPDeviceInformation.h"
#import "BBCHTTPError.h"
#import "BBCHTTPFileLogger.h"
#import "BBCHTTPFileLoggingNetworkObserver.h"
#import "BBCHTTPImageResponseProcessor.h"
#import "BBCHTTPJSONResponseProcessor.h"
#import "BBCHTTPLibraryUserAgent.h"
#import "BBCHTTPLogger.h"
#import "BBCHTTPLoggingNetworkObserver.h"
#import "BBCHTTPMethod.h"
#import "BBCHTTPMultiTokenUserAgent.h"
#import "BBCHTTPNetworkClient.h"
#import "BBCHTTPNetworkClientAuthenticationDelegate.h"
#import "BBCHTTPNetworkError.h"
#import "BBCHTTPNetworkObserver.h"
#import "BBCHTTPNetworkReachabilityManager.h"
#import "BBCHTTPNetworkReachabilityStatus.h"
#import "BBCHTTPNetworkRequest.h"
#import "BBCHTTPNetworkResponse.h"
#import "BBCHTTPNetworkStatus.h"
#import "BBCHTTPNetworkTask.h"
#import "BBCHTTPNetworkURLRequestBuilder.h"
#import "BBCHTTPNSURLSessionProviding.h"
#import "BBCHTTPOAuthRequestDecorator.h"
#import "BBCHTTPReachability.h"
#import "BBCHTTPReachabilityDeviceSpecific.h"
#import "BBCHTTPRequest.h"
#import "BBCHTTPRequestDecorator.h"
#import "BBCHTTPResponse.h"
#import "BBCHTTPResponseProcessor.h"
#import "BBCHTTPSAMLRequestDecorator.h"
#import "BBCHTTPStringUserAgent.h"
#import "BBCHTTPTask.h"
#import "BBCHTTPURLRequestBuilder.h"
#import "BBCHTTPUserAgent.h"
#import "BBCHTTPUserAgentToken.h"
#import "BBCHTTPUserAgentTokenSanitizer.h"
#import "BBCHTTPVersion.h"
#import "HTTPClientDefines.h"
#import "HTTPClient.h"

FOUNDATION_EXPORT double HTTPClientVersionNumber;
FOUNDATION_EXPORT const unsigned char HTTPClientVersionString[];

