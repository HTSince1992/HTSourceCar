//
//  HTdsyCarSeriesController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyCarSeriesController.h"
#import "HTdsyCgrbodyController.h"
@interface HTdsyCarSeriesController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)NSArray * tempArray;
@property(nonatomic,copy) NSString * str;
@property(nonatomic,copy) NSString* carLineId;

//brandId
@property(nonatomic,copy)NSString *brandId;
@end
//选择车系列

@implementation HTdsyCarSeriesController


-(instancetype)initWitchString:(NSString *)brandId WitchTextSting :(NSString*)str{
    if (self = [super init]) {
        self.brandId = brandId;
        self.str = str;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //当视图将要出现时加载数据
    [self carliebiao];

}


- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.navigationItem.title  = @"选择车系";
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
   
}
//组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   return self.tempArray.count;
}

//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [self.tempArray[section][@"carlineList"] count];
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
 
    return self.tempArray[section][@"label"];

}

//cell样子
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellID = @"HTdsyCarTypeContrcell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        //设置右箭头
        UIImageView * im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou-w16h30"]];
        cell.accessoryView =im;

        NSArray * arr  = self.tempArray[indexPath.section][@"carlineList"];
        NSDictionary * dic = arr[indexPath.row];
        
        //赋值
        cell.textLabel.text = dic[@"carLineName"];
    
       
        
    }
    
    return cell;
}

#pragma mark -- 跳转界面  

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)
indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSString * str = [NSString stringWithFormat:@"%@ %@",self.str,cell.textLabel.text];
    dict[@"text"] = str;
    
    self.carLineId = self.tempArray[indexPath.section][@"carlineList"][indexPath.row][@"carLineId"];
    //发布通知传值;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo: dict];
    NSLog(@"%@",self.carLineId);
    
    HTdsyCgrbodyController * hts = [[HTdsyCgrbodyController alloc]initWithSting:str carLineId:self.carLineId];
    [self.navigationController pushViewController:hts animated:YES];
     }


//发送网络请求

///  车系列表
-(void)carliebiao{
    
    //http://iosapi.itcast.cn/car/series.json.php
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary]
    ;
    
    dict[@"brandId"] = self.brandId;
    
    dict[@"accountid"] = @1;
    
    [[HTNetworkTool sharedNetWorkTools]objectWithURLString:@"http://iosapi.itcast.cn/car/series.json.php" RequsetOp:@"POST" AndParams:dict completeBlock:^(id object) {
        
        NSDictionary * dict = (NSDictionary*)object;
        //label = 国产;
        
        //获取  数组	车型列表
        NSArray * arr = dict[@"data"][@"carList"];
   
        //赋值
        self.tempArray = arr;
        
        //刷新数据
        [self.tableView reloadData];
        
    }];
}


//移除通知
-(void)viewDisAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
