//
//  HTCarDisplayCell.h
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HTHighBrandModel.h"

@interface HTCarDisplayCell : UITableViewCell

/**
 *  图标
 */
@property (nonatomic,strong) UIImageView *iconview;

/**
 *  车型标签
 */
@property (nonatomic,strong) UILabel *SourceCarType;

/**
 *  箭头
 */
@property (nonatomic,strong) UIImageView *arrowView;

@property (nonatomic,strong) HTHighBrandModel *highBrandModel;

@end
