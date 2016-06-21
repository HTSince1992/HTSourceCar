//
//  LZSiftResultFootView.h
//  HTSourceCar
//
//  Created by 张 on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZSearchCarModel;

@interface LZSiftResultFootView : UIView
@property(nonatomic,strong)LZSearchCarModel *SearchCarModel;
@property(nonatomic,copy)NSString *hostName;

@end
