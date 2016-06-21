//
//  LZSiftView.h
//  HTSourceCar
//
//  Created by 张 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LZSiftViewdeldelegate <NSObject>

-(void)SiftViewdeldelegate:(NSMutableDictionary*)SearchCarDict;

@end



@interface LZSiftView : UIView
@property(nonatomic,strong)NSMutableDictionary *siftResultDict;
@property(nonatomic,weak)id<LZSiftViewdeldelegate> Siftdeldelegate;
@end
