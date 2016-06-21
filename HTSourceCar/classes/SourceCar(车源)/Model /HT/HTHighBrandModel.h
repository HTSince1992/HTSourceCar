//
//  HTHighBrandModel.h
//  HTSourceCar
//
//  Created by Page on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTHighBrandModel : NSObject

@property (nonatomic,copy) NSString *carBrandId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)HighBrandModelWithDict:(NSDictionary *)dict;

@end
