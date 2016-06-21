//
//  HTDisplayCarModel.m
//  HTSourceCar
//
//  Created by Page on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTDisplayCarModel.h"

@implementation HTDisplayCarModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self ==[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)displayCarModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//截取日期
- (NSString *)createTimeHM
{
    NSRange range = NSMakeRange(5, 11);
    
        NSString *str = [_createTimeHM substringWithRange:range];
    return str;
    
}


@end
