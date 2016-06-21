//
//  HTdsyCarTypeController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyCarTypeController.h"
#import "HTComposeSourceController.h"

@interface HTdsyCarTypeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * tempArray;
@end

@implementation HTdsyCarTypeController

//选择车型
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title  =@"选择车型";
    //不显示返回文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //选择车源类型
    self.tempArray = @[@{@"name":@"不限"},
                       @{@"name":@"国产"},
                       @{@"name":@"进口中规"},
                       @{@"name":@"美规"},
                       @{@"name":@"中东"}
                       ];
}

//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tempArray.count;
    
}
//cell样子
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellID = @"HTdsyCarTypeContrcell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
        NSDictionary * dic = self.tempArray[indexPath.row];
    
        
        //赋值
        cell.textLabel.text = dic[@"name"];
//        cell.detailTextLabel.text = dic[@"carLineName"];
    
        
        
    }
 
    return cell;
}

#pragma mark --- 跳转 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSString * str = cell.textLabel.text;
    dict[@"text"] = str;
    //发布通知传值;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo: dict];

[self.navigationController popToRootViewControllerAnimated:YES];
}
//移除通知
-(void)viewDisAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
