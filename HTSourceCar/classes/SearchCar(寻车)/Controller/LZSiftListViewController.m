//
//  LZSiftListViewController.m
//  HTSourceCar
//
//  Created by 张 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZSiftListViewController.h"

#import "LZSiftView.h"
#import "LZSiftListTableViewController.h"
#import "LZcarBrandIdModel.h"
#import "LZSiftListTableViewController.h"
#import "LZSiftTableViewCell.h"
@interface LZSiftListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)UITableView *requirement;
@property(nonatomic,weak)LZSiftListTableViewController *listTableViewVC;
@property(nonatomic,weak)UITableViewCell *currentCell;
@property(nonatomic,strong)NSArray *carBrandIdArray;
@property(nonatomic,weak)UITableView *listTableView;
@property(nonatomic,weak)UITableView *siftlisttTab;
@property(nonatomic,strong)LZcarBrandIdModel *model;
@property(nonatomic,strong)NSMutableDictionary *siftResultListDic;
@property(nonatomic,weak)UILabel *nameDetailTextLabel;
@property(nonatomic,weak)UILabel *colorDetailTextLabel;
@property(nonatomic,weak)UILabel *citynameDetailTextLabel;

@end

@implementation LZSiftListViewController

static NSString *identifier= @"requirement";
-(NSMutableDictionary *)siftResultListDic{
    
    if (_siftResultListDic == nil) {
        _siftResultListDic = [NSMutableDictionary dictionary];
    }
    return _siftResultListDic;
}

-(NSArray *)carBrandIdArray{
    if (_carBrandIdArray == nil) {
        _carBrandIdArray = [NSArray array];
    }
    return _carBrandIdArray;
    
}

-(void)viewDidLoad{
    [self requirementTableView];
    
    [self  ShowListTableView];
    
    
    [self confirmView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(siftListData:) name:@"siftListData" object:nil];
    
}

-(void)siftListData:(NSNotification *)Notification{
    NSDictionary *dict = Notification.userInfo;
    
    if (dict[@"name"] != nil) {
        NSString *name = dict[@"name"];
        self.siftResultListDic[@"name"] = name;
        
    }else if (dict[@"color"] != nil)
    {
        NSString *color = dict[@"color"];
        
        self.siftResultListDic[@"color"] = color;
        
        
    }else if (dict[@"city"] != nil) {
        
        NSString *city = dict[@"city"];
        self.siftResultListDic[@"city"] = city;
    }else{
        
        
        
        
    }
    
    self.siftResultListDic[@"uid"] = @"0";
    
    
    if (self.siftResultListDic[@"name"]!= nil) {
        self.nameDetailTextLabel.text = self.siftResultListDic[@"name"];
    }else{
        self.nameDetailTextLabel.text = @"全部";
        
    }
    
    if (self.siftResultListDic[@"color"] != nil) {
        self.colorDetailTextLabel.text = self.siftResultListDic[@"color"];
    }else{
        
        self.colorDetailTextLabel.text = @"全部";
    }
    
    if (self.siftResultListDic[@"city"] != nil) {
        
        self.citynameDetailTextLabel.text = self.siftResultListDic[@"city"];
    }else{
        
        self.citynameDetailTextLabel.text = @"全部";
    }
    
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)requirementTableView{
    
    UITableView *requirement = [[UITableView alloc]initWithFrame:CGRectMake(0,  0, 150, 350) style:UITableViewStylePlain];
    
    requirement.backgroundColor = LXRGBColor(236, 236, 236);
    
    requirement.separatorColor = [UIColor colorWithRed:35/255.0 green:136/255.0 blue:255/255.0 alpha:119/255.0];
    
    requirement.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    requirement.rowHeight = 80;
    
    requirement.delegate = self;
    
    requirement.dataSource = self;
    
    
    requirement.backgroundColor = [UIColor whiteColor];
    
    self.requirement = requirement;
    
    [self.view addSubview:requirement];
    
    
}

-(void)ShowListTableView{
    
    LZSiftListTableViewController *listTabVc =[[LZSiftListTableViewController alloc]init];
    
    [self.view addSubview:listTabVc.tableView];
    
    [self addChildViewController:listTabVc];
    
    self.listTableView = listTabVc.tableView;
    self.listTableViewVC = listTabVc;
    
    self.listTableView.frame = CGRectMake(self.requirement.frame.size.width, 0, [UIScreen mainScreen].bounds.size.width - 152, self.view.frame.size.height -50);
    
}


#pragma mark - 数据源方法


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    LZSiftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LZSiftTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"certain_link"]];;
    
    
    [cell setSelectedBackgroundView:image];
    cell.bottomDetailTextLabel.text = @"全部";
    
    
    switch (indexPath.row) {
        case 0:
            cell.topTextLabel.text = @"选择车型";
            self.nameDetailTextLabel = cell.bottomDetailTextLabel;
            //self.nameDetailTextLabel.font = [UIFont systemFontOfSize:16];
            
            break;
        case 1:
            cell.topTextLabel.text = @"车型颜色";
            self.colorDetailTextLabel = cell.bottomDetailTextLabel;
            self.colorDetailTextLabel.font = [UIFont systemFontOfSize:16];
            break;
        case 2:
            cell.topTextLabel.text = @"所在地区";
            self.citynameDetailTextLabel = cell.bottomDetailTextLabel;
            self.citynameDetailTextLabel.font = [UIFont systemFontOfSize:16];
            break;
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        
        self.currentCell = cell;
        

        [self tableView:self.requirement didSelectRowAtIndexPath:indexPath];
        
    }
    
    
    return cell;
}
-(void)viewDidAppear:(BOOL)animated{
    
    self.currentCell.selected = YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0) {
        self.currentCell.selected = NO;
    }
    
    if (indexPath.row == 0) {
        [self http:@"http://iosapi.itcast.cn/car/highcarlist.json.php"Withtag:indexPath.row];
    }else if (indexPath.row == 1){
        
        [self http:@"http://iosapi.itcast.cn/car/searchcolor.json.php"Withtag:indexPath.row];
        
        
    }else if (indexPath.row == 2){
        [self http:@"http://iosapi.itcast.cn/car/searchcity.json.php"Withtag:indexPath.row];
    }else{
        
        
    }
    
}
-(void)http:(NSString *)url Withtag:(NSInteger)uid{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"accountid"] = @"1";
    
    [[HTNetworkTool sharedNetWorkTools] objectWithURLString:url RequsetOp:@"POST" AndParams:params completeBlock:^(id object) {
        
        NSDictionary *listDict = object[@"data"];
        
        //LXLog(@"%@",listDict);
        
        if (listDict[@"high"] != nil) {
            
            self.carBrandIdArray = listDict[@"high"];
        }else if (listDict[@"list"] != nil){
            
            self.carBrandIdArray = listDict[@"list"];
            
        }
    
        NSMutableArray *num = [NSMutableArray array];
        
        for (NSDictionary *dict in self.carBrandIdArray) {
            
            LZcarBrandIdModel *model = [[LZcarBrandIdModel alloc]initWithDict:dict WithUid:uid];
            
            [num addObject:model];
            
        }
        
        self.carBrandIdArray = num;
        
        self.listTableViewVC.BrandIdArray = self.carBrandIdArray;
        
        
        
        [self.listTableView reloadData];
        
    }];
    
    
    
}

-(void)confirmView{
    
    
    UIButton *confirmBtn = [[UIButton alloc]init];
    confirmBtn.backgroundColor = [UIColor blueColor];
    //    confirmView.frame = CGRectMake(0, 450, [UIScreen mainScreen].bounds.size.width * 0.5, 49);
    
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    //    [confirmBtn setImage:[UIImage imageNamed:@"certain_hover"] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"certain_hover"] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"certain_link"] forState:UIControlStateHighlighted];
    
    [confirmBtn addTarget:self action:@selector(confirmBtnClick)
         forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
        make.top.mas_equalTo(self.requirement.mas_bottom);
        
        make.width.mas_equalTo(self.view.mas_width).offset(-self.view.frame.size.width * 0.5);
        
    }];
    
    
    
    UIButton *deleteBtn = [[UIButton alloc]init];
    
    
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete_hover"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete_link"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(deleteSift) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: deleteBtn];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
        make.top.mas_equalTo(self.requirement.mas_bottom);
        
        
        make.width.mas_equalTo(self.view.mas_width).offset(-self.view.frame.size.width * 0.5);
        
    }];
    
    
}
-(void)confirmBtnClick{
    
    if (self.siftResultListDic[@"name"]!=nil ||self.siftResultListDic[@"color"] != nil || self.siftResultListDic[@"city"] != nil) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"searchSift" object:nil userInfo:self.siftResultListDic];
    }else{
        
        
        [self deleteSift];
        
    }
    
    
    
}
-(void)deleteSift{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchSift" object:nil userInfo:nil];
}

@end
