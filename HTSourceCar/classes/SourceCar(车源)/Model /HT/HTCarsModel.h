//
//  HTCarsModel.h
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTCarsModel : NSObject
//汽车标志
@property (nonatomic,copy) NSString *icon;

//汽车名字
@property (nonatomic,copy) NSString *name;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)CarWithDict:(NSDictionary *)dict;
@end
