//
//  LZSearchCarTableViewCell.h
//  HTSourceCar
//
//  Created by 张 on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZSearchCarModel;
@interface LZSearchCarTableViewCell : UITableViewCell

@property(nonatomic,strong)NSArray *carListArray;
@property(nonatomic,strong)LZSearchCarModel *SearchCarModel;
@end
