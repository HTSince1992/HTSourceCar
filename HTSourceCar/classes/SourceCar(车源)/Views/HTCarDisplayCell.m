//
//  HTCarDisplayCell.m
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTCarDisplayCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface HTCarDisplayCell ()




@end

@implementation HTCarDisplayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //自定义控件
        [self setUI];
        
    }
    
    return self;
}

- (void)setUI
{
    //图标
    UIImageView *iconview = [[UIImageView alloc] init];
    iconview.contentMode = UIViewContentModeScaleAspectFill;
    self.iconview = iconview;
    
    
    //添加到contentView
    [self.contentView addSubview:iconview];
    
    //车型标签
    UILabel *SourceCarType = [[UILabel alloc] init];
    self.SourceCarType = SourceCarType;
    
    //添加到contentView
    [self.contentView addSubview:SourceCarType];
    
    //箭头
    UIImageView *arrowView = [[UIImageView alloc] init];
    arrowView.image = [UIImage imageNamed:@"jiantou-w16h30"];
    self.arrowView = arrowView;
    
    //添加到contentView
    [self.contentView addSubview:arrowView];
    
    
}

//设置子控件约束
- (void)layoutSubviews
{
    //从写父类方法
    [super layoutSubviews];
    
    //图标约束
    [self.iconview mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边20
        make.left.equalTo(self.contentView.mas_left).offset(20);
        //上边14
        make.top.equalTo(self.contentView.mas_top).offset(14);
        //下边14
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
        make.width.equalTo(self.iconview.mas_height);
        
    }];
    
    //标签约束
    [self.SourceCarType mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //距离图标右边16
        make.left.equalTo(self.iconview.mas_right).offset(16);
        
        //中心与图标对齐
        make.centerY.equalTo(self.iconview.mas_centerY);
        
    }];
    
    //箭头约束
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconview.mas_centerY);
        
        //距离cell右边20
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
        
    }];
    
}

//重写属性的set方法设值
- (void)setHighBrandModel:(HTHighBrandModel *)highBrandModel
{
    _highBrandModel = highBrandModel;
    //图标
    
    if ([highBrandModel.carBrandId isEqual: @"123"] && highBrandModel.carBrandId.length > 0) {
        
        self.iconview.image = [UIImage imageNamed:highBrandModel.url];
    }else{
        [self.iconview sd_setImageWithURL:[NSURL URLWithString:highBrandModel.url]];
    }
    
    
    
    //车型
    self.SourceCarType.text = highBrandModel.name;
    
}

@end














