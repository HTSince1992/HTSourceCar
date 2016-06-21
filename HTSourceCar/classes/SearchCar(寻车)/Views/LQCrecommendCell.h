//
//  LQCrecommendCell.h
//  HTSourceCar
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQCrecommendCell : UITableViewCell

@property (nonatomic, strong) NSArray *arr;

@property (nonatomic, strong) NSDictionary *dic;

@property(nonatomic, strong) UILabel *price;

@property(nonatomic, strong) UILabel *hostName;

@property(nonatomic, strong) UILabel *carName;

@property(nonatomic, strong) UILabel *guidPrice;

@property(nonatomic, strong) UILabel *time;

@property (nonatomic, assign) CGFloat myPrice;

@end
