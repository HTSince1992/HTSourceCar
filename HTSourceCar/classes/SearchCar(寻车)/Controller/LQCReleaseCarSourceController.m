//
//  LQCReleaseCarSourceController.m
//  HTSourceCar
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LQCReleaseCarSourceController.h"
#import "HTBaseCell.h"
#import "HTBaseControllerTableViewController.h"
#import "LQCBrandListModel.h"
#import "LQCRecommendCarSourceContorller.h"
#import "LQCTextView.h"


@interface LQCReleaseCarSourceController ()<UIScrollViewDelegate,UITextViewDelegate>

@property (nonatomic, strong) NSArray *item;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSArray *effectiveTimeArray;
@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, weak) HTBaseCell *cell;

@property (nonatomic, weak) UIButton *btn;

@property (nonatomic, strong) NSMutableDictionary *recommendInfo;

@property (nonatomic, weak) LQCTextView *middleTextView;

@end

@implementation LQCReleaseCarSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recommendInfo = [NSMutableDictionary dictionary];
    
    NSArray *nameArr = @[@"张磊鹏(河南)",@"李强超(河北)",@"何涛(安徽)",@"谢亚鹏(河南)",@"张伟(河南)"];
    self.recommendInfo[@"hostName"] = nameArr;
    
    [self setHeadAndFoot];
    
    self.params = [NSMutableDictionary dictionary];
    self.params[@"accountid"] = @"1";
    self.params[@"type"] = @"1";
    self.params[@"brandId"] = @"BD1001";
    self.params[@"isout"] = @(0);
    _item = @[
              @{
                  @"textLabel" : @"类别",
                  @"accessory" : @"accessory",
                  @"url" : @"leibie",
                  @"accountid" : @"1"
                  },
              @{
                  @"textLabel" : @"车型",
                  @"accessory" : @"accessory",
                  @"url" : @"http://iosapi.itcast.cn/car/band.json.php",
                  @"accountid" : @"1"
                  },
              @{
                  @"textLabel" : @"颜色",
                  @"accessory" : @"accessory",
                  @"url" : @"http://iosapi.itcast.cn/car/bandcolor.json.php",
                  @"bottomBtn" : @"自定义颜色",
                  @"textHolder":@"  请输入颜色"
                  },
              @{
                  @"textLabel" : @"上牌城市",
                  @"accessory" : @"accessory",
                  @"url" : @"http://iosapi.itcast.cn/car/bandcity.json.php",
                  @"bottomBtn" : @"自定义城市",
                  @"textHolder":@"  请输入区域"
                  },
              @{
                  @"textLabel" : @"提车价格",
                  @"url" : @"",
                  
                  @"middleLabel" : @"textField",
                  
                  },
              @{
                  @"textLabel" : @"有效期",
                  @"accessory" : @"accessory",
                  @"url" : @"youxiaoqi",
                  @"bottomBtn" : @"自定义时间"
                  }
              ];
    //有效期数据
    _effectiveTimeArray = @[@"1天",@"2天",@"3天",@"4天",@"5天",@"6天",@"7天",@"二周",@"三周",@"四周",@"2个月",@"3个月"];
    //类型数据
    _typeArray = @[@"不限",@"国产",@"中规",@"美规",@"中东",@"欧规",@"加版",@"其他"];
    
    // 设置左上角返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_icon-w18h30"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //设置有上交的按钮
    //UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitClick)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    self.btn = btn;
    
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    btn.userInteractionEnabled = NO;
    
    [btn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //创建
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
    
    coverView.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarController.tabBar addSubview:coverView];
    
    //创建通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeData:) name:@"data" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillHideNotification object:nil];

}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
//    
//    HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [cell.middleTextField resignFirstResponder];
//}

-(void)keyboard:(NSNotification *)Notification{
    
    if ([Notification.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        [self.tableView setContentOffset:CGPointMake(0, 40) animated:YES];
    }else if ([Notification.object isEqualToString:@"UIKeyboardWillHideNotification"]){
        
        [self.tableView scrollsToTop];
    
    }
    
   

}


-(void)changeData:(NSNotification *) objec
{
    NSString *mark = objec.userInfo[@"mark"];
    NSString *content = objec.userInfo[@"content"];
    NSLog(@"%@",content);
    if ([mark isEqualToString:@"寻车类型"]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        cell.middleLabel.text = content;
        
        self.recommendInfo[@"type"] = content;
        
    }
    else if ([mark isEqualToString:@"品牌"]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        cell.middleLabel.text = content;
        
        self.recommendInfo[@"carSeries"] = content;
        
        self.btn.userInteractionEnabled = YES;
        
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    else if ([mark isEqualToString:@"车系"]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *str = [NSString stringWithFormat:@"  %@", content];
        
        cell.middleLabel.text = [cell.middleLabel.text stringByAppendingString:str];
        
        self.recommendInfo[@"carSeries"] = cell.middleLabel.text;
        
        self.btn.userInteractionEnabled = YES;
        
    }
    else if ([mark isEqualToString:@"车型"]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *str = [NSString stringWithFormat:@"  %@", content];
        
        cell.middleLabel.text = [cell.middleLabel.text stringByAppendingString:str];
        
        self.recommendInfo[@"carSeries"] = cell.middleLabel.text;
        
        self.btn.userInteractionEnabled = YES;
        
        [self.tableView reloadData];
        
        return ;
        
    }
    else if ([mark isEqualToString:@"颜色"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.middleLabel.text = content;
        
        self.recommendInfo[@"color"] = content;
    } else if ([mark isEqualToString:@"上牌城市"] || [mark isEqualToString:@"自定义城市"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        cell.middleLabel.text = content;
        
        self.recommendInfo[@"city"] = content;
        
    } else if ([mark isEqualToString:@"自定义时间"] || [mark isEqualToString:@"有效期"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.middleLabel.text = content;
        
        self.recommendInfo[@"effectiveTime"] = content;
    }
    else if ([mark isEqualToString:@"推荐车源"]){
        
        [self backClick];
        return;
    }
    
    [self.tableView reloadData];
}

#pragma mark - 左上角返回点击事件
- (void)backClick
{
    // 返回上一个控制器
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 右上角点击事件
-(void)submitClick
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    
    HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    self.recommendInfo[@"price"] = cell.middleTextField.text;
    
    
    
    
    LQCRecommendCarSourceContorller *pushVc = [[LQCRecommendCarSourceContorller alloc] init];
    
    pushVc.infoDic = self.recommendInfo;
    
    pushVc.title = @"推荐车源";
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 显示head和foot
-(void)setHeadAndFoot
{
    //[self setHeadView];
    [self setFootView];
    
}
-(void)dealloc{

    
    [[NSNotificationCenter defaultCenter] removeObserver:self];


}

#pragma mark - 创建footView
-(void)setFootView
{
    //设置footView
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 120)];
    
    UILabel *textLabel = [[UILabel alloc] init];
    
    textLabel.text = @"备注";
    
    [footView addSubview:textLabel];
    
    LQCTextView *textView = [[LQCTextView alloc] init];
    textView.delegate = self;
    textView.backgroundColor = LXRGBColor(239, 239, 239);
    
    textView.holerString = @"写下您的备注信息";
    
    self.middleTextView = textView;
    
    [footView addSubview:textView];
    
    self.tableView.tableFooterView = footView;
    //footView.backgroundColor = [UIColor redColor];
    
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footView.mas_left).offset(8);
        make.top.mas_equalTo(footView.mas_top).offset(28);
        //make.bottom.mas_equalTo(footView.mas_bottom).offset(-28);
        make.width.mas_equalTo(80);
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textLabel.mas_right).offset(20);
        make.right.mas_equalTo(footView.mas_right).offset(-28);
        make.top.mas_equalTo(footView.mas_top).offset(28);
        make.bottom.mas_equalTo(footView.mas_bottom).offset(-28);
        //make.height.mas_equalTo(100);
    }];
    
}

//#pragma mark - 设置tabbar隐藏
//- (BOOL)hidesBottomBarWhenPushed
//{
//
//    return YES;
//}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.item.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *accessory = indexPath.row == 4 ? nil : @"accessory";
    
    HTBaseCell *cell = [HTBaseCell baseCellWithTableView:tableView andItem:self.item[indexPath.row] accessory:accessory];
    if(indexPath.row == 1){
        self.cell = cell;
    }
    if (indexPath.row == 2 && self.cell.middleLabel.text.length == 0) {
        cell.userInteractionEnabled = NO;
        cell.backgroundColor = LXRGBColor(239, 239, 239);
    }else {
        cell.userInteractionEnabled = YES;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if (indexPath.row == 4) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 50, 13, 21, 21)];
        label.text = @"万";
        
        [cell addSubview:label];
    }
    
    return cell;
}

#pragma mark - cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    HTBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    HTBaseControllerTableViewController *pushVc = [[HTBaseControllerTableViewController alloc] init];
    
    pushVc.params = self.params;
    if ([cell.item[@"textLabel"] isEqualToString:@"类别"]) {
        pushVc.title = @"选择寻车类型";
        pushVc.sourceDic = self.item[indexPath.row];
        pushVc.dataSourceArr = self.typeArray;
        self.hidesBottomBarWhenPushed = YES;
    } else if ([cell.item[@"textLabel"] isEqualToString:@"车型"]) {
        
        
        pushVc.title = @"选择品牌";
        pushVc.sourceDic = self.item[indexPath.row];
        
        self.hidesBottomBarWhenPushed = YES;
    } else if ([cell.item[@"textLabel"] isEqualToString:@"颜色"]) {
        
        pushVc.title = @"选择外观颜色";
        pushVc.sourceDic = self.item[indexPath.row];
        //pushVc.params = self.params;
        
        
    } else if ([cell.item[@"textLabel"] isEqualToString:@"上牌城市"]) {
        
        pushVc.sourceDic = self.item[indexPath.row];
        
        pushVc.title = @"上牌城市";
        
    }else if ([cell.item[@"textLabel"] isEqualToString:@"提车价格"]) {
        
        return ;
    }else if ([cell.item[@"textLabel"] isEqualToString:@"有效期"]) {
        
        pushVc.sourceDic = self.item[indexPath.row];
        pushVc.title = @"有效期";
        pushVc.dataSourceArr = self.effectiveTimeArray;
        //self.hidesBottomBarWhenPushed = NO;
    }
    [self.navigationController pushViewController:pushVc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - tetField的代理
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;
//{
//    [textField resignFirstResponder];
//    
//    [textField endEditing:YES];
//    
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(LQCTextView *)textView{
    if ( textView.hasText) {
        self.middleTextView.holerString = @"";
        [self.middleTextView display];
        //NSLog(@"%@",self.middleTextView.holerString );
    }else{
        //NSLog(@"%@",self.middleTextView.holerString );
        self.middleTextView.holerString = @"请输入您的备注信息";
        [self.middleTextView display];
        [self.tableView reloadData];
    }
    
}
@end
