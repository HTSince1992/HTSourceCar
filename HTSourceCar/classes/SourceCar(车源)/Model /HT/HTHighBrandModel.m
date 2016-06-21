//
//  HTHighBrandModel.m
//  HTSourceCar
//
//  Created by Page on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTHighBrandModel.h"

@implementation HTHighBrandModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self ==[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)HighBrandModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
