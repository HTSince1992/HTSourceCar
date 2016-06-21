//
//  HTdsyMakeColorController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyMakeColorController.h"
#import "HTdsyColorDefineController.h"

#import "HTdsyColorContentController.h"
@interface HTdsyMakeColorController ()<UITableViewDelegate,UITableViewDataSource>

//选择外观颜色
@property(nonatomic,strong)NSArray * tempColorArray;

@property(nonatomic,strong) NSString * brandId;

@end

@implementation HTdsyMakeColorController

//重写init方法
-(instancetype)initWithString:(NSString*)brandId  {
    if (self = [super init]) {
        self.brandId = brandId;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //在视图将要出现时加载数据
    self.tempColorArray = [self composeCarColor];


}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"选择外观颜色";
    //不显示返回的文字
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    [self andBottomBtn];
    
}

-(void) andBottomBtn{
    CGRect rec = [UIScreen mainScreen].bounds;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, rec.size.height-120, rec.size.width,60)];
    [btn setBackgroundColor:[UIColor  colorWithRed:33/255.0 green:119/255.0 blue:202/255.0 alpha:1]];

   
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
    
    la.text = @"自定义外观颜色";
    la.textColor = [UIColor whiteColor];
    la.font = [UIFont systemFontOfSize:18];
    //点击方法
     [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = btn;
    
}

-(void)btnClick{

    HTdsyColorDefineController * as = [[HTdsyColorDefineController alloc]initWithString:self.brandId];
    [self.navigationController pushViewController: as animated:YES];
}
//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tempColorArray.count;

    
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
        NSDictionary * dic = self.tempColorArray[indexPath.row];
        //赋值
        cell.textLabel.text = dic[@"attrName"];
        
    }
    return cell;
}

#pragma mark --- 点击跳转方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取当前数据
    UITableViewCell * cell = [ tableView cellForRowAtIndexPath:indexPath ];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSString * str = cell.textLabel.text;
    dict[@"text"] = str;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo:dict];
    

    HTdsyColorContentController * con = [[HTdsyColorContentController alloc]initWitchTextString:str and:self.brandId];
    [self.navigationController pushViewController:con animated:YES];
}


//发布颜色列表

-(NSArray *)composeCarColor{
    //http://iosapi.itcast.cn/car/bandcolor.json.php
    
    //brandId = BD1004
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //品牌id
    dict[@"brandId"] = self.brandId;
    //用户id
    dict[@"accountid"] = @1;
    // 0是外观 1是内饰
    dict[@"isout"] = @0;
    NSMutableArray * arr = [NSMutableArray array];
   
    [[HTNetworkTool sharedNetWorkTools]objectWithURLString:@"http://iosapi.itcast.cn/car/bandcolor.json.php" RequsetOp:@"POST" AndParams:dict completeBlock:^(id object) {
        
        NSDictionary  *dic = (NSDictionary*)object;
        //        NSLog(@"%@",dict);
        
        [arr addObjectsFromArray:dic[@"data"][@"attrList"]];
        
        //刷新数据   请求完成后 刷新数据
        [self.tableView reloadData];
      
    }];
    
    return  arr;
}
//移除通知
-(void)viewDisAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
