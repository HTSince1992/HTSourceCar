//
//  LZ participation TableViewController.m
//  HTSourceCar
//
//  Created by 张 on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZparticipationTableViewController.h"
#import "SVProgressHUD.h"
#import "LZparticipationTableViewCell.h"

@interface LZparticipationTableViewController ()

@end

@implementation LZparticipationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.rowHeight = 30;
    
    [self.tableView registerClass:[LZparticipationTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.backgroundColor = [UIColor grayColor];
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    LZparticipationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        cell.myImageView.image = [UIImage imageNamed:@"collect-w36h34"];
        cell.myTexeLabel.text = @"收藏";
       // cell.textLabel.textColor = [UIColor whiteColor];
        
        
        
    }else if (indexPath.row == 1){
        cell.myImageView.image = [UIImage imageNamed:@"share-w34h34"];
        cell.myTexeLabel.text = @"分享";
        //cell.textLabel.textColor = [UIColor whiteColor];
        
        
    }else if (indexPath.row == 2){
        
        
        cell.myImageView.image = [UIImage imageNamed:@"sift_icon-w30h30"];
        cell.myTexeLabel.text = @"收定金";
        //cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    
    
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0) {
        
        [self defaultaleatAction];
    }

    if (indexPath.row == 2) {
        
        [self aleatAction];
        
    }
    
    if (indexPath.row == 1) {
        

    
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            NSString *shareText  = @"这个是分享文字";
            NSURL    *shareUrl   = [NSURL URLWithString:@"http://www.baidu.com"];
            //UIImage  *shareImage = [UIImage imageNamed:@"123"];
            NSArray  *shareArr   = @[shareText,shareUrl];
            
            UIActivityViewController *actionController = [[UIActivityViewController alloc] initWithActivityItems:shareArr applicationActivities:nil];
            
            // 分享回调：iOS8以后用completionWithItemsHandler了
            actionController.completionHandler = ^(NSString *activityType, BOOL completed) {
                
                
                if (completed) {
                    
                    NSLog(@"分享成功");
                }
            };
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 推出界面
                [self presentViewController:actionController animated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"defaultaleat" object:nil];

            });

            

        });
        
        
    }
    
    
    
}

-(void)aleatAction{
    //创建弹框
    //preferredStyle  弹框的样式
    //UIAlertControllerStyleActionSheet 底部弹框
    //  UIAlertControllerStyleAlert    中间弹框
    UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"确定收取定金后，当前寻车信息状态将变更为“ 已收定金 ”状态，请在 “寻车交易”中继续操作其它状态 ？" preferredStyle:UIAlertControllerStyleAlert];
    //创建弹框中的按钮
    UIAlertAction *cancleBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
    
        
    
    }];
    UIAlertAction *identifyBtn = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        

        [[NSNotificationCenter defaultCenter] postNotificationName:@"defaultaleat" object:@"identify"];
        

    }];
    
    //把按钮添加到弹框中
    [alertVc addAction:cancleBtn];
    [alertVc addAction:identifyBtn];
    //弹出弹框
    //completion:标示弹出弹框后要做的事情
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}

-(void)defaultaleatAction{

    NSString *str = @"defaultaleatAction";
    
    [[NSNotificationCenter defaultCenter ]postNotificationName:@"defaultaleat" object:str];
    
    

}
@end
