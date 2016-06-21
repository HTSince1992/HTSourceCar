//
//  LZSearchCarModel.h
//  HTSourceCar
//
//  Created by 张 on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZSearchCarModel : NSObject
//车子名称
@property(nonatomic,copy)NSString *carModelName;
@property(nonatomic,copy)NSString *outsideColor;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *createTimeStr;

@property(nonatomic,copy)NSString *validDay;
//外观内饰

@property(nonatomic,copy)NSString *insideColor;
//用户头像
@property(nonatomic,copy)NSString *userHeader;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *userPhone;
@property(nonatomic,copy)NSString *dealPrice;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
