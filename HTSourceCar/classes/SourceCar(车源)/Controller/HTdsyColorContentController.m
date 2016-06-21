//
//  HTdsyColorContentController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyColorContentController.h"
#import "HTdsyColorDefineContentController.h"
#import "HTComposeSourceController.h"
@interface HTdsyColorContentController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray* tempColorArray;

@property(nonatomic,copy)NSString  * str;

@property(nonatomic,strong) NSString * brandId;


@end

@implementation HTdsyColorContentController
//选择内饰控制器

-(instancetype)initWitchTextString:(NSString*) str  and:(NSString*) brandId{
    if (self == [super init]) {
        
        [self contentCarColor];
        
        self.str = str;
        self.brandId = brandId;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self contentCarColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //刷新界面
    self.navigationItem.title = @"选择内饰颜色";
    //不显示返回的文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self andBottomBtn];
    
}

-(void) andBottomBtn{
    CGRect rec = [UIScreen mainScreen].bounds;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, rec.size.height-120, rec.size.width,60)];
    [btn setBackgroundColor:[UIColor colorWithRed:33/255.0 green:119/255.0 blue:202/255.0 alpha:1]];
    
    
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
    
    la.text = @"自定义内饰颜色";
    la.textColor = [UIColor whiteColor];
    la.font = [UIFont systemFontOfSize:18];
    //点击方法
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = btn;
    
    
}

-(void)btnClick{
    
    HTdsyColorDefineContentController * dcavc  = [[HTdsyColorDefineContentController alloc]initWitchString:self.str];
    [self.navigationController pushViewController:dcavc animated:YES];
   
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
//点击cell调回主界面
#pragma mark ----- 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [ tableView cellForRowAtIndexPath:indexPath ];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    NSString * str = [NSString stringWithFormat:@"%@ %@",self.str,cell.textLabel.text];
    dict[@"text"] = str;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo:dict];
  
    [self.navigationController  popToRootViewControllerAnimated:YES];

}

//移除通知
-(void)viewDisAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)contentCarColor{
    //http://iosapi.itcast.cn/car/bandcolor.json.php
    
    //brandId = BD1004
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //品牌id
    dict[@"brandId"] = self.brandId;
    //用户id
    dict[@"accountid"] = @1;
    // 0是外观 1是内饰
    dict[@"isout"] = @1;
    [[HTNetworkTool sharedNetWorkTools]objectWithURLString:@"http://iosapi.itcast.cn/car/bandcolor.json.php" RequsetOp:@"POST" AndParams:dict completeBlock:^(id object) {
        
        NSDictionary  *dict = (NSDictionary*)object;
    
        
        self.tempColorArray =  dict[@"data"][@"attrList"];
        
        [self.tableView reloadData];
        
    }];
    
}

@end
