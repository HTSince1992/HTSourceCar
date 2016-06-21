//
//  UIView+LZExtension.m
//  百思不得姐
//
//  Created by 张 on 16/3/31.
//  Copyright © 2016年 CZBKZlppig. All rights reserved.
//

#import "UIView+LZExtension.h"

@implementation UIView (LZExtension)


-(CGFloat)width{

    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{

    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;

}


-(CGFloat)height{

    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{

    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;

}

-(CGFloat)X{

    return self.frame.origin.x;

}

-(void)setX:(CGFloat)X{

    CGRect frame = self.frame;
    
    frame.origin.x = X;
    
    self.frame = frame;

}

-(CGFloat)Y{

    return self.frame.origin.y;
    
    
}

-(void)setY:(CGFloat)Y{

    CGRect frame = self.frame;
    
    frame.origin.y = Y;
    
    
    self.frame = frame;


}

-(CGSize)size{

    return self.frame.size;

}

-(void)setSize:(CGSize)size{

    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;


}

@end
