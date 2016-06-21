//
//  DSYComposeDataModel.h
//  HTSourceCar
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSYComposeDataModel : NSObject

///  图片
@property(nonatomic,copy)NSString *icon;
///  品牌ID
@property(nonatomic,copy)NSString *brandId;
///

///

///  图片

///  品牌名称
@property(nonatomic,copy)NSString *brandName;

-(instancetype)initWitchDict:(NSDictionary * )dict;
+(instancetype)DSYComposeWitchDict:(NSDictionary *)dict;
@end
