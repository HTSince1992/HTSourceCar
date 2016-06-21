//
//  HTResultViewController.m
//  HTSourceCar
//
//  Created by Page on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTResultViewController.h"
#import "HTDisplayCarModel.h"
#import "HTDetailSourceCarController.h"

@interface HTResultViewController ()

@end

@implementation HTResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //重用表示
    NSString *ID = @"predicate";
    
    //获取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    //设置数据
    HTDisplayCarModel *model = self.models[indexPath.row];
    cell.textLabel.text = model.carModel;
    cell.detailTextLabel.text = model.outsideColor;
    
    return cell;
}

//cell的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTDetailSourceCarController *detailVc = [[HTDetailSourceCarController alloc] init];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
