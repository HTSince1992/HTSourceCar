//
//  HTSourceCarContactCell.m
//  HTSourceCar
//
//  Created by Page on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTSourceCarContactCell.h"

@interface HTSourceCarContactCell ()

//头像
@property (nonatomic,weak) UIImageView *iconImageView;

//姓名
@property (nonatomic,weak) UILabel *nameLabel;

//电话
@property (nonatomic,weak) UIButton *phoneBtn;

//收藏
@property (nonatomic,weak) UIButton *collectBtn;

@end

@implementation HTSourceCarContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //自定义控件
        [self setUI];
    }
    
    return self;
}

- (void)setUI
{
    //头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    //添加到父控件
    [self.contentView addSubview:iconImageView];
    
    //姓名
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    //添加到父控件
    [self.contentView addSubview:nameLabel];
    
    //电话Btn
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn setBackgroundColor:[UIColor colorWithRed:178/225.0 green:60/255.0 blue:60/255.0 alpha:1]];
    self.phoneBtn = phoneBtn;
    //添加到父控件
//    [self.contentView addSubview:phoneBtn];
    
    //收藏Btn
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectBtn setBackgroundColor:[UIColor colorWithRed:178/225.0 green:60/255.0 blue:60/255.0 alpha:1]];
    self.collectBtn = collectBtn;
    //添加到父控件
//    [self.contentView addSubview:collectBtn];
}

//设置子控件约束
- (void)layoutSubviews
{
    //调用父类方法
    [super layoutSubviews];
    
    //头像
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //上边10 左边10 宽高相等
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.height.equalTo(@40);
        
        
    }];
    
    //姓名
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边10 中心等与头像
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        
        
    }];
    
    //收藏
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //右边边10  上边10 宽55 高44
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@55);
        make.height.equalTo(@44);
    }];
    
    //电话
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //右边边10 上边10 宽55 高44
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.collectBtn.mas_left).offset(-10);
        make.width.equalTo(@55);
        make.height.equalTo(@44);
        
        
    }];
    
    
}

//重写模型的属性的set方法,为子控件赋值
- (void)setCarModel:(HTDisplayCarModel *)carModel
{
    _carModel = carModel;
    
    //赋值
    //头像
    self.iconImageView.image = [UIImage imageNamed:@"man"];
    
    //姓名
    self.nameLabel.text = self.carModel.sellerName;
    
    //电话
    [self.phoneBtn setTitle:@"电话" forState:UIControlStateNormal];
    
    //收藏
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
}


@end
