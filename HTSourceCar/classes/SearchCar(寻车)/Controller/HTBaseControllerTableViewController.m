

//
//  HTBaseControllerTableViewController.m
//  HTSourceCar
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//


////////////////////////////////////////////////////////////////////
//                          _ooOoo_                               //
//                         o8888888o                              //
//                         88" . "88                              //
//                         (| ^_^ |)                              //
//                         O\  =  /O                              //
//                      ____/`---'\____                           //
//                    .'  \\|     |//  `.                         //
//                   /  \\|||  :  |||//  \                        //
//                  /  _||||| -:- |||||-  \                       //
//                  |   | \\\  -  /// |   |                       //
//                  | \_|  ''\---/''  |   |                       //
//                  \  .-\__  `-`  ___/-. /                       //
//                ___`. .'  /--.--\  `. . ___                     //
//              ."" '<  `.___\_<|>_/___.'  >'"".                  //
//            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
//            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//      ========`-.____`-.___\_____/___.-`____.-'========         //
//                           `=---='                              //
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑            永无BUG              永不修改         //
////////////////////////////////////////////////////////////////////

//
//新浪App Key：3084248703
//App Secret：9048351f389a963c522b538d6fd18a01

#import "HTBaseControllerTableViewController.h"
#import "HTBaseCell.h"
#import "LQCBrandListModel.h"
#import "LQCBtn.h"
#import "LQCCustomController.h"


@interface HTBaseControllerTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) LQCBtn *bottomBtn;
@end

@implementation HTBaseControllerTableViewController


- (instancetype)init
{
    return [super initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *url = self.sourceDic[@"url"];
    if ([url isEqualToString:@"youxiaoqi"]) {
        return;
    }
//    NSLog(@"%@", url);
//    NSLog(@"%@", self.params[@"carLineId"]);
//    NSLog(@"%@", self.params[@"accountid"]);
    
    
    if (url.length > 0) {
        [[HTNetworkTool sharedNetWorkTools] objectWithURLString:self.sourceDic[@"url"] RequsetOp:@"POST" AndParams:self.params completeBlock:^(id object) {
            if ([url isEqualToString:@"http://iosapi.itcast.cn/car/band.json.php"]) {
                //品牌数据解析
                LQCBrandListModel *model = [[LQCBrandListModel alloc] initWithDictionary:object];
                if (model.brandList.count > 0) {
                    self.dataSourceArr = model.brandList;
                    
                }
            } else if([url isEqualToString:@"http://iosapi.itcast.cn/car/series.json.php"])
            {
                //车系
                self.dataSourceArr = object[@"data"][@"carList"];
                //NSLog(@"%@", object);
            } else if([url isEqualToString:@"http://iosapi.itcast.cn/car/model.json.php"])
            {
                //车型
                self.dataSourceArr = object[@"data"][@"carList"][0][@"modelList"];
                NSLog(@"%@", self.dataSourceArr);
            } else if([url isEqualToString:@"http://iosapi.itcast.cn/car/bandcolor.json.php"])
            {
                //颜色
                self.dataSourceArr = object[@"data"][@"attrList"];
            } else if([url isEqualToString:@"http://iosapi.itcast.cn/car/bandcity.json.php"])
            {
                //城市
                self.dataSourceArr = object[@"data"][@"attrList"];
            }
            
            //NSLog(@"%@",object);
            //NSLog(@"%@",self.dataSourceArr);
            [self.tableView reloadData];
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    // 设置左上角返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_icon-w18h30"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //添加底部button
    if (self.sourceDic[@"bottomBtn"]) {
        
        [self creatBottomBtn:self.sourceDic[@"bottomBtn"]];
    }
    
}

//- (BOOL)hidesBottomBarWhenPushed
//{
//
//    return YES;
//}

#pragma mark - 创建底部buttom
-(void)creatBottomBtn:(NSString *)title
{
    
    LQCBtn *bottomBtn = [[LQCBtn alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
    bottomBtn.backgroundColor = LXRGBColor(60, 137, 225);
    
    
    [bottomBtn setTitle:title forState:UIControlStateNormal];
    [bottomBtn setImage:[UIImage imageNamed:@"jiantou-w16h30"] forState:UIControlStateNormal];
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomBtn = bottomBtn;
    
    [self.tabBarController.tabBar addSubview:bottomBtn];
}

-(void)bottomBtnClick:(LQCBtn *)sender
{
    LQCCustomController *pushVc = [[LQCCustomController alloc] init];
    
    pushVc.title = sender.currentTitle;
    
    pushVc.holdTitle = self.sourceDic[@"textHolder"];
    self.hidesBottomBarWhenPushed = YES;
    
    //pushVc.navigationController.navigationBa
    
    [self.navigationController pushViewController:pushVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 左上角返回点击事件
- (void)backClick
{
    self.bottomBtn.hidden = YES;
    // 返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    if ([self.sourceDic[@"url"] isEqualToString:@"http://iosapi.itcast.cn/car/series.json.php"]) {
        
        return self.dataSourceArr.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.sourceDic[@"url"] isEqualToString:@"http://iosapi.itcast.cn/car/series.json.php"]) {
        //车系
        return [self.dataSourceArr[section][@"carlineList"] count];
    }
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *url = self.sourceDic[@"url"];
    
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    
    if ([url isEqualToString:@"leibie"]) {
        //品牌
        item[@"textLabel"] = self.dataSourceArr[indexPath.row];
        
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/band.json.php"]) {
        //品牌
        item[@"textLabel"] = self.dataSourceArr[indexPath.row][@"brandName"];
        
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/series.json.php"]){
        //车系
        item[@"textLabel"] = self.dataSourceArr[indexPath.section][@"carlineList"][indexPath.row][@"carLineName"];
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/model.json.php"]){
        //车型
        item[@"textLabel"] = self.dataSourceArr[indexPath.row][@"carModelName"];
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/bandcolor.json.php"]){
        //颜色
        item[@"textLabel"] = self.dataSourceArr[indexPath.row][@"attrName"];
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/bandcity.json.php"]){
        //城市
        item[@"textLabel"] = self.dataSourceArr[indexPath.row][@"attrName"];
    } else if ([url isEqualToString:@"youxiaoqi"]){
        //有效期
        item[@"textLabel"] = self.dataSourceArr[indexPath.row];
    }
    
    
    
    HTBaseCell *cell = [HTBaseCell baseCellWithTableView:tableView andItem:item accessory:@"accessory"];
    
    return cell;
}

#pragma mark - cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    HTBaseControllerTableViewController *pushVc = [[HTBaseControllerTableViewController alloc] init];
    pushVc.params = self.params;
    
    NSString *url = self.sourceDic[@"url"];
    
    if ([url isEqualToString:@"leibie"]) {
        NSDictionary *temDic = @{
                                 @"mark" : @"寻车类型",
                                 @"content" : cell.textLabel.text
                                 };
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return ;
        
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/band.json.php"]) {
        NSDictionary *temDic = @{
                                 @"mark" : @"品牌",
                                 @"content" : cell.textLabel.text
                                 };
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
        
        //品牌
        self.params[@"brandId"] = self.dataSourceArr[indexPath.row][@"brandId"];
        //NSLog(@"%@",self.dataSourceArr[indexPath.row][@"brandId"]);
        
        pushVc.title = @"选择车系";
        
        pushVc.sourceDic = @{@"url" : @"http://iosapi.itcast.cn/car/series.json.php"};
        
        self.hidesBottomBarWhenPushed = YES;
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/series.json.php"]){
        //车系
        NSDictionary *temDic = @{
                                 @"mark" : @"车系",
                                 @"content" : cell.textLabel.text
                                 };
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
        
        self.params[@"brandId"] = self.dataSourceArr[indexPath.section][@"carlineList"][indexPath.row][@"brandId"];
        self.params[@"carLineId"] = self.dataSourceArr[indexPath.section][@"carlineList"][indexPath.row][@"carLineId"];
        //NSLog(@"%@",self.dataSourceArr[indexPath.row][@"brandId"]);
        
        pushVc.title = @"选择车型";
        
        pushVc.sourceDic = @{@"url" : @"http://iosapi.itcast.cn/car/model.json.php"};
        
        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        return ;
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/model.json.php"]){
        //车型
        NSDictionary *temDic = @{
                                 @"mark" : @"车型",
                                 @"content" : cell.textLabel.text
                                 };
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
        
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
        return ;
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/bandcolor.json.php"]){
        //颜色
        
        NSDictionary *temDic = @{
                                 @"mark" : @"颜色",
                                 @"content" : cell.textLabel.text
                                 };
        
        //创建通知
        if ([self.title isEqualToString:@"内饰颜色"]) {
            self.bottomBtn.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
            //self.bottomBtn.hidden = YES;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        
        
        
        pushVc.title = @"内饰颜色";
        self.params[@"isout"] = @(1);
        pushVc.params = self.params;
        pushVc.sourceDic = self.sourceDic;
        
        //self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pushVc animated:YES];
        return ;
        
    } else if ([url isEqualToString:@"http://iosapi.itcast.cn/car/bandcity.json.php"]){
        //城市
        NSDictionary *temDic = @{
                                 @"mark" : @"上牌城市",
                                 @"content" : cell.textLabel.text
                                 };
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return ;
        
    } else if ([url isEqualToString:@"youxiaoqi"]){
        //有效期
        NSDictionary *temDic = @{
                                 @"mark" : @"有效期",
                                 @"content" : cell.textLabel.text
                                 };
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:temDic];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return ;
    }
    
    [self.navigationController pushViewController:pushVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.sourceDic[@"url"] isEqualToString:@"http://iosapi.itcast.cn/car/series.json.php"]) {
        
        return self.dataSourceArr[section][@"label"];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [self.bottomBtn removeFromSuperview];
    
    
}


@end
