//
//  LQCTextView.m
//  HTSourceCar
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LQCTextView.h"
#import "UIView+LZExtension.h"

@implementation LQCTextView



-(void)drawRect:(CGRect)rect
{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //自动换行
//    rect.origin.y = 5;
//    
//    rect.origin.x = 5;
    
    //[self.holerString drawInRect:rect withAttributes:dict];
    
    [self.holerString drawAtPoint:CGPointMake(5, 5) withAttributes:dict];
}

-(void)display{
    [self setNeedsDisplay];
}

@end
