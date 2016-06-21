//
//  HTCarsModel.m
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTCarsModel.h"

@implementation HTCarsModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)CarWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
