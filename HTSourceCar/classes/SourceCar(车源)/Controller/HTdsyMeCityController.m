//
//  HTdsyMeCityController.m
//  HTSourceCar
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyMeCityController.h"

#import "HTdsyCityController.h"

@interface HTdsyMeCityController ()

@property(nonatomic,strong)NSArray* tempCityArray;

@end

@implementation HTdsyMeCityController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self cityList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //刷新界面
    self.navigationItem.title = @"请选择城市名称";
    //不显示返回的文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self andBottomBtn];
    
}

-(void) andBottomBtn{
    CGRect rec = [UIScreen mainScreen].bounds;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, rec.size.height-120, rec.size.width,60)];
    [btn setBackgroundColor:[UIColor colorWithRed:62/255 green:137/255 blue:255/255 alpha:0.5]];
    
    
    //自定控件
    UILabel * la = [[UILabel alloc]init];
    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou-w16h30"]];
    [image sizeToFit];
    
    [btn addSubview:la];
    [btn addSubview:image];
    //设置约束
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn.mas_left).offset(10);
        make.centerY.equalTo(btn.mas_centerY);
        
    }];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_right).offset(-10);
        make.centerY.equalTo(btn.mas_centerY);
        
    }];
    
    la.text = @"自定义区域";
    la.textColor = [UIColor whiteColor];
    la.font = [UIFont systemFontOfSize:18];
    //点击方法
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}

-(void)btnClick{
    
    //跳转到自定义区域
    HTdsyCityController *city = [[ HTdsyCityController alloc]init];
    
    [self.navigationController pushViewController:city animated:YES];
    
}
//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tempCityArray.count;
    
    
}
//cell样子
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellID = @"HTdsyCarSoureccell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        //设置右箭头
        UIImageView * im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou-w16h30"]];
        cell.accessoryView =im;
        
        NSDictionary * dic = self.tempCityArray[indexPath.row];
        
        //赋值
        cell.textLabel.text = dic[@"attrName"];
    }
    
    return cell;
}
//点击cell调回主界面
#pragma mark ----- 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [ tableView cellForRowAtIndexPath:indexPath ];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    NSString * str = [NSString stringWithFormat:@"%@",cell.textLabel.text];
    dict[@"text"] = str;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo:dict];
    
    [self.navigationController  popToRootViewControllerAnimated:YES];
    
    
}


//	发布时城市列表

-(void) cityList{
    //http://iosapi.itcast.cn/car/bandcity.json.php
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //用户id
    dict[@"accountid"] = @1;
    
    [[HTNetworkTool sharedNetWorkTools]objectWithURLString:@"http://iosapi.itcast.cn/car/bandcity.json.php" RequsetOp:@"POST" AndParams:dict completeBlock:^(id object) {
        
        NSDictionary  *dict = (NSDictionary*)object;
        
        NSArray * arr = dict[@"data"][@"attrList"];
        self.tempCityArray = arr;
        
        [self.tableView reloadData];
        
        //        msg = OK;
        //        data = {
        //            attrList = (
        //                        {
        //                            carBrandName = <null>;
        //                            carBrandId = ;
        //                            attrName = 北京;
        //                            updateTime = <null>;
        //                            createId = <null>;
        //                            updateId = <null>;
        //                            isDelete = N;
        //                            createTime = <null>;
        //                            remark = ;
        //                            attrTypeName = 城市;
        //                            attrId = ATTR1005-1;
        //                            status = USING;
        //                            attrTypeId = A1005;
        //                        }
        //                        ,
    }];
    
    
}

@end
