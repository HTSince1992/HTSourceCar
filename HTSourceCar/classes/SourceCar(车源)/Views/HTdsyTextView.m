//
//  HTdsyTextView.m
//  HTSourceCar
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyTextView.h"


@implementation HTdsyTextView


-(void)drawRect:(CGRect)rect{

   //[UIColor colorWithWhite:239/255.0 alpha:1]
    if (self.str == nil) {
        return;
    }else{

   //创建属性字典
        NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithWhite:239/255.0 alpha:1]};
    //创建 富文本
    NSMutableAttributedString *  attributed  =  [[ NSMutableAttributedString  alloc]initWithString:self.str];
    //添加属性
    [attributed addAttributes:dic range:NSMakeRange(0, self.str.length)];

    //画
        [attributed drawAtPoint:CGPointMake(2, 8)];
    }
    
   
}
-(void)need{
    [self setNeedsDisplay];
}
@end
