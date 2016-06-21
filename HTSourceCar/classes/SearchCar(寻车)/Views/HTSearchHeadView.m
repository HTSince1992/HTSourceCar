//
//  HTSearchHeadView.m
//  HTSourceCar
//
//  Created by 张 on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTSearchHeadView.h"
#import "Masonry.h"
#import "UIView+LZExtension.h"
#import "HTLZImageBtn.h"
//#import "HTMyButton.h"


@interface HTSearchHeadView()
@property(nonatomic,weak)UIButton *releseBtn;
@property(nonatomic,weak)UIButton *referBtn;
@property(nonatomic,weak)UIView *centerLine;
@property(nonatomic,weak)UIView *leftLine;
@property(nonatomic,weak)UIView *rightLine;
@property(nonatomic,strong)UIButton *currentBtn;

@property(nonatomic,assign)NSInteger currentTag;

@end

@implementation HTSearchHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        //创建发布按钮并设置属性
        HTLZImageBtn *releseBtn = [self setBtnWithNormalText:@"新发布" AndHighTexe:nil AndNormalTextColor:LXRGBColor(112, 112, 112) AndHighTextColor:[UIColor blueColor]];
        
        //绑定 tag 值
        releseBtn.tag = 0;
        
        //添加点击事件
        [releseBtn addTarget:self action:@selector(releseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加到父控件并记录
        [self addSubview:releseBtn];
        self.releseBtn = releseBtn;
        //创建提交按钮并设置属性
        HTLZImageBtn *referBtn = [self setBtnWithNormalText:@"已提交" AndHighTexe:nil AndNormalTextColor:LXRGBColor(112, 112, 112) AndHighTextColor:[UIColor blueColor]];
        //绑定 tag 值
        [referBtn setTag:1];
        
        [referBtn addTarget:self action:@selector(referBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加到付控件并设置属性
        [self addSubview:referBtn];
        self.referBtn = referBtn;
        
        //创建定设置三条线
        
        UIView *centerLine = [[UIView alloc]init];
        centerLine.backgroundColor = [UIColor blueColor];
        
        [self addSubview:centerLine];
        self.centerLine = centerLine;
        
        
        UIView *leftLine = [[UIView alloc]init];
        
        leftLine.backgroundColor = [UIColor blueColor];
        
        [self addSubview:leftLine];
        self.leftLine = leftLine;

        UIView *rightLine = [[UIView alloc]init];
        
        rightLine.backgroundColor = [UIColor blueColor];
        
        [self addSubview:rightLine];
        self.rightLine = rightLine;
        
        [self releseBtnClick:self.releseBtn];
        


        
        
        
    }
    
    return self;
}


-(void)setUI
{
    //设置发布按钮位置
    self.releseBtn.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5, 60);
    self.releseBtn.center = CGPointMake(self.center.x * 0.5, self.center.y);
    
    //设置提交按钮位置
    self.referBtn.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5, 60);
    self.referBtn.center = CGPointMake(self.releseBtn.center.x + self.center.x, self.center.y);
    
    
    //中间的线
    
    self.centerLine.bounds = CGRectMake(0, 0, 1, 30);
    self.centerLine.center = CGPointMake(self.center.x, self.center.y);
    
    //下面的线
    self.leftLine.frame = CGRectMake(self.releseBtn.X, self.height, self.releseBtn.width, 1);
    
    self.rightLine.frame = CGRectMake(self.referBtn.X, self.height, self.referBtn.width, 1);
    
    
}

//封装设置按钮属性的方法
-(HTLZImageBtn *)setBtnWithNormalText:(NSString *)Text AndHighTexe:(NSString *)highText AndNormalTextColor:(UIColor*)normalColor AndHighTextColor: (UIColor*)highColor{
    //创建发布按钮
    HTLZImageBtn *releseBtn = [HTLZImageBtn buttonWithType:UIButtonTypeCustom];
    
    [releseBtn setImage:[UIImage imageNamed:@"sanjiao-w37h16"] forState:UIControlStateSelected];
    
    
    //设置属性
    [releseBtn setTitle:Text forState:UIControlStateNormal];
    
    [releseBtn setTitle:highText forState:UIControlStateSelected];
    [releseBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [releseBtn setTitleColor:highColor forState:UIControlStateSelected];
    return releseBtn;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self setUI];
    
}

-(void)releseBtnClick:(UIButton *)send{
    
    self.releseBtn.selected = YES;
    self.referBtn.selected = NO;
    
    
    self.leftLine.hidden = NO;
    self.rightLine.hidden = YES;
    
    
    if ([self.Refreshdelegate respondsToSelector:@selector(HTSearchHeadViewDelegataRefreshData:AndButtonTag:)]) {
        
        [self.Refreshdelegate HTSearchHeadViewDelegataRefreshData:self AndButtonTag:self.releseBtn.tag];
        
    }
}


-(void)referBtnClick:(UIButton *)send{

    self.referBtn.selected = YES;
    self.releseBtn.selected = NO;
    
    self.rightLine.hidden = NO;
    self.leftLine.hidden = YES;

    if ([self.Refreshdelegate respondsToSelector:@selector(HTSearchHeadViewDelegataRefreshData:AndButtonTag:)]) {
        
        [self.Refreshdelegate HTSearchHeadViewDelegataRefreshData:self AndButtonTag:self.referBtn.tag];
       // self.currentTag = self.referBtn.tag;
        
    }
    
    
    
}


@end
