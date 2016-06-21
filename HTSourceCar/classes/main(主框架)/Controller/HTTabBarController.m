//
//  HTTabBarController.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTTabBarController.h"
#import "HTNavigationController.h"
#import "HTSourceViewController.h"
#import "HTMineViewController.h"
#import "HTSearchCarViewController.h"


@interface HTTabBarController ()


@end

@implementation HTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建子控制器
    [self CreateChildViewControllers];
    
}

//创建子控制器
- (void)CreateChildViewControllers
{
    //车源
    HTSourceViewController *SourceCarVc = [[HTSourceViewController alloc] init];
    [self addChildViewController:SourceCarVc withTitle:@"车源" image:@"car_link" selectedImage:@"car_hover"];
    
    
    //寻车
    HTSearchCarViewController *SearchCarVc = [[HTSearchCarViewController alloc] init];
    [self addChildViewController:SearchCarVc withTitle:@"寻车" image:@"seach_link" selectedImage:@"seach_hover"];
    
    //我的
//    HTMineViewController *MineVc = [[HTMineViewController alloc] init];
//    [self addChildViewController:MineVc withTitle:@"我的" image:@"my_link" selectedImage:@"my_hover"];
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"mine" bundle:nil];
    
//    HTMineViewController *MineVc = [[HTMineViewController alloc] init];
        [self addChildViewController:sb.instantiateInitialViewController withTitle:@"我的" image:@"my_link" selectedImage:@"my_hover"];
    
    
//    sb.instantiateInitialViewController.title = @"我的";
//    
//    sb.instantiateInitialViewController.tabBarItem.title = nil;
//    sb.instantiateInitialViewController.tabBarItem.image = [UIImage imageNamed:@"my_link"];
//    sb.instantiateInitialViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(9, 0, -9, 0);
//    
//    sb.instantiateInitialViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"my_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    
//    [self addChildViewController:sb.instantiateInitialViewController];
}

//添加子控制器
- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedimageName
{
    //设置主题
    childController.title = title;
    
    //设置tabBar按钮的图片
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.title = nil;
    
    //设置图片内边距
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(9, 0, -9, 0);
    
    //设置选中的图片
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创键导航栏
    HTNavigationController *Nav = [[HTNavigationController alloc] initWithRootViewController:childController];
    
    //添加到控制器
    [self addChildViewController:Nav];
    
}




@end
