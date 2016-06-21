//
//  HTForgetPWDController.m
//  HTSourceCar
//
//  Created by Page on 16/4/16.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTForgetPWDController.h"
#import <SMS_SDK/SMSSDK.h>
#import "HTTabBarController.h"
#import "MZTimerLabel.h"
#import "SVProgressHUD.h"

@interface HTForgetPWDController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;

@property (weak, nonatomic) IBOutlet UITextField *ConfirmTF;

@property (weak, nonatomic) IBOutlet UIButton *GETBtn;

@property (weak, nonatomic) IBOutlet UITextField *NEWPWD;


@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;

//定时器
@property (nonatomic,strong)  MZTimerLabel *timer;


@end

@implementation HTForgetPWDController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)awakeFromNib
{
    //设置主题
    self.title = @"忘记密码";
    
//    self.NEWPWD.delegate = self;
//    
//    self.phoneNumTF.delegate = self;
//    self.ConfirmTF.delegate= self;
//    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyboard:(NSNotification *)Notification{

    if ([Notification.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
            self.view .frame = CGRectMake(0, -100,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }else if ([Notification.name isEqualToString:@"UIKeyboardWillHideNotification"]){
    
        self.view.frame = [UIScreen mainScreen].bounds;
    
    }
    



}
//获取按钮的点击事件
- (IBAction)GETClick:(UIButton*)btn {
    
    
    btn.selected = !btn.selected;
    
    //判断按钮状态
    if (btn.selected) {
        
        //隐藏按钮
        btn.hidden = btn.selected;
        
        //显示倒计时
        self.TimeLabel.hidden = !btn.selected;
        MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.TimeLabel andTimerType:MZTimerLabelTypeTimer];
        
        [timer setCountDownTime:60];
        
        [timer start];
        
    }
    
    
    
        //获取手机号
        //1. 弹出进度指示器
    
        //Method : 短信验证还是语音验证
        //2. customIdentifier: 申请审核通过后, 才能设置
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (error) {
                NSLog(@"获取验证码失败");
                
                //创建提醒,并且移除秒表,显示重新获取
                [SVProgressHUD showErrorWithStatus:@"获取验证码失败"];
                
                //移除秒表
                self.TimeLabel.hidden = YES;
                [self.timer removeFromSuperview];
                //显示按钮
                btn.selected = NO;
                btn.hidden = NO;
                
            } else {
                NSLog(@"获取验证码成功");
                
#pragma mark:===重置秒表
                [self.timer reset];
                [SVProgressHUD showErrorWithStatus:@"获取验证码成功请等待"];
            
            }
        }];
    
    
}

//提交验证码
- (IBAction)verifyClick:(id)sender {
    
    // 验证码只能验证一次
    [SMSSDK commitVerificationCode:self.ConfirmTF.text phoneNumber:self.phoneNumTF.text zone:@"86" result:^(NSError *error) {
        if (error) {
            NSLog(@"验证失败");
            [SVProgressHUD showErrorWithStatus:@"验证码错误"];
        } else {
            NSLog(@"验证成功");
        
            //验证成功去主页
            HTTabBarController *tabbarVc = [[HTTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVc;
            
        }
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    
    [self.NEWPWD resignFirstResponder];
    
    [self.ConfirmTF resignFirstResponder];
    
    [self.phoneNumTF resignFirstResponder];
    

    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.NEWPWD resignFirstResponder];
    
    [self.ConfirmTF resignFirstResponder];
    
    [self.phoneNumTF resignFirstResponder];
}



@end
