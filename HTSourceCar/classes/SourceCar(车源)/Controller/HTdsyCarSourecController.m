//
//  HTdsyCarSourecController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyCarSourecController.h"
#import "HTdsyCarSeriesController.h"
#import "DSYComposeDataModel.h"


@interface HTdsyCarSourecController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * tempbrandArray;

@property(nonatomic,strong)NSArray * CarSeriesArray;

@property(nonatomic,copy) NSString * keyStr;




//brandId
@property(nonatomic ,copy) NSString * brandId;

@end
 NSString * cellID = @"HTdsyCarSoureccell";
@implementation HTdsyCarSourecController

//选择品牌
-(instancetype)initwith:(NSArray *)arr {
    if ( self == [super init]) {
        self.tempbrandArray = arr;
       
    }

    return self;
}


-(void)viewDidAppear:(BOOL)animated{
    
    [self  carliebiao];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title  =@"选择品牌";
    //不显示返回文字
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
   
}

//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tempbrandArray.count;
    

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
        
      DSYComposeDataModel * mo = self.tempbrandArray[indexPath.row];

        //赋值
        cell.textLabel.text = mo.brandName;
//    
        
   }
 
    return cell;
}

//cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

///  发布通知
    UITableViewCell * cell = [ tableView cellForRowAtIndexPath:indexPath ];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    NSString * str = [NSString stringWithFormat:@"%@",cell.textLabel.text];
    dict[@"text"] = str;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo:dict];
    
    
    DSYComposeDataModel * mode = self.tempbrandArray[indexPath.row];
    self.brandId =  mode.brandId;
    
   
    
    // 跳转车系列表
    [self.navigationController pushViewController:[[HTdsyCarSeriesController alloc]initWitchString: mode.brandId WitchTextSting:str] animated:YES];
}
//设置行高

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}


///  车系列表
-(void)carliebiao{
    
    //http://iosapi.itcast.cn/car/series.json.php
    //获取 brandId
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
   
    
    dict[@"brandId"] = self.brandId;
    
    dict[@"accountid"] = @1;
    [[HTNetworkTool sharedNetWorkTools]objectWithURLString:@"http://iosapi.itcast.cn/car/series.json.php" RequsetOp:@"POST" AndParams:dict completeBlock:^(id object) {
        
        NSDictionary * dict = (NSDictionary*)object;
        //label = 国产;
        //获取  数组	车型列表
        NSArray * arr = dict[@"data"][@"carList"];
    
        self.CarSeriesArray = arr;
        //刷新数据
        [self.tableView reloadData];
    }];
    
  }

//移除通知
-(void)viewDisAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

    
    


@end
