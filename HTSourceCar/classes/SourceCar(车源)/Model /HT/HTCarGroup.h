//
//  HTCarGroup.h
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTCarsModel.h"

@interface HTCarGroup : NSObject

//汽车标题
@property (nonatomic,copy) NSString *title;

//汽车品牌
@property (nonatomic,strong) NSArray *cars;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)CarGroupWithDict:(NSDictionary *)dict;

@end
