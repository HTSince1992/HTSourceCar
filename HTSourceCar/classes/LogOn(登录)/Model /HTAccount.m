//
//  HTAccount.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTAccount.h"

@implementation HTAccount

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self ==[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)AccountWithDict:(NSDictionary *)dict;
{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"accountid "]) {
        self.accountid = value;
    }
}


//归档
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.accountid  forKey:@"accountid"];
    [encoder encodeObject:self.role  forKey:@"role"];
    [encoder encodeObject:self.releaseCarsourceFlag forKey:@"releaseCarsourceFlag"];
    [encoder encodeObject:self.releaseCarquestFlag forKey:@"releaseCarquestFlag"];
}

//解档
- (id )initWithCoder:(NSCoder *)decoder
{
    if (self == [super init]) {
        self.accountid = [decoder decodeObjectForKey:@"accountid"];
        self.role = [decoder decodeObjectForKey:@"role"];
        self.releaseCarsourceFlag = [decoder decodeObjectForKey:@"releaseCarsourceFlag"];
        self.releaseCarquestFlag = [decoder decodeObjectForKey:@"releaseCarquestFlag"];
    }
    return self;
}


@end
