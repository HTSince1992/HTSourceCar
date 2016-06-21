//
//  HTComposeTableViewCell.h
//  HTSourceCar
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTdsyTextView.h"

@interface HTComposeTableViewCell : UITableViewCell

@property(nonatomic,weak) UILabel *titleLb;
///  创建cell 中心lable
@property(nonatomic,weak)UILabel * massageLb;
///  创建中心textField
@property(nonatomic,weak) UITextField * txtf;
///  创建右向图片
@property(nonatomic,weak) UIImageView * imag;
///  创建右UISwitch
@property(nonatomic,weak) UISwitch * sw;
///  常见蓝色线条
@property(nonatomic,weak) UIView * line;
///  右lable
@property(nonatomic,weak) UILabel * rightLb;

@property(nonatomic,strong) UIView * zzView;




@end
