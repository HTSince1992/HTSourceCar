//
//  HTNetworkTool.h
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "AFHTTPSessionManager.h"


typedef void(^CompleteBlock)(id object);

@interface HTNetworkTool : AFHTTPSessionManager


//类方法创建单例对象
+ (instancetype)sharedNetWorkTools;

//通过传入的URLString去发送网络请求,请求成功通过CompleteBlock传递数据数据
- (void)objectWithURLString:(NSString *)URLString RequsetOp:(NSString *)Option AndParams:(NSDictionary *)params completeBlock:(CompleteBlock)completeBlock;

@end
