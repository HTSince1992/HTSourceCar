//
//  LZcarBrandIdModel.h
//  HTSourceCar
//
//  Created by 张 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZcarBrandIdModel : NSObject
@property(nonatomic,strong)NSString *carBrandId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *outsideColor;
@property(nonatomic,strong)NSString *city;

@property(nonatomic,assign)NSInteger uid;


-(instancetype)initWithDict:(NSDictionary *)dict WithUid:(NSInteger)uid;

@end
