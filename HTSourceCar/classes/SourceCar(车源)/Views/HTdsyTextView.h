//
//  HTdsyTextView.h
//  HTSourceCar
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block) ();
/// 自定义个lable
@interface HTdsyTextView : UITextView

@property(nonatomic,copy) void(^block)();

@property(nonatomic,copy) block finsh;
@property(nonatomic,strong) NSString * str ;
///  重绘方法
-(void)need;
@end
