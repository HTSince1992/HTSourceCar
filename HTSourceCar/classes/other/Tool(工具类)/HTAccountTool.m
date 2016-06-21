//
//  HTAccountTool.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#define HTAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"account.data"]

#import "HTAccountTool.h"

@implementation HTAccountTool

//将模型数据account对象归档
+ (void)SaveAccount:(HTAccount *)account
{
    //将模型数据account对象归档
    [NSKeyedArchiver archiveRootObject:account toFile:HTAccountFile];
}

//取出模型数据account对象
+ (HTAccount *)GetAcount
{
    //取出账号
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:HTAccountFile];
}


@end
