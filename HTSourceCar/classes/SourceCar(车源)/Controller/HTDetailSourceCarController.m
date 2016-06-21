//
//  HTDetailSourceCarController.m
//  HTSourceCar
//
//  Created by Page on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTDetailSourceCarController.h"
#import "HTDetailCarCell.h"
#import "HTSourceCarContactCell.h"
#import <SVProgressHUD.h>
#import "HTDetailSourceCarPopOverController.h"



@interface HTDetailSourceCarController () <UIPopoverPresentationControllerDelegate>

//通过webVoew打电话
@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic ,strong) UIActivityViewController *actionController;

//popoverCOntroller
@property (nonatomic,strong) HTDetailSourceCarPopOverController *contentVC;

@end

@implementation HTDetailSourceCarController

//懒加载webciew
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车源详情";
    
    //设置tableview的cell的选中状态
//    self.view.backgroundColor  = [UIColor redColor];
    //取消cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加导航栏右边的按钮
    [self AddrightBtn];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //接收分享通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSomething) name:@"share" object:nil];
}

//分享通知f方法
- (void)shareSomething
{

    NSLog(@"来分享");
    // 分享内容：会根据分享的内容shareArr决定分享弹出框。比如微信6.3.9版本只能分享图片，如果数组中包含了文字和链接，就分享不了啦，坑爹。
    NSString *shareText  = @"这个是分享文字";
    NSURL    *shareUrl   = [NSURL URLWithString:@"http://www.baidu.com"];
    UIImage *iconview = [UIImage imageNamed:@"attention2-w74h74"];
    NSArray  *shareArr   = @[shareText,shareUrl,iconview];
    
    UIActivityViewController *actionController = [[UIActivityViewController alloc] initWithActivityItems:shareArr applicationActivities:nil];
    self.actionController = actionController;
    
    // 分享回调：iOS8以后用completionWithItemsHandler了
    actionController.completionHandler = ^(NSString *activityType, BOOL completed) {
        
        if (completed) {
            
            NSLog(@"分享成功");
        }
    };
    
    // 推出界面
    [self.contentVC presentViewController:actionController animated:YES completion:nil];

}

//添加导航栏右边的按钮
- (void)AddrightBtn
{
    //创建按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn setTitle:@"..." forState:UIControlStateNormal];
    rightBtn.titleLabel.textColor = [UIColor whiteColor];
    
    //为按钮添加点击事件
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置frame
    rightBtn.frame = CGRectMake(0, 0, 44, 35);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

//导航栏右按钮的点击事件
- (void)rightBtnClicked:(UIButton *)sender
{
    //1. 创建内容控制器
    HTDetailSourceCarPopOverController *contentVC = [HTDetailSourceCarPopOverController new];
    
    self.contentVC = contentVC;
//    contentVC.view.backgroundColor = [UIColor redColor];
    //2. 设置此控制器的呈现样式
    contentVC.modalPresentationStyle = UIModalPresentationPopover;
    
    
    //3. 设置popover相关属性
    UIPopoverPresentationController *popover = contentVC.popoverPresentationController;
    
    
    
//    contentVC.popoverPresentationController.sourceView = self.view;
    
    //4.设置大小
    contentVC.preferredContentSize = CGSizeMake(120, 140);
    
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        //设置指向BarButtonItem
        popover.barButtonItem = self.navigationItem.rightBarButtonItem;
    } else {
        //设置指向自定义视图 --> 传入来源视图的bounds
        popover.sourceView = sender;
        popover.sourceRect = sender.bounds;
    }
    
    //设置Popover代理
    popover.delegate = self;
    
    //4. 模态视图呈现
    [self presentViewController:contentVC animated:YES
                     completion:nil];
}

//此方法,是关闭自适应
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }else{
        return 6;}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"htdetail";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    //第0组
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:
                cell.textLabel.text = @"编号";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%2@",self.carmodel.carId];
                cell.detailTextLabel.textColor = [UIColor blackColor];
                break;
                
            case 2:
                cell.textLabel.text = @"成交价";
                int price2 = [self.carmodel.dealPrice  intValue]/10000;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%02d万",price2];
                
                cell.detailTextLabel.textColor = [UIColor redColor];
                
                
                break;
                
            case 3:
                cell.textLabel.text = @"颜色";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@|%@/%@",self.carmodel.carType,self.carmodel.outsideColor,self.carmodel.insideColor];
                cell.detailTextLabel.textColor = [UIColor blackColor];
                break;
                
            case 4:
                cell.textLabel.text = @"销售区域";
                cell.detailTextLabel.text = self.carmodel.city;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                break;
                
            case 5:
                cell.textLabel.text = @"备注";
                cell.detailTextLabel.text = @"有意者可以尽快联系我,价格可以再商量";
                cell.detailTextLabel.textColor = [UIColor blackColor];
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 0){
        //重用标识
        static NSString *IDD = @"htcontact";
        
        //创建cell
        HTSourceCarContactCell *contactcell = [tableView dequeueReusableCellWithIdentifier:IDD];
        
        if (!contactcell) {
            
            contactcell = [[HTSourceCarContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDD];
        }
        
        //传递模型数据
        contactcell.carModel = self.carmodel;
        
        return contactcell;
        
        
    }
    
    
    //第一行显示的数据
    if (indexPath.section ==0 && indexPath.row == 0) {
        
        //重用标识
        static NSString *IDs = @"htdetail";
        
        //创建cell
        HTDetailCarCell *htcell = [tableView dequeueReusableCellWithIdentifier:IDs];
        
        if (!htcell) {
            
            htcell = [[HTDetailCarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDs];
        }
        
        //传递模型数据
        htcell.DisplayCarModel = self.carmodel;
        
        return htcell;
        
    }else{
        
        return cell;
    }
    
}


//重写set方法,刷新tableview
- (void)setCarmodel:(HTDisplayCarModel *)carmodel
{
    _carmodel = carmodel;
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0  && indexPath.row == 0) {
        return 100;
    }else if (indexPath.section == 1 ){
        return 60;
    
    }else{
        return 44;
    }
}

//设置组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *headerview = [[UIView alloc] init];
    headerview.bounds = CGRectMake(0, 0, self.view.frame.size.width, 44);
    UILabel *titleLabel = [[UILabel alloc] init];
    
    //添加到headerview
    [headerview addSubview:titleLabel];
    
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(20, 0, 100, 44);
    
    if (section == 1) {
        titleLabel.text = @"联系人";
    }
    
    headerview.backgroundColor = [UIColor colorWithRed:76/255.0 green:147/255.0 blue:227/255.0 alpha:1];
    
    return headerview;
}

//组头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }else{
        return 0;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arrayactons = [NSMutableArray array];
    
    if (indexPath.section == 1) {
        UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"电话" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//            NSLog(@"电话");
            
            //点击电话后弹出alertview
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"拨打电话" preferredStyle:UIAlertControllerStyleActionSheet];
            
            //取消
            UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            
            //弹出拨打电话
            UIAlertAction *actionPhone = [UIAlertAction actionWithTitle:@"电话    18500185945" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSLog(@"正在打电话");
                
                //打电话
                NSURL *url = [NSURL URLWithString:@"tel://18500185945"];
                [[UIApplication sharedApplication] openURL:url];
                
                
                
            }];
            
            //添加取消
            [alertVc addAction:actionCancle];
            
            [alertVc addAction:actionPhone];
            
            [self presentViewController:alertVc animated:YES completion:nil];
            

        }];
        
        UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            [SVProgressHUD showInfoWithStatus:@"收藏啥啊!赶紧掏钱" maskType:SVProgressHUDMaskTypeBlack];
        
            
        }];
        
        //添加到数组
        [arrayactons addObject:action2];
        [arrayactons addObject:action1];
        
    }
    
    return arrayactons;
}
-(void)dealloc{

    [[NSNotificationCenter defaultCenter ]removeObserver:self];
}

@end
