//
//  HTLogOnViewController.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTLogOnViewController.h"
#import <Masonry.h>
#import "HTNetworkTool.h"
#import "NSString+Hash.h"
#import "HTTabBarController.h"
#import "Masonry.h"
#import <SVProgressHUD.h>
#import "HTForgetPWDController.h"

@interface HTLogOnViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
//app主题
@property (nonatomic,strong) UILabel *titleLabel;

//图标
@property (nonatomic,strong) UIImageView *iconView;

//用户头像
@property (nonatomic,strong) UIImageView *UsericonView;

//手机号
@property (nonatomic,strong) UITextField *NumField;

//密码图片
@property (nonatomic,strong) UIImageView *passwordView;

//密码
@property (nonatomic,strong) UITextField *passwordField;

//登录按钮
@property (nonatomic,strong) UIButton *LogBtn;

//checkout按钮
@property (nonatomic,strong) UIButton *checkoutBtn;

//记忆密码
@property (nonatomic,strong) UILabel *rememberPwd;

//忘记密码
@property (nonatomic,strong) UIButton *ForgetPWD;

//下划线
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;

@property (nonatomic,strong) UIImageView *hook;

@property (nonatomic,strong) UILabel *protocol;

@end

@implementation HTLogOnViewController


#pragma mark:--viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    //获取chechout按钮的状态
    BOOL isSelected = [[NSUserDefaults standardUserDefaults] boolForKey:@"checkoutBtnSelected"];
    
    //如果是选中状态就显示密码
    if (isSelected) {
        self.checkoutBtn.selected = YES;
        self.passwordField.text = @"123456";

    }else{
        //否则质控
        self.passwordField.text = nil;
    }

}
#pragma mark:--viewDidLoad
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //取出按钮的状态
//    BOOL *btnsSelected = 
    
    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建登录页面
    [self setupLogVc];
    
    //监听键盘弹出、
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark:--监听键盘弹出或者消失调用的方法
-(void)keyboard:(NSNotification *)Notification{

    if ([Notification.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        
        [UIView animateWithDuration:0.2 animations:^{
           
            self.view.frame = CGRectMake(0, -104, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else if ([Notification.name isEqualToString:@"UIKeyboardWillHideNotification"]){

        self.view.frame = [UIScreen mainScreen].bounds;
    }

}

#pragma mark:--移除通知
-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark:--创建登录页面
- (void)setupLogVc
{
    
    //app主题
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.text = @"";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    [self.view addSubview:titleLabel];
    
    //图标
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    iconView.image = [UIImage imageNamed:@"dl_logo"];
    [self.view addSubview:iconView];
    
    //用户头像
    UIImageView *UsericonView = [[UIImageView alloc] init];
    UsericonView.image = [UIImage imageNamed:@"man"];
    self.UsericonView = UsericonView;
    [self.view addSubview:UsericonView];
    
    //手机号
    UITextField *NumField = [[UITextField alloc] init];
    NumField.text = @"13800111100";
    self.NumField = NumField;
    [self.view addSubview:NumField];
    
    //下划线
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor blackColor];
    self.line1 = line1;
    [self.view addSubview:line1];
    //下划线
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor blackColor];
    self.line2 = line2;
    [self.view addSubview:line2];
    
    
    //密码图片
    UIImageView *passwordView = [[UIImageView alloc] init];
    passwordView.image = [UIImage imageNamed:@"check-w34h34"];
    self.passwordView = passwordView;
    [self.view addSubview:passwordView];
    
    //密码
    UITextField *passwordField = [[UITextField alloc] init];
    
    passwordField.delegate = self;
    passwordField.placeholder = @"请输入密码";
    passwordField.secureTextEntry = YES;
    self.passwordField = passwordField;
    [self.view addSubview:passwordField];
    
    //登录按钮
    UIButton *LogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogBtn.backgroundColor = [UIColor colorWithRed:295/255.0 green:195/255.0 blue:40/255.0 alpha:1];
    self.LogBtn = LogBtn;
    [LogBtn setTitle:@"登录" forState:UIControlStateNormal];
    [LogBtn addTarget:self action:@selector(LogBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    LogBtn.titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:LogBtn];
    
    //checkout按钮
    UIButton *checkoutBtn = [[UIButton alloc] init];
    [checkoutBtn setImage:[UIImage imageNamed:@"zc_select"] forState:UIControlStateSelected];
    [checkoutBtn setImage:[UIImage imageNamed:@"zc_unselect"] forState:UIControlStateNormal];
    [checkoutBtn addTarget:self action:@selector(checkoutBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.checkoutBtn = checkoutBtn;
    [self.view addSubview:checkoutBtn];
    
    //记忆密码
    UILabel *rememberPwd = [[UILabel alloc] init];
    rememberPwd.text = @"记忆密码";
    self.rememberPwd = rememberPwd;
    [self.view addSubview:rememberPwd];
    
    //忘记密码
    UIButton *ForgetPWD = [UIButton buttonWithType:UIButtonTypeCustom];
    [ForgetPWD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //添加点击事件ForgetPWD
    [ForgetPWD addTarget:self action:@selector(ForgetPWDClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [ForgetPWD setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.ForgetPWD = ForgetPWD;
    [self.view addSubview:ForgetPWD];
    
    
    //协议钩子
    UIImageView *hook = [[UIImageView alloc] init];
    self.hook = hook;
    hook.image = [UIImage imageNamed:@"zc_select"];
    [self.view addSubview:hook];
    
    //协议
    UILabel *protocol = [[UILabel alloc] init];
    self.protocol = protocol;
    protocol.text = @"我已经阅读并同意<<条款和隐私协议>>";
    [self.view addSubview:protocol];
    
    //约束控件
    [self constraintsubVies];
}

#pragma mark:--添加点击事件ForgetPWD
- (void)ForgetPWDClicked
{
    HTForgetPWDController *forgetVc = [UIStoryboard storyboardWithName:@"ForgetPWD" bundle:nil].instantiateInitialViewController;
    
    [self.navigationController pushViewController:forgetVc animated:YES];
    
}


#pragma mark:--checkout按钮的点击事件
- (void)checkoutBtnClicked:(UIButton *)btn
{
    //状态反转
    self.checkoutBtn.selected = !self.checkoutBtn.selected;
    
    if (!self.checkoutBtn.selected) {
        self.passwordField.text = @"";
    }
    
    //记录记忆密码按钮的状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //保存按钮的状态
    [defaults setBool:self.checkoutBtn.selected forKey:@"checkoutBtnSelected"];
    
}

#pragma mark:--登录按钮的点击事件
- (void)LogBtnClicked
{
    //密码
    NSString *password = @"123456";
    NSString *PWD = [password md5String];
    
    //输入框的密码
    NSString *inputPassword = [self.passwordField.text md5String];
    
//    1.根据用户名和密码判断是否跳转
    if ([inputPassword isEqualToString:PWD] && [self.NumField.text isEqualToString:@"13800111100"]) {
        
        //        1.0退出键盘
        [self.view endEditing:YES];
        //        1.1弹出遮罩
        [SVProgressHUD showInfoWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeGradient];
        //        1.2模拟网络登陆（延迟一秒登陆）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            HTTabBarController *tabbarVc = [[HTTabBarController alloc] init];
            
            //去首页面
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVc;
            
            //保存用户信息
            [self GetUSerData];
            
        });
        
    }else{
        
        [SVProgressHUD showInfoWithStatus:@"密码错误" maskType:SVProgressHUDMaskTypeGradient];
    }
    
    
}

//约束控件
- (void)constraintsubVies
{
    
    //app主题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //上边50 居中
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.equalTo(@100);
        make.centerX.equalTo(self.view.mas_centerX);
        
    }];
    
    //图标
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上边20  居中
        make.top.equalTo(self.titleLabel.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
        
    }];
    
    //用户头像
    [self.UsericonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左边20 上边100 宽度35高度35
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.iconView.mas_bottom).offset(80);
        make.width.height.equalTo(@35);
        
    }];
    
    //手机号
    [self.NumField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左边10  与头像等Y 宽度 300
        make.left.equalTo(self.UsericonView.mas_right).offset(40);
        make.centerY.equalTo(self.UsericonView.mas_centerY);
        make.width.equalTo(@300);
        
        
    }];
    
    //密码图片
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边20 上边100 宽度35高度35
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.UsericonView.mas_bottom).offset(15);
        make.width.height.equalTo(@35);
        
    }];
    
    //密码
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.passwordView.mas_right).offset(40);
        make.centerY.equalTo(self.passwordView.mas_centerY);
        make.width.equalTo(@300);
        
    }];
    
    //登录按钮
    [self.LogBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上边20 居中 宽度300
        make.top.equalTo(self.passwordView.mas_bottom).offset(25);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@300);
        
    }];
    
    //checkout按钮
    [self.checkoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左边20  上边20  宽度高度35
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.LogBtn.mas_bottom).offset(25);
        make.width.height.equalTo(@35);
        
    }];
    
    //记忆密码
    [self.rememberPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边 10 与checkoutBtn等Y宽度100
        make.left.equalTo(self.checkoutBtn.mas_right).offset(10);
        make.centerY.equalTo(self.checkoutBtn.mas_centerY);
        make.width.equalTo(@100);
        
    }];
    
    //忘记密码
    [self.ForgetPWD mas_makeConstraints:^(MASConstraintMaker *make) {
        //右边20 宽度100 与rememberPwd等Y
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.width.equalTo(@100);
        make.centerY.equalTo(self.rememberPwd.mas_centerY);
        
    }];
    
    //下划线1
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(90);
        make.top.equalTo(self.NumField.mas_bottom).offset(1);
        make.width.equalTo(@200);
        make.height.equalTo(@1);
        
    }];
    //下划线2
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(90);
        make.top.equalTo(self.passwordField.mas_bottom).offset(1);
        make.width.equalTo(@200);
        make.height.equalTo(@1);
    }];
    
    //协议钩子
    [self.hook mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.rememberPwd.mas_bottom).offset(190);
        
        make.left.equalTo(self.view.mas_left).offset(20);
        
        make.width.height.equalTo(@35);
        
        
    }];
    
    //协议
    [self.protocol mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.hook.mas_centerY);
        
        make.left.equalTo(self.hook.mas_right).offset(10);
        
//        make.width.height.equalTo(@35);
        
        
    }];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.passwordField resignFirstResponder];
}

//
//- (void)BtnClicked
//{
//    HTTabBarController *tabVc = [[HTTabBarController alloc] init];
//    
//    [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
//}


//获取用户信息
- (void)GetUSerData
{
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = @"13800111100";
    NSString *password = @"123456";
    params[@"password"] = [password md5String];
    
    [[HTNetworkTool sharedNetWorkTools] objectWithURLString:@"http://iosapi.itcast.cn/car/login.json.php" RequsetOp:@"POST" AndParams:params completeBlock:^(id object) {
        
        NSLog(@"%@",[object class]);
        NSLog(@"%@",object);
        NSDictionary *dict = (NSDictionary *)object;
        NSDictionary *accotDict = dict[@"data"];
        
        HTAccount *account = [HTAccount AccountWithDict:accotDict];
        
        //保存账号
        [HTAccountTool SaveAccount:account];
        
    }];
    
}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    //封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"phone"] = @"13800111100";
//    NSString *password = @"123456";
//    params[@"password"] = [password md5String];
//    
//    [[HTNetworkTool sharedNetWorkTools] objectWithURLString:@"http://iosapi.itcast.cn/car/login.json.php" RequsetOp:@"POST" AndParams:params completeBlock:^(id object) {
//        
//        NSLog(@"%@",[object class]);
//        NSLog(@"%@",object);
//        NSDictionary *dict = (NSDictionary *)object;
//        NSDictionary *accotDict = dict[@"data"];
//        
//        HTAccount *account = [HTAccount AccountWithDict:accotDict];
//        
//        //保存账号
//        [HTAccountTool SaveAccount:account];
//        
//    }];
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    //自动登录
    [self LogBtnClicked];
    
    return YES;
}

//触摸影藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.passwordField resignFirstResponder];
    [self.NumField resignFirstResponder];
}



@end













