//
//  HTMainSecondTableViewCell.h
//  HTSourceCar
//
//  Created by 谢亚鹏 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTMainSecondTableViewCell;
@protocol HTMainSecondTableViewCellDelegate <NSObject>

-(void)cellWithBtnClick:(HTMainSecondTableViewCell *)second;
-(void)cellWithBtnClick1:(HTMainSecondTableViewCell *)second;
-(void)cellWithBtnClick2:(HTMainSecondTableViewCell *)second;
@end

@interface HTMainSecondTableViewCell : UITableViewCell

@property (nonatomic,weak)id<HTMainSecondTableViewCellDelegate> delegate;
@end
