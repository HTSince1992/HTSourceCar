//
//  HTCarGroup.m
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTCarGroup.h"

@implementation HTCarGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        //模型的嵌套转化
        NSMutableArray *carsmodels = [NSMutableArray array];
        for (NSDictionary *item_dict in dict[@"cars"]) {
            HTCarsModel *model = [HTCarsModel CarWithDict:item_dict];
            [carsmodels addObject:model];
        }
#warning 这里的cars不再装数组了,装模型
        self.cars = carsmodels;
        
    }
    return self;
}

+ (instancetype)CarGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
