//
//  HTNavigationController.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTNavigationController.h"

@interface HTNavigationController ()

@end

@implementation HTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //统一设置 item 的颜色
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:LXRGBColor(18, 91, 212)];
    [bar setTintColor:[UIColor whiteColor]];
    
    //设置导航栏主题文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = attrs;
    
    
    //设置返回图片
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"return_icon-w18h30"];
    
    
}


@end
