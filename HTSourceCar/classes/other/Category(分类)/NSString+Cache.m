//
//  NSString+Cache.m
//  SDwebimage的应用
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSString+Cache.h"

@implementation NSString (Cache)

// 传入一个url法 返回一个获取沙盒路径
-(NSString *) appPath:(NSString *)URLstr{
    //获取字符串的最后部分
    NSString *Urlstr=[URLstr lastPathComponent];
    //获取沙盒路径 Caches的地址 Search 搜索 rDirectories 目录 Domains领土
    NSString *CachesPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //Appending 附加 拼接字符串
    NSString *filePath=[CachesPath stringByAppendingString:Urlstr];
    //返回路径
    return filePath;
}

//传入一个URLString,返回一个保存在沙盒的路径给你
-(NSString *)appPath{
    //获取字符串的最后部分
    NSString *Urlstr= self.lastPathComponent;
    //获取沙盒路径 Caches的地址 Search 搜索 rDirectories 目录 Domains领土
    NSString *CachesPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //Appending 附加 拼接字符串
    NSString *filePath=[CachesPath stringByAppendingString:Urlstr];
    //返回路径
    return filePath;
}
@end
