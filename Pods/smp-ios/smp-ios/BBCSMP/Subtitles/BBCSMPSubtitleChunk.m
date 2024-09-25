//
//  BBCSMPSubtitleChunk.m
//  BBCSMP
//
//  Created by Michael Emmens on 09/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleChunk.h"

@interface BBCSMPSubtitleChunk ()

@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSDictionary* styleDictionary;

@end

@implementation BBCSMPSubtitleChunk

- (instancetype)initWithText:(NSString*)text styleDictionary:(NSDictionary*)styleDictionary
{
    if ((self = [super init])) {
        _text = text;
        _styleDictionary = styleDictionary;
    }
    return self;
}

- (void)modifyText:(NSString*)text
{
    self.text = text;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@:%p, styleDictionary = %@, text = %@>", NSStringFromClass([self class]), self, self.styleDictionary, self.text];
}

- (BOOL)isEqual:(id)other
{
    return self.hash == [other hash];
}

- (NSUInteger)hash
{
    NSString *description = [NSString stringWithFormat:@"<%@:styleDictionary = %@, text = %@>", NSStringFromClass([self class]), self.styleDictionary, self.text];
    return [description hash];
}

@end
