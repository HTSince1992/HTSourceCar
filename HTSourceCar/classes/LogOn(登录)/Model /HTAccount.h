//
//  HTAccount.h
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTAccount : NSObject <NSCoding>

/**
 *  账号Id
 */
@property (nonatomic,copy) NSString *accountid;

@property (nonatomic,copy) NSString *role;

@property (nonatomic,copy) NSString *releaseCarsourceFlag;

@property (nonatomic,copy) NSString *releaseCarquestFlag;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)AccountWithDict:(NSDictionary *)dict;

@end
