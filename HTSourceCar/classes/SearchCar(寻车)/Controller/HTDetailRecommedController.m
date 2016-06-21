//
//  HTDetailRecommedController.m
//  HTSourceCar
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTDetailRecommedController.h"
#import "LQCFootView.h"
#import "LZSiftResultFootView.h"

@interface HTDetailRecommedController ()

@property (nonatomic, strong) NSArray *arr;
@end

@implementation HTDetailRecommedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *color = [self.sourceDic[@"color"] length] ? self.sourceDic[@"color"] : @"不限";
    //CGFloat p = self.superCell.myPrice * 10000 + 80000 + arc4random() % 100 * 10;
    
    NSString *price = self.superCell.myPrice == 0 ? @"不限" :[NSString stringWithFormat:@"%0.0f", self.superCell.myPrice * 10000 + 80000 + arc4random() % 100 * 10];
    NSString *pr = self.superCell.price.text ? : @"不限";
    
    _arr =  @[@"082700001",pr,color, @"全国",price];
    
    //左item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete(sift)--w24h24"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self setHeadView];
    [self setFootView];
}

#pragma mark - 创建headView
-(void)setHeadView
{
    
    //设置headView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 145)];
    headView.backgroundColor = LXRGBColor(60, 130, 220);
    
    UILabel *midleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH - 40, 64)];
    
    midleLabel.numberOfLines = 0;
    
    midleLabel.text = @"您的寻车信息已发布成功,经过系统匹配,和您需求最相似的车源信息是:";
    
    [headView addSubview:midleLabel];
    
    //车型
    UILabel *carLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 74, WIDTH - 80, 25)];
    
    carLabel.text = self.sourceDic[@"carSeries"];
    
    [headView addSubview:carLabel];
    
    //型号
    UILabel *carmodel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 80, 74, 60, 25)];
    
    carmodel.text = self.sourceDic[@"type"];
    
    carmodel.textAlignment = 2;
    
    [headView addSubview:carmodel];
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, WIDTH * 0.5, 25)];
    
    timeLabel.text = self.superCell.time.text;
    
    [headView addSubview:timeLabel];
    
    //时间
    UILabel *downLoadcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.5, 110, WIDTH * 0.5 - 20, 25)];
    
    downLoadcountLabel.text = self.superCell.guidPrice.text;
    
    downLoadcountLabel.textAlignment = 2;
    
    [headView addSubview:downLoadcountLabel];
    
    self.tableView.tableHeaderView = headView;
    
}

-(void)leftItemClick
{
    NSDictionary *temDic = @{
                             @"mark" : self.title,
                             @"content" : @"nimei"
                             };
    //创建通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
}
#pragma mark - 创建footView
-(void)setFootView{
    
//    LQCFootView *footView = [[LQCFootView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 270)];
//    
//    footView.hostName = self.superCell.hostName.text;
    
//    self.tableView.tableFooterView = footView;
    
    LZSiftResultFootView *footView = [[LZSiftResultFootView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    
        footView.hostName = self.superCell.hostName.text;
    
       self.tableView.tableFooterView = footView;
}

#pragma mark - datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"nimei";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"车源编号   %@", _arr[index]];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"成交价格   %@", _arr[index]];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"车辆颜色   %@", _arr[index]];
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"销售区域   %@", _arr[index]];
            break;
        case 4:
            cell.textLabel.text = [NSString stringWithFormat:@"备注           加配后的指导价为:%@", _arr[index]];
            cell.detailTextLabel.text = @"                  有意者,请尽快联系";
            break;
            
        default:
            break;
    }
    
    cell.userInteractionEnabled = NO;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"    联系人";
   // lab.backgroundColor = LXRGBColor(236, 236, 236);
    
    return lab;
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    
    return 40;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (iPhone5) {
        
        if (indexPath.row == 4) {
            
            return 50;
        }else{
        
            return 40;
        
        }
        
    }else{
        if (indexPath.row == 4) {
            return 80;
        }else{
        
        
            return 60;
        }
    
    
    }


}
-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
