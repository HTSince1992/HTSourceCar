//
//  HTSearchCarViewController.m
//  HTSourceCar
//
//  Created by Page on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTSearchCarViewController.h"
#import "AFNetworking.h"
#import "HTSearchHeadView.h"
#import "SVProgressHUD.h"
#import "HTBaseControllerTableViewController.h"
#import "LZSearchCarTableViewCell.h"
#import "LZSearchCarModel.h"
#import "LZSiftListViewController.h"
#import "LQCReleaseCarSourceController.h"
#import "LZcarBrandIdModel.h"
#import "LZSiftView.h"
#import "LZSiftCarResultTableViewController.h"
@interface HTSearchCarViewController ()<HTSearchHeadViewDelegate,UIScrollViewDelegate,LZSiftViewdeldelegate>

@property(nonatomic,strong)NSArray *carList;
@property(nonatomic,strong)LZSiftListViewController *SiftView;
@property(nonatomic,assign)BOOL isSift;
@property(nonatomic,weak)UIButton *siftBtn;
@property(nonatomic,strong)NSMutableDictionary *siftResultListDic;
@property(nonatomic,strong)LZSiftView *siftResultView;
@end

@implementation HTSearchCarViewController

//-(NSDictionary *)siftResultListDic{
//    
//    if (_siftResultListDic == nil) {
//        _siftResultListDic = [NSDictionary dictionary];
//    }
//    return _siftResultListDic;
//}


-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;


}
-(NSArray *)carList{
    if (_carList == nil) {
        _carList = [NSArray array];
    }
    return _carList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[SVProgressHUD show];
    
    self.tableView.rowHeight = 80;
    
    HTSearchHeadView *headView = [[HTSearchHeadView alloc]initWithFrame:CGRectMake(10, 10, 10, 60)];
    
    headView.Refreshdelegate = self;
    
    self.tableView.separatorColor = [UIColor colorWithRed:35/255.0 green:136/255.0 blue:255/255.0 alpha:119/255.0];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    self.tableView.tableHeaderView = headView;
    
    //设置左右 item
    UIButton *leftBtn = [self setItemWithString:@"发布寻车" AndTarget:self AndAction:@selector(releaseSearch)];
    
    leftBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    //右边的 item
    UIButton *rightBtn = [self setItemWithString:@"筛选" AndTarget:self AndAction:@selector(sift)];
    [rightBtn setTitle:@"关闭筛选" forState:UIControlStateSelected];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.siftBtn = rightBtn;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //注册cell
    [self.tableView registerClass:[LZSearchCarTableViewCell class] forCellReuseIdentifier:@"releaseTableViewCell"];
    

    
    [self HTSearchHeadViewDelegataRefreshData:headView AndButtonTag:0];
    
    //注册通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchSift:)name:@"searchSift" object:nil];
    
  
    
}

-(void)searchSift:(NSNotification *)NOTification{
    
    
    // LXLog(@"%@",NOTification);
    NSDictionary *dict = NOTification.userInfo;
    
    self.siftResultListDic = [NSMutableDictionary dictionary];
    
    self.siftResultListDic = [NSMutableDictionary dictionaryWithDictionary:dict];
      // LXLog(@"=====%@",self.siftResultListDic);
    
    [self dismiss];
    
   [self.tableView reloadData];
//    
//    
//    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(UIButton *)setItemWithString:(NSString *)text AndTarget:(nullable id)target AndAction :(SEL)action{
    
    
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [buttonItem setTitle:text forState:UIControlStateNormal];
    [buttonItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonItem setBounds:CGRectMake(0, 0, 100, 30)];
    
    buttonItem.titleLabel.font = [UIFont systemFontOfSize:14];
    //设置按钮中的内容向左移动
    
    if ([text isEqualToString:@"发布寻车"]) {
        
        buttonItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        buttonItem.contentEdgeInsets = UIEdgeInsetsMake(0,-5, 0, 0);
        
        [buttonItem setImage:[UIImage imageNamed:@"issue-w30h30"] forState:UIControlStateNormal];
        
        buttonItem.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        
    }else if ([text isEqualToString:@"筛选"]){
        // 设置按钮中的内容向右移动
        buttonItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        buttonItem.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        
        self.isSift = YES;
    }
    [buttonItem setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return buttonItem;
    
    
    
    
}
//跳转到发布寻车界面
-(void)releaseSearch{
    LXLogFunc
    LQCReleaseCarSourceController *baseVc = [[LQCReleaseCarSourceController alloc] init];
    
    baseVc.title = @"发布寻车";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:baseVc];
    UITabBarController *vc = [[UITabBarController alloc] init];
    [vc addChildViewController:nav];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
//筛选
-(void)sift{
    
    if (self.isSift) {
        
        self.siftBtn.selected = YES;
        
        LZSiftListViewController *SiftViewVC= [[LZSiftListViewController alloc]init];
        
        SiftViewVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400);
        //记录
        self.SiftView = SiftViewVC;
        
        
        [self.tableView addSubview:SiftViewVC.view];
        [self addChildViewController:SiftViewVC];
        //滚动到最上面
        
        [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y - 60)];
        
        self.isSift = NO;
        
        
        self.tableView.scrollEnabled = NO;
        
        
    }
    else{

       

        [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y - 60)];
        
        [self dismiss];
        

        
    }
    
}


-(void)dismiss{
    
    self.isSift = YES;
    
    self.siftBtn.selected = NO;

     self.tableView.scrollEnabled = YES;
    [self.SiftView removeFromParentViewController];
    [self.SiftView.view removeFromSuperview];
    
    LXLog(@"%@",self.SiftView);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    LXLog(@"内存警告");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //LXLog(@"%lu",(unsigned long)self.carList.count);
    return self.carList.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZSearchCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"releaseTableViewCell" forIndexPath:indexPath];
    
    LZSearchCarModel *model = self.carList[indexPath.row];
    
    cell.SearchCarModel = model;
    
    
    return cell;
}


-(void)HTSearchHeadViewDelegataRefreshData:(HTSearchHeadView *)SearchHeadView AndButtonTag:(NSInteger)tag{
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    
    paras[@"type"] = [NSString stringWithFormat:@"%ld",(long)tag];
    
    //LXLog(@"%@",paras[@"type"]);
    //    //发送网络请求获取数据、
    [[HTNetworkTool sharedNetWorkTools] objectWithURLString:@"http://iosapi.itcast.cn/car/searchlist.json.php" RequsetOp:@"POST" AndParams:paras completeBlock:^(id object) {
        
        //[SVProgressHUD dismiss];
        
        NSDictionary *Dict = object[@"data"];
    
        
        // LXLog(@"%@",Dict);
        self.carList = Dict[@"carList"];
        
        NSMutableArray *num = [NSMutableArray array];
        
        for (NSDictionary *dict in self.carList) {
            
            LZSearchCarModel *SearchCarModel = [[LZSearchCarModel alloc]initWithDict:dict];
            
            [num addObject:SearchCarModel];
            
        }
        self.carList = num;
        
        [self.tableView reloadData];

    
    }];
    
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (self.siftResultListDic != nil && [self.siftResultListDic[@"uid"]isEqualToString:@"0"]) {
        
        return 40;
        
    }else{
    
        return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    LZSiftView *view = [[LZSiftView alloc]init];
    
    view.siftResultDict = self.siftResultListDic;
    view.Siftdeldelegate = self;
    
    
        
    return view;

}

// 删除消失==
-(void)SiftViewdeldelegate:(NSMutableDictionary *)SearchCarDict{
    
    self.siftResultListDic = SearchCarDict;
    
    LXLog(@"%@",self.siftResultListDic[@"uid"]);
    
    

    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isSift){
   
        LZSearchCarModel*model  = self.carList[indexPath.row];
        
        LZSiftCarResultTableViewController *result = [[LZSiftCarResultTableViewController alloc]init];
        
        result.model = model;
        
        [self.navigationController pushViewController:result animated:YES];
        
 
        
    }
    

}


@end
