//
//  HTSearchHeadView.h
//  HTSourceCar
//
//  Created by 张 on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTSearchHeadView;
@protocol HTSearchHeadViewDelegate <NSObject>

-(void)HTSearchHeadViewDelegataRefreshData:(HTSearchHeadView *)SearchHeadView AndButtonTag:(NSInteger)tag;

@end

@interface HTSearchHeadView : UIView
@property(nonatomic,weak)id<HTSearchHeadViewDelegate> Refreshdelegate;

@end
