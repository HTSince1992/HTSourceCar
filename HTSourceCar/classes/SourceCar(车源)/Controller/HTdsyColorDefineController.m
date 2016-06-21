//
//  HTdsyColorDefineController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyColorDefineController.h"
#import "HTdsyColorContentController.h"

@interface HTdsyColorDefineController ()

@property(nonatomic,weak)UITextField * fielb;

@property(nonatomic,strong) NSString * brandId;

@end

@implementation HTdsyColorDefineController

-(instancetype)initWithString:(NSString *)brandId{

    if (self  = [super init]) {
        self.brandId = brandId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义外观颜色";
    //不显示返回文字
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField * tf = [[UITextField alloc]init];
    
    tf.placeholder =@"请输入自定义外观颜色";
    tf.backgroundColor = [UIColor colorWithWhite:239/255.0 alpha:1];
    
       [self.view addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(8);
         make.top.equalTo(self.view.mas_top).offset(72);
          make.right.equalTo(self.view.mas_right).offset(-8);
        
        make.height.equalTo(@60);
    }];
    
    self.fielb = tf;
    
}
//保存按钮
-(void)leftClick{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSString * str = self.fielb.text;
    dict[@"text"] = str;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo:dict];
    
    HTdsyColorContentController * con = [[HTdsyColorContentController alloc]initWitchTextString:str and:self.brandId];
    [self.navigationController pushViewController:con animated:YES];
    
}

//移除通知
-(void)viewDisAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
