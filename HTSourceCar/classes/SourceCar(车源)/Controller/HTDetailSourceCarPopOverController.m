//
//  HTDetailSourceCarPopOverController.m
//  HTSourceCar
//
//  Created by Page on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTDetailSourceCarPopOverController.h"
#import "SVProgressHUD.h"

@interface HTDetailSourceCarPopOverController ()

@end

@implementation HTDetailSourceCarPopOverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"hetao";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell  =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    switch (indexPath.row) {
        case 0:
//            cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
            cell.imageView.image = [UIImage imageNamed:@"car1_icon-w62h62"];
            cell.textLabel.text = @"收藏";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"car2_icon-w62h62"];
            cell.textLabel.text = @"分享";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"car3_icon-w62h62"];
            cell.textLabel.text = @"收定金";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            break;
            
        default:
            break;
    }
    
    return cell;
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
             //收藏点击
            [SVProgressHUD showInfoWithStatus:@"收藏啥啊!赶紧掏钱" maskType:SVProgressHUDMaskTypeBlack];
            
            break;
        case 1:
            //分享点击
            [self shareBtnClicked];
            
            break;
        case 2:
            //收定金点击后弹出UIAlertController
            [self modalnotifiCation];
            
            break;
            
            
        default:
            break;
    }
    
}

//收定金点击后弹出UIAlertController
- (void)modalnotifiCation
{
    //弹出UIAlertController
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"小子!收了钱你的左右肾可就归我了!!!!" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    //取消
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //弄出点事来
        
    }];
    //确定
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弄出点事来
        
    }];
    
    //添加到alerVc
    [alertVc addAction:action1];
    [alertVc addAction:action2];
}

//分享
- (void)shareBtnClicked
{
    //发送分享通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"share" object:nil];
//
    // 分享内容：会根据分享的内容shareArr决定分享弹出框。比如微信6.3.9版本只能分享图片，如果数组中包含了文字和链接，就分享不了啦，坑爹。
//    NSString *shareText  = @"这个是分享文字";
//    NSURL    *shareUrl   = [NSURL URLWithString:@"http://www.baidu.com"];
//    UIImage *iconview = [UIImage imageNamed:@"attention2-w74h74"];
//    NSArray  *shareArr   = @[shareText,shareUrl,iconview];
//    
//    UIActivityViewController *actionHtVc  = [[UIActivityViewController alloc] initWithActivityItems:shareArr applicationActivities:nil];
//    
//    // 分享回调：iOS8以后用completionWithItemsHandler了
//    actionHtVc.completionHandler = ^(NSString *activityType, BOOL completed) {
//        
//        if (completed) {
//            
//            NSLog(@"分享成功");
//        }
//    };
//    
//    // 推出界面
//    [self presentViewController:actionHtVc animated:YES completion:nil];
}


@end
