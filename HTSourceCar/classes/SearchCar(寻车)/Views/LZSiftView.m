////
////  LZSiftView.m
////  HTSourceCar
////
////  Created by 张 on 16/4/13.
////  Copyright © 2016年 Apple.com. All rights reserved.
////

#import "LZSiftView.h"


@interface LZSiftView()
@property(nonatomic,weak)UILabel *label;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *colortext;
@property(nonatomic,copy)NSString *cityText;

@end

@implementation LZSiftView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = LXRGBColor(236, 236, 236);
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = self.bounds;
        
        label.font = [UIFont systemFontOfSize:14];
        
        
        [self addSubview:label];
        // label.text = @"shbkhbhbk";
        
        self.label = label;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //            make.width.mas_equalTo(self.mas_width).offset(- 100);
            make.height.mas_equalTo(self.mas_height);
            make.left.mas_equalTo(self.mas_left).offset(10);
            
        }];
        
        UIButton *deletaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        [deletaBtn setBackgroundImage:[UIImage imageNamed:@"delete_hover"] forState:UIControlStateNormal];
        [deletaBtn setTitle:@"×清空筛选" forState:UIControlStateNormal];
        [deletaBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        deletaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [deletaBtn addTarget:self action:@selector(deletaBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [deletaBtn sizeToFit];
        [self addSubview:deletaBtn];
        
        [deletaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.mas_right);
            make.width.mas_equalTo(80);
            
            make.height.mas_equalTo(self.mas_height);
            
        }];
        
        
    }
    return self;
    
}

-(void)setSiftResultDict:(NSMutableDictionary *)siftResultDict{
    
    _siftResultDict = siftResultDict;
    
    if (siftResultDict[@"name"] != nil) {
        
        self.text = [NSString stringWithFormat:@"筛选条件: %@ ",siftResultDict[@"name"]];
    }else{
        
        self.text = nil;
    }
    
    
    if (siftResultDict[@"color"] != nil && self.text != nil) {
        
        self.text = [NSString stringWithFormat:@"%@| %@",self.text,siftResultDict[@"color"]];
    }else
        if (siftResultDict[@"color"] !=nil ) {
            
            self.text = [NSString stringWithFormat:@"筛选条件: %@",siftResultDict[@"color"]];
        }
    else{
        
        self.text = self.text;
    
    }
    
    if (siftResultDict[@"city"] != nil && self.text != nil ) {
        
        self.text = [NSString stringWithFormat:@"%@| %@",self.text,siftResultDict[@"city"]];
    }else if (siftResultDict[@"city"] != nil){
    
        self.text = [NSString stringWithFormat:@"筛选条件: %@",siftResultDict[@"city"]];
    
    }else{
    
        self.text = self.text;
    
    }
    
    self.label.text = self.text;
    
}
-(void)deletaBtn{
    
    
    LXLogFunc
    
    self.siftResultDict[@"uid"] = @"1";
    
    [self removeFromSuperview];
    
    
    if ([self.Siftdeldelegate respondsToSelector:@selector(SiftViewdeldelegate:)]) {
        
        [self.Siftdeldelegate SiftViewdeldelegate:self.siftResultDict];
        
        
    }
    
    
}
@end
