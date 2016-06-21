//
//  LQCCustomController.m
//  HTSourceCar
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LQCCustomController.h"

@interface LQCCustomController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation LQCCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置左上角返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_icon-w18h30"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    

    
    // 设置右上角的保存按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemClick)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 84, WIDTH - 40, 90)];
    self.textField.backgroundColor = LXRGBColor(239, 239, 239);
    self.textField.placeholder = self.holdTitle;
    //NSLog(@"%@", self.holdTitle);
    [self.view addSubview:self.textField];
    
}
#pragma mark - 左上角返回点击事件
- (void)backClick
{
// 返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveItemClick
{
    NSDictionary *temDic = @{
                             @"mark" : self.title,
                             @"content" : self.textField.text
                             };
    //创建通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
