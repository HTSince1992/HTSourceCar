//
//  DSYmain.h
//  HTSourceCar
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSYmain : NSObject

@property(nonatomic,copy)NSString *carLineName;
@property(nonatomic,copy)NSString *carLabelName;
@property(nonatomic,copy)NSString *carBrandId;
@property(nonatomic,copy)NSString *carLineId;


-(instancetype) ininWitchDict:(NSDictionary*)dict;
+(instancetype)DSYmainWitchDict:(NSDictionary *)dict;
@end
