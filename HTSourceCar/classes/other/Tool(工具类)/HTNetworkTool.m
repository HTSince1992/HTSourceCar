//
//  HTNetworkTool.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTNetworkTool.h"


@implementation HTNetworkTool


//单例对象
+ (instancetype)sharedNetWorkTools
{
    static HTNetworkTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
        //修改响应接收的数据类型,增加一条 @"text/html"
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        _instance.requestSerializer =[AFJSONRequestSerializer serializer];

        
    });
    
    return _instance;
}





//通过传入的URLString去发送网络请求,请求成功通过CompleteBlock传递数据数据
- (void)objectWithURLString:(NSString *)URLString RequsetOp:(NSString *)Option AndParams:(NSDictionary *)params completeBlock:(CompleteBlock)completeBlock
{
    if ([Option isEqualToString:@"GET"]) {//GET请求
        
        //发送请求
        [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功通过CompleteBlock传递数据数据,responseObject此刻已经是字典或是数组,因为AFN默认的反序列化方式就是JSON
            if (completeBlock) {
                completeBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //打印错误信息
            NSLog(@"error===%@",error);
        }];
        
    }else if ([Option isEqualToString:@"POST"]){//POST请求
        
        [self POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (completeBlock) {
                completeBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            //打印错误信息
            NSLog(@"error===%@",error);
        }];
    
    }
    
    
}

@end
