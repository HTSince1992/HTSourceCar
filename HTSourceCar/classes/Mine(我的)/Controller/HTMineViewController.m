//
//  HTMineViewController.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTMineViewController.h"
#import "HTMainSecondTableViewCell.h"
#import "HTMinePersDataTableViewController.h"
#import "HTMainMyConcernViewController.h"
#import "HTMainMyCollectionViewController.h"
#import "HTMainCarDealTableViewController.h"
#import "HTMainFindCarTableViewController.h"
#import "HTMainMyMessageTableViewController.h"
#import "HTMainMySourceTableViewController.h"
@interface HTMineViewController ()<HTMainSecondTableViewCellDelegate>
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation HTMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(ClickRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnClickWithVC) name:@"btnClick" object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)ClickRightBtn{

    NSLog(@"注销当前控制器");

}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 90;
    }else{
        return 50;
    }

}
//加载数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = @"刘文明";
        cell.detailTextLabel.text = @"宝马销售组";
        cell.imageView.image = [UIImage imageNamed:@"man"];
        cell.imageView.frame = CGRectMake(10, 10, 45, 45);
        //是否需要倒圆角
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else if (indexPath.row == 1){
    
    //自定义cell
        HTMainSecondTableViewCell *cell = [[HTMainSecondTableViewCell alloc]init];
        
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HTMainSecondTableViewCell" owner:nil options:nil]lastObject];
        cell.delegate = self;
        return cell;
    }else{
    
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        NSArray *array = @[@"我的关注",@"寻车交易",@"我的收藏",@"系统设置" ];
        cell.textLabel.text = array[indexPath.row - 2];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    
    }



}
//点击cell的跳转事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        HTMinePersDataTableViewController *Tvc = [[HTMinePersDataTableViewController alloc]init];
        [self.navigationController pushViewController:Tvc animated:YES];
    }else if (indexPath.row == 1){
    //第二个cell的三个点击跳转
    
    }else if (indexPath.row == 2){
        HTMainMyConcernViewController *Vc = [[HTMainMyConcernViewController alloc]init];
        [self.navigationController pushViewController:Vc animated:YES];
    
    
    }else if (indexPath.row == 3){
        HTMainCarDealTableViewController *Vc = [[HTMainCarDealTableViewController alloc]init];
        [self.navigationController pushViewController:Vc animated:YES];
    
    
    }else if (indexPath.row == 4){
        HTMainMyCollectionViewController *vc = [[HTMainMyCollectionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    
    
    
    }else if (indexPath.row == 5){
    
    
    
    }



}
-(void)cellWithBtnClick:(HTMainSecondTableViewCell *)second{
    HTMainMySourceTableViewController *cll = [[HTMainMySourceTableViewController alloc] init];
    cll.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:cll animated:YES];
}
-(void)cellWithBtnClick1:(HTMainSecondTableViewCell *)second{
    HTMainMyMessageTableViewController *cell =[[HTMainMyMessageTableViewController alloc]init];
    cell.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:cell animated:YES];


}
-(void)cellWithBtnClick2:(HTMainSecondTableViewCell *)second{
    HTMainFindCarTableViewController *ftvc = [[HTMainFindCarTableViewController alloc]init];
    ftvc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:ftvc animated:YES];

}


//-(void)btnClickWithVC{
//    HTMainMyCollectionViewController *vc = [[HTMainMyCollectionViewController alloc] init];
//    vc.view.backgroundColor = [UIColor greenColor];
//    [self presentViewController:vc animated:YES completion:nil];
//}

@end
