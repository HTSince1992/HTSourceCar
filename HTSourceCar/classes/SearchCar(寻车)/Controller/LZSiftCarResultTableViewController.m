//
//  LZSiftCarResultTableViewController.m
//  HTSourceCar
//
//  Created by 张 on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZSiftCarResultTableViewController.h"
#import "LZSearchCarModel.h"
#import  "LZSiftResultHeadView.h"
#import "LZSiftResultFootView.h"
#import "LZparticipationTableViewController.h"

@interface LZSiftCarResultTableViewController ()<UIPopoverPresentationControllerDelegate>

@property(nonatomic,strong)UITableView *participationTab;
@property(nonatomic,assign)BOOL RightItemIsClick;
@property(nonatomic,weak)LZparticipationTableViewController *LZparticipationVC;
@property(nonatomic,weak)UITableView *LZparticipationTab;
@property(nonatomic,weak)UIButton  *rightItemBtn;

@end

@implementation LZSiftCarResultTableViewController


-(void)loadView{

    
    UITableView *tab = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    self.tableView = tab;
    
    

}

-(void)viewWillAppear:(BOOL)animated{


    self.tabBarController.tabBar.hidden = YES;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    self.tableView.rowHeight = 60;
    
    LZSiftResultHeadView * headView = [[LZSiftResultHeadView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    headView.SearchCarModel = self.model;
    
    self.tableView.tableHeaderView = headView;
    
    self.RightItemIsClick = YES;


    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //创建按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn setImage:[UIImage imageNamed:@"more_icon-w30h30"] forState:UIControlStateNormal];
    //为按钮添加点击事件
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //设置frame
    rightBtn.frame = CGRectMake(0, 0, 44, 35);
    //设置按钮的位置右移
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.rightItemBtn = rightBtn;
    
    LZSiftResultFootView  *SiftResultFootView= [[LZSiftResultFootView alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
    
    self.tableView.tableFooterView = SiftResultFootView;
    SiftResultFootView.SearchCarModel = self.model;
    
    //监听通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultaleat:) name:@"defaultaleat" object:nil];
    
}

-(void)defaultaleat:(NSNotification *)NSNotification{
    
    if ([NSNotification.object isEqualToString:@"defaultaleatAction"]) {
        UILabel *view = [[UILabel alloc]init];
        
        
        view.frame = [UIApplication sharedApplication].statusBarFrame;
        
        view.text = @" 收藏成功 \(^o^)/";
        view.textAlignment = NSTextAlignmentCenter;
        view.backgroundColor = [UIColor blackColor];
        view.textColor = [UIColor whiteColor];
        //view.alpha = 0.8;
        
        //[self.navigationController.navigationBar addSubview:view];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    
        [UIView animateWithDuration:1 animations:^{
            view.alpha = 0.6;
            
            [self dismiss];
            
        } completion:^(BOOL finished) {
            view.alpha = 0;

            [view removeFromSuperview];
            
        }];
        

    }else if ( [NSNotification.object isEqualToString:@"identify"]){
    
        [self dismiss];
        
    }
    

}
//-(void)identifyBtn{
//
//    
//    [self dismiss];
//
//
//}

-(void)dealloc{

    //移除 监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)rightBtnClicked:(UIButton *)sender{
    
    if (self.RightItemIsClick == YES) {
        
        [self show];

    }else{
        
        [self dismiss];
    
    }
    
    
}

-(void)show{

    LZparticipationTableViewController *rightViewVc = [[LZparticipationTableViewController alloc]init];
    rightViewVc.tableView.frame = CGRectMake(self.tableView.frame.size.width - 130, 0, 120, 120);
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView addSubview:rightViewVc.tableView];
        
    } completion:nil];
    
    self.LZparticipationVC = rightViewVc;
    
    [self addChildViewController:rightViewVc];
    
    self.LZparticipationTab = rightViewVc.tableView;
    
    self.RightItemIsClick = NO;
    
  [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y - 60)];
    
}
-(void)dismiss{
    
    [self.LZparticipationTab removeFromSuperview];
    
    [self.LZparticipationVC removeFromParentViewController];
    
    self.RightItemIsClick = YES;



}

-(void)setModel:(LZSearchCarModel *)model{
    _model = model;
    
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"对应车型:     %@",self.model.carModelName];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"外观内饰:     %@",self.model.insideColor];
            break;
            
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"上牌城市:     %@",self.model.city];
            break;
            
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"有效期:        %@",self.model.validDay];
            break;
            
            
        case 4:
            cell.textLabel.text  = [NSString stringWithFormat:@"提车价格:    %@",self.model.dealPrice];
            break;
            
        case 5:
            cell.textLabel.text = @"备注:       请在15点之前联系";
            break;
            
            
        default:
            break;
    }
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.userInteractionEnabled = NO;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"   联系人";
    return lab;

}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{

    return 25;
}

@end
