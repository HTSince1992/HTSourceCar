//
//  HTdsyCgrbodyController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTdsyCgrbodyController.h"

#import "HTComposeSourceController.h"

@interface HTdsyCgrbodyController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSArray* tempCarArray;
@property(nonatomic,copy)NSString * str;
@property(nonatomic,copy)NSString *carLineId;
@end

@implementation HTdsyCgrbodyController


-(instancetype)initWithSting:(NSString*)str carLineId:(NSString*)carLineId{

    if (self = [super init]) {
        self.str = str;
        self.carLineId = carLineId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = @"选择车型";
    
    [self composeCarlist];
    
}
//-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
//
//    NSLog(@"%lu",self.tempCarArray.count);
//    return 0;
//}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return self.tempCarArray.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"HTdsyCgrbodyControllercell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        cell.textLabel.text = self.tempCarArray[indexPath.row][@"carModelName"];
        
    }
    
    return cell;
}


///************-*--******

#pragma mark ---- 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSString * str = [NSString stringWithFormat:@"%@ %@", self.str,cell.textLabel.text];
    dict[@"text"] = str;
    //发布通知传值;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo: dict];
    
    //跳转到根控制器
    [self.navigationController popToRootViewControllerAnimated:YES];
    }



//车型列表
-(void)composeCarlist{
    //http://iosapi.itcast.cn/car/bandcolor.json.php
    
    //brandId = BD1004
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //车系ID
    if (self.carLineId) {
        
 
    dict[@"carLineId"]= self.carLineId;
    //用户id
    dict[@"accountid"] = @1;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://iosapi.itcast.cn/car/model.json.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
           NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic);
        //[@"data"][@"carList"][0][@"modelList"][0][@"carModelName"];
       self.tempCarArray = dic[@"data"][@"carList"][0][@"modelList"];
        
        [self.tableView reloadData];
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
   }
//    msg = OK;
//    data = {
//        carList = (
//                   {
//                       label = <null>;
//                       modelList = (
//                                    {
//                                        carModelId = CM100054116223;
//                                        updateTime = <null>;
//                                        carLabelId = LA100054107014;
//                                        carLabelName = GLC;
//                                        carModelName = GLC 260动感;
//                                        isDelete = <null>;
//                                        isOnline = Y;
//                                        carBrandId = BD1001;
//                                        carLineId = CL100054109413;
//                                        guidePrice = 426000;
//                                        orderNum = 1;
//                                    }
//                                    ,
//                                    {
//                                        carModelId = CM100054121176;
//                                        updateTime = <null>;
//                                        carLabelId = LA100054107014;
//                                        carLabelName = GLC;
//                                        carModelName = GLC 260豪华;
//                                        isDelete = <null>;
//                                        isOnline = Y;
//                                        carBrandId = BD1001;
//                                        carLineId = CL100054109413;
//                                        guidePrice = 441000;
//                                        orderNum = 1;
//                                    }
//                                    ,
//                                    {
//                                        carModelId = CM100054132601;
//                                        updateTime = <null>;
//                                        carLabelId = LA100054107014;
//                                        carLabelName = GLC;
//                                        carModelName = GLC200;
//                                        isDelete = <null>;
//                                        isOnline = Y;
//                                        carBrandId = BD1001;
//                                        carLineId = CL100054109413;
//                                        guidePrice = 396000;
//                                        orderNum = 1;
//                                    }
//                                    ,
//                                    {
//                                        carModelId = CM100054148467;
//                                        updateTime = <null>;
//                                        carLabelId = LA100054107014;
//                                        carLabelName = GLC;
//                                        carModelName = GLC300;
//                                        isDelete = <null>;
//                                        isOnline = Y;
//                                        carBrandId = BD1001;
//                                        carLineId = CL100054109413;
//                                        guidePrice = 486000;
//                                        orderNum = 1;
//                                    }
//                                    ,
//                                    {
//                                        carModelId = CM100054158531;
//                                        updateTime = <null>;
//                                        carLabelId = LA100054107014;
//                                        carLabelName = GLC;
//                                        carModelName = GLC300豪华;
//                                        isDelete = <null>;
//                                        isOnline = Y;
//                                        carBrandId = BD1001;
//                                        carLineId = CL100054109413;
//                                        guidePrice = 579000;
//                                        orderNum = 1;
//                                    }
//                                    ,
//                                    );
//                   }
//                   ,
//                   );
//    }
//    ;
//    code = 0;
    
}



//移除通知
-(void)viewDisAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
