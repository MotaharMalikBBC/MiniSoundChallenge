//
//  BBCMediaSelectorRequest.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaSelectorRequest.h"
#import "BBCMediaSelectorRequestParameter.h"
#import "BBCMediaSelectorErrors.h"

@interface BBCMediaSelectorRequest ()

@property (copy,nonatomic) NSString *vpid;
@property (copy,nonatomic) NSString *mediaSet;
@property (copy,nonatomic) NSString *protocol;
@property (copy,nonatomic) NSArray *transferFormats;
@property (copy,nonatomic) NSString *ceiling;
@property (nonatomic) BBCMediaSelectorSecureConnectionPreference secureConnectionPreference;
@property (nonatomic, nullable) id<BBCMediaSelectorAuthenticationProvider> authenticationProvider;
@property (nonatomic, nullable) id<BBCMediaSelectorAuthentication> cachedAuthentication;


@end

@implementation BBCMediaSelectorRequest

- (instancetype)initWithRequest:(BBCMediaSelectorRequest *)request
{
    if ((self = [self initWithVPID:request.vpid])) {
        self.mediaSet = request.mediaSet;
        self.protocol = request.protocol;
        self.transferFormats = [NSArray arrayWithArray:request.transferFormats];
        self.ceiling = request.ceiling;
        self.secureConnectionPreference = request.secureConnectionPreference;
        self.authenticationProvider = request.authenticationProvider;
    }
    return self;
}

- (instancetype)initWithVPID:(NSString *)vpid
{
    if ((self = [super init])) {
        self.vpid = vpid;
    }
    return self;
}

- (instancetype)withMediaSet:(NSString *)mediaSet
{
    self.mediaSet = mediaSet;
    return self;
}

- (instancetype)withProtocol:(NSString *)protocol
{
    self.protocol = protocol;
    return self;
}

- (instancetype)withTransferFormats:(NSArray *)transferFormats
{
    self.transferFormats = transferFormats;
    return self;
}

- (instancetype)withCeiling:(NSString *)ceiling
{
    self.ceiling = ceiling;
    return self;
}

- (instancetype)withSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference
{
    self.secureConnectionPreference = secureConnectionPreference;
    return self;
}

- (instancetype)withAuthentication:(id<BBCMediaSelectorAuthentication>)authentication
{
    self.authenticationProvider = nil;
    self.cachedAuthentication = authentication;
    return self;
}

- (instancetype)withAuthenticationProvider:(id<BBCMediaSelectorAuthenticationProvider>)authenticationProvider
{
    self.cachedAuthentication = nil;
    self.authenticationProvider = authenticationProvider;
    return self;
}

- (BOOL)hasMediaSet
{
    return self.mediaSet != nil;
}

+ (NSString*)secureConnectionPreferenceAsString:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference
{
    NSArray<NSString*>* secureConnectionPreferenceStrings = @[@"BBCMediaSelectorSecureConnectionPreferSecure",
                                                              @"BBCMediaSelectorSecureConnectionEnforceSecure",
                                                              @"BBCMediaSelectorSecureConnectionEnforceNonSecure",
                                                              @"BBCMediaSelectorSecureConnectionUseServerResponse"];
    return secureConnectionPreferenceStrings[secureConnectionPreference];
}

- (BOOL)isValid:(NSError * __autoreleasing *)error
{
    if (!_protocol) {
        return YES;
    }
    
    NSArray<NSString*>* compatibleProtocols = nil;
    switch (_secureConnectionPreference) {
        case BBCMediaSelectorSecureConnectionEnforceSecure: {
            compatibleProtocols = @[@"https"];
            break;
        }
        case BBCMediaSelectorSecureConnectionEnforceNonSecure: {
            compatibleProtocols = @[@"http"];
            break;
        }
        case BBCMediaSelectorSecureConnectionPreferSecure: {
            compatibleProtocols = @[@"http", @"https"];
            break;
        }
        case BBCMediaSelectorSecureConnectionUseServerResponse: {
            break;
        }
    }
    BOOL valid = (compatibleProtocols == nil) || [compatibleProtocols containsObject:_protocol];
    if (!valid && error) {
        *error = [NSError errorWithDomain:BBCMediaSelectorClientErrorDomain
                                     code:BBCMediaSelectorClientErrorInvalidRequest
                                 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Specified secure connection preference of %@ is invalid (will always give zero connections) given the requested protocol of %@",[[self class] secureConnectionPreferenceAsString:_secureConnectionPreference],_protocol]}];
    }
    return valid;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[BBCMediaSelectorRequest class]])
        return NO;
    
    BBCMediaSelectorRequest *other = (BBCMediaSelectorRequest *)object;
    if ((_vpid && ![other vpid]) || (!_vpid && [other vpid]) || (_vpid && [other vpid] && ![_vpid isEqualToString:[other vpid]]))
        return NO;
    
    if ((_mediaSet && ![other mediaSet]) || (!_mediaSet && [other mediaSet]) || (_mediaSet && [other mediaSet] && ![_mediaSet isEqualToString:[other mediaSet]]))
        return NO;

    if ((_protocol && ![other protocol]) || (!_protocol && [other protocol]) || (_protocol && [other protocol] && ![_protocol isEqualToString:[other protocol]]))
        return NO;
    
    if ((_ceiling && ![other ceiling]) || (!_ceiling && [other ceiling]) || (_ceiling && [other ceiling] && ![_ceiling isEqualToString:[other ceiling]]))
        return NO;
    
    if (_secureConnectionPreference != [other secureConnectionPreference])
        return NO;

    NSString *transferFormatsAsString = [_transferFormats componentsJoinedByString:@","];
    NSString *otherTransferFormatsAsString = [[other transferFormats] componentsJoinedByString:@","];
    if ((transferFormatsAsString && !otherTransferFormatsAsString) || (!transferFormatsAsString && otherTransferFormatsAsString) || (transferFormatsAsString && otherTransferFormatsAsString && ![transferFormatsAsString isEqualToString:otherTransferFormatsAsString]))
        return NO;
    
    return YES;
}

- (NSArray *)parameters
{
    NSMutableArray *parameters = [NSMutableArray array];
    if (_mediaSet) {
        [parameters addObject:[[BBCMediaSelectorRequestParameter alloc] initWithName:@"mediaset" value:_mediaSet]];
    }
    if (_vpid) {
        [parameters addObject:[[BBCMediaSelectorRequestParameter alloc] initWithName:@"vpid" value:_vpid]];
    }
    if (_protocol) {
        [parameters addObject:[[BBCMediaSelectorRequestParameter alloc] initWithName:@"proto" value:_protocol]];
    }
    if (_transferFormats) {
        for (NSString *transferFormat in _transferFormats) {
            [parameters addObject:[[BBCMediaSelectorRequestParameter alloc] initWithName:@"transferformat" value:transferFormat]];
        }
    }
    if (_ceiling) {
        [parameters addObject:[[BBCMediaSelectorRequestParameter alloc] initWithName:@"ceiling" value:_ceiling]];
    }
    return [NSArray arrayWithArray:parameters];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ <mediaset=%@; vpid=%@, proto(col)=%@, transferformat(s)=%@, ceiling=%@", [super description], _mediaSet, _vpid, _protocol, [_transferFormats componentsJoinedByString:@","], _ceiling];
}

- (id<BBCMediaSelectorAuthentication>)authentication
{
    NSAssert(!self.authenticationProvider, @"Cannot access authentication when the auth provider is non-nil. To nil the provider, first use the provider to obtain an authentication instance then copy your request instance using with(authentication:)");
    
    return self.cachedAuthentication;
}

@end
