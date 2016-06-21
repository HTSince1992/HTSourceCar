//
//  LZSiftResultHeadView.m
//  HTSourceCar
//
//  Created by 张 on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZSiftResultHeadView.h"
#import "LZSearchCarModel.h"

@interface LZSiftResultHeadView()
@property(nonatomic,weak)UILabel *carNameLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *cityLabel;

@end
/*
 *@interface LZSearchCarModel : NSObject
 //车子名称
 @property(nonatomic,copy)NSString *carModelName;
 @property(nonatomic,copy)NSString *outsideColor;
 @property(nonatomic,copy)NSString *userName;
 @property(nonatomic,copy)NSString *city;
 @property(nonatomic,copy)NSString *createTimeStr;
 
 @property(nonatomic,copy)NSString *validDay;
 //外观内饰
 
 @property(nonatomic,copy)NSString *insideColor;
 //用户头像
 @property(nonatomic,copy)NSString *userHeader;
 @property(nonatomic,copy)NSString *createTime;
 
 */


@implementation LZSiftResultHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *nameLab = [[UILabel alloc]init];
        
        nameLab.textColor = [UIColor blueColor];
        nameLab.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:nameLab];
        self.carNameLabel = nameLab;
        
#pragma mark - name约束
        
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //上
            make.top .mas_equalTo(self.mas_top).offset(5);
            //左
            make.left.mas_equalTo(self.mas_left).offset(25);
            
            make.width.mas_equalTo(self.mas_width);
            
            make.height.mas_equalTo(30);
            
        }];
        
        
        
        UILabel *timerLab = [[UILabel alloc]init];
        timerLab.textColor = [UIColor grayColor];
        timerLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:timerLab];
        
        self.timeLabel  = timerLab;
        
        //#pragma mark-timerLab约束
        
        [timerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //上
            make.top.mas_equalTo(nameLab.mas_bottom).offset(5);
            //左
            make.left.mas_equalTo(nameLab.mas_left);
            
            make.width.mas_equalTo(150);
            
            make.height.mas_equalTo(20);
            
        }];
        
        
        UILabel *cityLab = [[UILabel alloc]init];
        
        cityLab.textColor = [UIColor grayColor];
        cityLab.font = [UIFont systemFontOfSize:16];
        
        
        [self addSubview:cityLab];
        self.cityLabel = cityLab;
        
#pragma mark - 城市约束
        
        [cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.mas_right).offset(-10);
            
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(60);
            
            make.height.mas_equalTo(30);
            
        }];
        
        UIButton *installmentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [installmentsBtn setTitle:@"分" forState:UIControlStateNormal];
        [installmentsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        installmentsBtn.backgroundColor = [UIColor redColor];
        installmentsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:installmentsBtn];
        
#pragma mark -分期按钮---
        [installmentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(timerLab.mas_left);
            make.top.mas_equalTo(timerLab.mas_bottom).offset(10);
            make.width.mas_equalTo(20);
            
            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
            
        }];
        
        UILabel *installmentsLabel = [[UILabel alloc]init];
        
        installmentsLabel.font = [UIFont systemFontOfSize:14];
        
        installmentsLabel.text = @"支持分期";
        
        [self addSubview:installmentsLabel];
        
        
#pragma mark- 分期 label
        
        [installmentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(installmentsBtn.mas_top);
            make.bottom.mas_equalTo(installmentsBtn.mas_bottom);
            make.left.mas_equalTo(installmentsBtn.mas_right).offset(10);
            
        }];
        
        
        
        UIButton *keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [keepBtn setTitle:@"保" forState:UIControlStateNormal];
        
        [keepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [keepBtn setBackgroundColor: LXRGBColor(62, 139, 84)];
        
        keepBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:keepBtn];
        
        [keepBtn mas_makeConstraints:^
         (MASConstraintMaker *make) {
             
             make.top.mas_equalTo(installmentsBtn.mas_top);
             make.left.mas_equalTo(installmentsBtn.mas_right).offset(120);
             
             make.width.mas_equalTo(20);
             make.bottom.mas_equalTo(installmentsBtn.mas_bottom);
             
         }];
        
        
        UILabel *keepLabel = [[UILabel alloc]init];
        
        keepLabel.font = [UIFont systemFontOfSize:14];
        
        keepLabel.text = @"店面承保";
        
        [self addSubview:keepLabel];
        
        
#pragma mark- 分期 label
        
        [keepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(keepBtn.mas_top);
            make.bottom.mas_equalTo(keepBtn.mas_bottom);
            make.left.mas_equalTo(keepBtn.mas_right).offset(10);
            
        }];
        
        
        
        
    }
    
    return self;
    
}
-(void)setSearchCarModel:(LZSearchCarModel *)SearchCarModel{
    
    _SearchCarModel = SearchCarModel;
    
    
    self.carNameLabel.text = SearchCarModel.carModelName;
    
    
    self.timeLabel.text = SearchCarModel.createTimeStr;
    
    self.cityLabel.text = SearchCarModel.city;
    
}

@end
