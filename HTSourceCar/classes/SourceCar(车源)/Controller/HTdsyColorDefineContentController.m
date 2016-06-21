//
//  HTdsyColorDefineContentController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyColorDefineContentController.h"
#import "HTComposeSourceController.h"
@interface HTdsyColorDefineContentController ()

@property(nonatomic,copy) NSString * str;

@property(nonatomic,weak)UITextField * field;
@end

@implementation HTdsyColorDefineContentController

-(instancetype)initWitchString:(NSString*)str{

    if ( self = [super init]) {
        self.str = str;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义内饰颜色";
    //不显示返回文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField * tf = [[UITextField alloc]init];
    
    tf.placeholder =@"请输入自定义内饰颜色";
    tf.backgroundColor = [UIColor colorWithWhite:239/255.0 alpha:1];
    
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(8);
        make.top.equalTo(self.view.mas_top).offset(72);
        make.right.equalTo(self.view.mas_right).offset(-8);
        
        make.height.equalTo(@60);
    }];
    
    
    self.field = tf;
}

//保存按钮
-(void)leftClick{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    NSString * str = [NSString stringWithFormat:@"%@ %@",self.str,self.field.text];
    dict[@"text"] = str;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo:dict];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

//移除通知
-(void)viewDisAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
