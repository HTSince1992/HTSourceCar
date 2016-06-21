//
//  HTMyMainController.m
//  HTSourceCar
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTMyMainController.h"
#import "HTLogOnViewController.h"
#import "HTPersonnalDataController.h"
#import "HTNavigationController.h"

@interface HTMyMainController ()<UIAlertViewDelegate>

@end

@implementation HTMyMainController


//-(BOOL)hidesBottomBarWhenPushed
//{
//    return YES;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(ClickRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    


}


//导航栏右边按钮的点击事件
-(void)ClickRightBtn
{
    //创建UIAlertController
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"确定要注销吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    //创建UIAlertAction1
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //创建UIAlertAction2
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HTLogOnViewController *login = [[HTLogOnViewController alloc] init];
        HTNavigationController *lognav = [[HTNavigationController alloc] initWithRootViewController:login];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = lognav;
        
    }];
    
    //添加UIAlertAction
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    
    //pushalertVc
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (!buttonIndex) {
//        
//        HTLogOnViewController *login = [[HTLogOnViewController alloc] init];
//        
//        [UIApplication sharedApplication].keyWindow.rootViewController = login;
//        //self.window.rootViewController = logNav;
//    }
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"personData"]) {
        
        HTPersonnalDataController *pushVc = segue.destinationViewController;
        pushVc.finish = ^(UIImage *image){
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            UIImageView *imageView = [cell viewWithTag:1001];
            imageView.image = image;
            
            imageView.layer.cornerRadius = 50;
            
            imageView.layer.masksToBounds = YES;
            
            [self.tableView reloadData];
        };
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
