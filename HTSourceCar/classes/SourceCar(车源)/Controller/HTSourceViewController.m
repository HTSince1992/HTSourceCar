//
//  HTSourceViewController.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTSourceViewController.h"
#import "HTComposeSourceController.h"
#import <Masonry.h>
#import "HTResultViewController.h"
#import "HTAccount.h"
#import "HTDisplayCarModel.h"
#import "HTHighBrandModel.h"
#import "HTCarDisplayCell.h"
#import "HTNewCarSourceCell.h"
#import "HTNavigationController.h"
#import "HTCarModelController.h"
#import "HTDetailSourceCarController.h"


@interface HTSourceViewController () <UISearchResultsUpdating,UISearchControllerDelegate>

@property (nonatomic, strong) HTResultViewController *resultTableView;

@property (nonatomic,strong) UISearchController*searchVc;

//所有车源
@property (nonatomic ,strong) NSMutableArray *htDisplayCar;

//最新车源
@property (nonatomic,strong) NSMutableArray *NewCar;

//高级品牌车数组
@property (nonatomic,strong) NSArray *HighBrandCar;

//车类型 现车 平行车...
@property (nonatomic,strong) NSMutableArray *htCarType;

@end

@implementation HTSourceViewController

//懒加载车型数组
- (NSMutableArray *)htCarType
{
    if (_htCarType == nil) {
        _htCarType = [NSMutableArray array];
//        @property (nonatomic,copy) NSString *carBrandId;
//        @property (nonatomic,copy) NSString *name;
//        @property (nonatomic,copy) NSString *url;
        
        NSArray *array = @[
                            @{@"name":@"现车",@"carBrandId":@"123",
                              @"url":@"car1_icon-w62h62"},
                            @{@"name":@"热销车型",@"carBrandId":@"123",
                              @"url":@"car2_icon-w62h62"},
                            @{@"name":@"平行进口车",@"carBrandId":@"123",
                              @"url":@"car3_icon-w62h62"},
                            
                            ];

        
        //遍历数组创建模型
        //遍历数组,创建模型
        for (NSDictionary *dict in array) {
            
            //创建模型
            HTHighBrandModel *model = [HTHighBrandModel HighBrandModelWithDict:dict];
            
            //将模型添加到数组
            [_htCarType addObject:model];
            
        }
        
    }
    
    return _htCarType;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建发布车源按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布车源" style:UIBarButtonItemStylePlain target:self action:@selector(ComposeClick)];
    
    //创建搜锁栏视图
    [self CreateSearchBar];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取车源展示数据
    [self GetData];

}

//获取车源展示数据
- (void)GetData
{
    //获取账号信息
    HTAccount *account = [HTAccountTool GetAcount];
    
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"accountid"] = account.accountid;
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //返回和请求数据
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager POST:@"http://iosapi.itcast.cn/car/newcarlist.json.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
//        
//        NSLog(@"%@",dict);
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
//    //发送请求
    [[HTNetworkTool sharedNetWorkTools] objectWithURLString:@"http://iosapi.itcast.cn/car/newcarlist.json.php" RequsetOp:@"POST" AndParams:params completeBlock:^(id object) {
        
        //获取字典数组
        NSDictionary *OBJ = (NSDictionary *)object;
        NSDictionary *dataDict = OBJ[@"data"];
        NSArray *dictArray = dataDict[@"carList"];
        
        
        //创建数组用来存放模型字典
        NSMutableArray *TempArray = [NSMutableArray array];
        
        //遍历数组,创建模型
        for (NSDictionary *dict in dictArray) {
            
            //创建模型
            HTDisplayCarModel *model = [HTDisplayCarModel displayCarModelWithDict:dict];
            
            //将模型添加到数组
            [TempArray addObject:model];
            
        }
        
        //添加到数组
        self.NewCar = TempArray.copy;
        [self.tableView reloadData];
        
    }];
    
    //获取高端品牌列表数据
    [[HTNetworkTool sharedNetWorkTools] objectWithURLString:@"http://iosapi.itcast.cn/car/highcarlist.json.php" RequsetOp:@"POST" AndParams:params completeBlock:^(id object) {
        
        //获取字典数组
        NSDictionary *highdict = (NSDictionary *)object;
        NSDictionary *dataDict = highdict[@"data"];
        NSArray *dictHighArray = dataDict[@"high"];
        
        
        
        //创建临时数组存放模型
        NSMutableArray *TempHigh = [NSMutableArray array];
        
        //遍历数组,创建模型
        for (NSDictionary *dict in dictHighArray) {
            
            //创建模型
            HTHighBrandModel *highModel = [HTHighBrandModel HighBrandModelWithDict:dict];
            
            //添加到临时数组
            [TempHigh addObject:highModel];
            
        }
        
        self.HighBrandCar = TempHigh;
        [self.tableView reloadData];
        
    }];
    
}


#pragma mark:==创建搜索控制器
- (void)CreateSearchBar
{
    self.resultTableView = [[HTResultViewController alloc] init];
    self.resultTableView.view.backgroundColor = [UIColor lightGrayColor];
    
    self.searchVc = [[UISearchController alloc] initWithSearchResultsController:self.resultTableView];
    
    //注释掉下面代码后依然显示正确
//    self.searchVc.searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    
    self.tableView.tableHeaderView = self.searchVc.searchBar;
    self.searchVc.searchBar.backgroundColor = [UIColor redColor];
    
    //注释掉下面代码后依然显示正确
//    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    self.searchVc.delegate = self;
    
    self.searchVc.searchResultsUpdater = self;
    
}

#pragma mark:==实现searchResultsUpdater的代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
        // 谓词的包含语法
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"outsideColor CONTAINS%@", self.searchVc.searchBar.text];
    
    //    //过滤数据
    NSArray *relustArray = [NSMutableArray arrayWithArray:[_NewCar filteredArrayUsingPredicate:preicate]];
    
    NSLog(@"%@",relustArray);
    
    self.resultTableView.models = relustArray;
    
    [self.resultTableView.tableView reloadData];
}


//创建发布车源按钮
- (void)ComposeClick
{
    //发布车源控制器
    HTComposeSourceController *composeVc = [[HTComposeSourceController alloc] init];
    
    HTNavigationController *composNav = [[HTNavigationController alloc] initWithRootViewController:composeVc];
    
//    [self.navigationController pushViewController:composeVc animated:YES];
    
    [self presentViewController:composNav animated:YES completion:nil];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.htCarType.count;
    }
    if (section == 1) {
        return self.HighBrandCar.count;
    }else{
        
        return self.NewCar.count;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用标识
    static NSString *ID = @"htCarCell";
    
    //从缓存池取cell
    HTCarDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[HTCarDisplayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //车型组
    if (indexPath.section == 0) {
        
        cell.highBrandModel = self.htCarType[indexPath.row];
    }
    
    //高级品牌组
    if (indexPath.section == 1) {
        HTHighBrandModel *branModel = self.HighBrandCar[indexPath.row];
        
        //传递模型数据
        cell.highBrandModel = branModel;
        
    }
    
    //最新车源组
    if (indexPath.section == 2) {
        
        //重用标识
        static NSString *IDs = @"htnewcar";
        
        //创建cell
        HTNewCarSourceCell *htcell = [tableView dequeueReusableCellWithIdentifier:IDs];
        
        if (!htcell) {
            
            htcell = [[HTNewCarSourceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDs];
        }
        
        //获取模型输数据
        HTDisplayCarModel *model = self.NewCar[indexPath.row];
        
        //传递模型数据
        htcell.DisplayCarModel = model;
        
        return htcell;
        
    }else{
    
        return cell;
    
    }
    
    
}


//组头
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return @"";
//    }
//    if (section == 1) {
//        return @"高级品牌";
//    }else{
//    
//    return @"最新车源";}
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *headerview = [[UIView alloc] init];
    headerview.bounds = CGRectMake(0, 0, self.view.frame.size.width, 44);
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(20, 0, 100, 44);
    if (section == 1) {
        titleLabel.text = @"高级品牌";
    }else{
    titleLabel.text = @"最新车源";
    }
    [headerview addSubview:titleLabel];
    
    headerview.backgroundColor = [UIColor colorWithRed:76/255.0 green:147/255.0 blue:227/255.0 alpha:1];
    
    return headerview;
}

//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 90;
    }else if(indexPath.section == 2) {
    
        return 178;
    
    }else{
    
        return 44;
    }

}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建车型控制器
    HTCarModelController *carModelVc = [[HTCarModelController alloc] init];
    
    //获取点击的cell的数据
    if (indexPath.section == 0) {
        
        HTHighBrandModel *model = self.htCarType[indexPath.row];
        
        carModelVc.title = model.name;
        
        [self.navigationController pushViewController:carModelVc animated:YES];
        
    }else if (indexPath.section == 1){
        
        HTHighBrandModel *model = self.HighBrandCar[indexPath.row];
         carModelVc.title = model.name;
        [self.navigationController pushViewController:carModelVc animated:YES];
    
    }else{
    
        //push详情页面
        HTDetailSourceCarController *detailVc = [[HTDetailSourceCarController alloc] init];
        
        detailVc.carmodel = self.NewCar[indexPath.row];
        
        [self.navigationController pushViewController:detailVc animated:YES];
    
    }
    
    
    
    
}

@end





