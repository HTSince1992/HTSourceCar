//
//  HTAccountTool.h
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTAccount.h"

@interface HTAccountTool : NSObject

+ (void)SaveAccount:(HTAccount *)account;
+ (HTAccount *)GetAcount;

@end
