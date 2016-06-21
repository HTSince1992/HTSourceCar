//
//  LZSiftResultFootView.m
//  HTSourceCar
//
//  Created by 张 on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZSiftResultFootView.h"
#import "LZSearchCarModel.h"
#import "UIImageView+WebCache.h"

@interface LZSiftResultFootView()
@property(nonatomic,weak)UILabel *userNameLab;
@property(nonatomic,weak)UIImageView *userimage;
@property(nonatomic,weak)UILabel *phoneLabel;
@property(nonatomic,weak)UIButton *callBtn;
@end

@implementation LZSiftResultFootView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
#pragma mark - 头像
        
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *userImage = [[UIImageView alloc]init];
        userImage.image = [UIImage imageNamed:@"photo-w134h139"];
        //[userImage sizeToFit];
        
        userImage.layer.cornerRadius = 25;
        userImage.layer.masksToBounds = YES;
        
        
        
        [self addSubview:userImage];
        self.userimage = userImage;
        
        [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
            
        }];
        
        
#pragma mark - username;
        
        UILabel *userNameLab = [[UILabel alloc]init];
        
        
        userNameLab.font = [UIFont systemFontOfSize:14];
        
        
        [self addSubview:userNameLab];
        self.userNameLab = userNameLab;
        
        if(iPhone5){
            
            [userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(self.userimage.mas_right).offset(10);
                
                make.top.mas_equalTo(_userimage.mas_top);
                // make.width.mas_equalTo(100);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(60);
              //  make.right.mas_equalTo(self.callBtn.mas_left).offset(-5);
                
            }];
            
            
        }else{
            [userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(userImage.mas_right).offset(20);
                
                make.top.mas_equalTo(userImage.mas_top);
                // make.width.mas_equalTo(100);
                make.height.mas_equalTo(30);
                
            }];

        
        
        }

        
        
#pragma mark - userphone
        UILabel *phoneLabel = [[UILabel alloc]init];
        
        [self addSubview:phoneLabel];
        
        self.phoneLabel = phoneLabel;
        
        phoneLabel.font = [UIFont systemFontOfSize:14];
        
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(userImage.mas_bottom);
            
            make.left.mas_equalTo(userNameLab.mas_left);
            
            make.height.mas_equalTo(20);
            
        }];

        
        
#pragma mark - 收藏按钮
        UIButton *pickupBtn = [[UIButton alloc]init];
        [pickupBtn setTitle:@"收藏" forState:UIControlStateNormal];
        
        [pickupBtn setBackgroundColor:LXRGBColor(227, 74, 81)];
        
        [pickupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        pickupBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:pickupBtn];
        
        //添加点击事件
        [pickupBtn addTarget:self action:@selector(pickupBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [pickupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.mas_right).offset(-10);

            make.width.mas_equalTo(60);
            
            make.height.mas_equalTo(30);
            
            make.centerY.mas_equalTo(self.mas_centerY);
            
        }];
        
        
#pragma mark - 打电话按钮
        UIButton *callBtn = [[UIButton alloc]init];
        
        [callBtn setTitle:@"电话" forState:UIControlStateNormal];
        
        [callBtn setBackgroundColor:LXRGBColor(227, 74, 81)];
        callBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //添加打电话
        [callBtn addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:callBtn];
        self.callBtn = callBtn;
        
        [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(pickupBtn.mas_left).offset(-10);
            make.centerY.mas_equalTo(pickupBtn.mas_centerY);
            
            make.width.mas_equalTo(pickupBtn.mas_width);
            
            make.height.mas_equalTo(pickupBtn.mas_height);
            
        }];
        
        
    }
    
    return self;
}

-(void)setSearchCarModel:(LZSearchCarModel *)SearchCarModel{
    _SearchCarModel = SearchCarModel;
    
    if (SearchCarModel.userHeader != nil) {
        NSURL *url = [NSURL URLWithString:SearchCarModel.userHeader];
        
        [self.userimage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"man1"]];
        
    }
    
    self.userNameLab.text = [NSString stringWithFormat:@"%@ (%@)",SearchCarModel.userName,SearchCarModel.city];
    
    self.phoneLabel.text = SearchCarModel.userPhone;
    
}

-(void )call{
    
    UIApplication *app = [UIApplication sharedApplication];
    
    NSString *number = [NSString stringWithFormat:@"tel://%@",self.SearchCarModel.userPhone];
    
    NSURL *url = [NSURL URLWithString:number];
    
    [app openURL:url];
    
    
}
-(void)setHostName:(NSString *)hostName{
    


    _hostName = hostName;
    
    self.userimage.image = [UIImage imageNamed:@"man"];
    //[cell.imageView sizeToFit];
    self.userNameLab.text = self.hostName;
    self.phoneLabel.text = @"18233116914";
    
    

}
-(void)pickupBtnClick{

    NSString *str = @"defaultaleatAction";
    
    [[NSNotificationCenter defaultCenter ]postNotificationName:@"defaultaleat" object:str];
    


}

@end
