//
//  HTComposeTableViewCell.m
//  HTSourceCar
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTComposeTableViewCell.h"


@interface HTComposeTableViewCell ()<UITextViewDelegate>



@end

@implementation HTComposeTableViewCell


//发布车源 cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        [self setUPUI];
        [self getzzView];
    }
    return self;
}




-(void)layoutSubviews{
    [super layoutSubviews];
    
   
    //设置约束
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    //添加cell 中心lable
    
    [ self.massageLb  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(110);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
        
    }];
    
    //添加中心textField
    
    [self.txtf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(110);
//        make.height.mas_equalTo(30);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.centerY.equalTo(self.contentView.mas_centerY);
    make.right.mas_equalTo(-110);
    }];
    
    //添加线条
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(110);
        make.top.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
        make.right.equalTo(self.contentView.mas_right).offset(-50)
        ;    }];
    
    //添加右向图片
    
    [self.imag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        
    }];
    
//    //添加右UISwitch
    
    [self.sw  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
//添加右lb
    
    [self.rightLb  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
}

-(void)setUPUI{
    
    UILabel * titleLb = [[UILabel alloc]init];
    titleLb.textColor = [UIColor blackColor];
    titleLb.font  = [UIFont systemFontOfSize:20];
    self.titleLb = titleLb;
    
    UILabel * massageLb = [[UILabel alloc] init];
    massageLb.font = [UIFont systemFontOfSize:14];
    massageLb.textColor = [UIColor grayColor];
   
    self.massageLb = massageLb;
    

    UITextField* txtf = [[UITextField alloc] init];
//    if (txtf.tag == 4) {
//        txtf.placeholder = @"例:30.2";
//    }else if(txtf.tag ==5){
//        txtf.placeholder = @"例:下8或者下10点";
//    }else{
//        txtf.placeholder = @"";
//    }
    
    txtf.font = [UIFont systemFontOfSize:14];
    txtf.textColor = [UIColor blackColor];
    txtf.returnKeyType=UIReturnKeyDone;
 
    self.txtf = txtf;
    
    UIImageView * imag = [[UIImageView alloc] init];
    imag.image = [UIImage imageNamed:@"jiantou-w16h30"];
    [imag sizeToFit];
    self.imag = imag;
    
    UISwitch * sw = [[UISwitch alloc] init];
    self.sw = sw;

    
    //创建底部蓝色的线条
    UIView * line = [UIView new];
    line.backgroundColor = [UIColor blueColor];
     self.line = line;
    
    //添加右lb
    UILabel * rightLb = [[UILabel alloc]init];
    rightLb.font = [UIFont systemFontOfSize:14];
    rightLb.textColor = [UIColor blackColor];
    self.rightLb = rightLb;
    
   
    [self.contentView addSubview:self.titleLb];//101
    [self.contentView addSubview:self.massageLb];//102
    [self.contentView addSubview:self.txtf];//103
    [self.contentView addSubview:self.imag];//104
    [self.contentView addSubview:self.sw];//105
    [self.contentView addSubview: self.line];//106
    [self.contentView addSubview: self.rightLb];//107
    
    
    
    
    
}

-(void)getzzView{

    self.zzView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    self.zzView.alpha = 0.1;
    [self.contentView addSubview: self.zzView];
    [self.contentView bringSubviewToFront: self.zzView];
    //        cell.selected = NO;
    self.backgroundColor = [UIColor whiteColor];

}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated

{
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated

{
}
@end
