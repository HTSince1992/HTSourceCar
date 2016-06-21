//
//  LQCRecommendCarSourceContorller.m
//  HTSourceCar
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LQCRecommendCarSourceContorller.h"
#import "LQCrecommendCell.h"
#import "HTDetailRecommedController.h"

@interface LQCRecommendCarSourceContorller ()

@end

@implementation LQCRecommendCarSourceContorller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeadView];
    
    self.tableView.rowHeight = 178;
}
#pragma mark - 创建headView
-(void)setHeadView
{
    //左item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete(sift)--w24h24"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    
    self.navigationItem.leftBarButtonItem =leftItem;
    //设置headView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 120)];
    headView.backgroundColor = LXRGBColor(60, 130, 220);
    
    UILabel *midleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 28, WIDTH - 40, 64)];
    
    midleLabel.numberOfLines = 0;
    
    midleLabel.text = @"您的寻车信息已发布成功,经过系统匹配,和您需求最相似的车源信息是:";
    
    [headView addSubview:midleLabel];
    
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


#pragma mark - dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arc4random() % 5 + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"nimei";
    
    LQCrecommendCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[LQCrecommendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.dic = self.infoDic;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    LQCrecommendCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    HTDetailRecommedController *pushVc = [[HTDetailRecommedController alloc] init];
    pushVc.title = self.title;
    
    pushVc.sourceDic = self.infoDic;
    
    pushVc.superCell = cell;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
