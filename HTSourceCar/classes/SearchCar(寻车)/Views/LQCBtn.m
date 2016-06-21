//
//  LQCBtn.m
//  HTSourceCar
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LQCBtn.h"
#import "UIView+LZExtension.h"

@implementation LQCBtn

-(void)layoutSubviews
{
    [super layoutSubviews];
    //image 的位置
    self.imageView.X = WIDTH - 30;
    
    //text的位置
    
    self.titleLabel.X = 10;
    
}

@end
