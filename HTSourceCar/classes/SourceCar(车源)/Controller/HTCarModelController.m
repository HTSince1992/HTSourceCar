//
//  HTCarModelController.m
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTCarModelController.h"
#import "HTCarsModel.h"
#import "HTCarGroup.h"

@interface HTCarModelController ()

//创建一个数组开存放所有的模型数据
@property (nonatomic,strong) NSArray *CarGroups;

@end

@implementation HTCarModelController

#pragma mark -懒加载数据
- (NSArray *)CarGroups
{
    if (_CarGroups == nil) {
        //加载数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
        _CarGroups = [NSArray arrayWithContentsOfFile:path];
        //遍历数组,将字典转化为模型
        NSMutableArray *ArrayCarGroup = [NSMutableArray array];
        for (NSDictionary *dict in _CarGroups) {
            HTCarGroup *model = [HTCarGroup CarGroupWithDict:dict];
            [ArrayCarGroup addObject:model];
        }
        _CarGroups = ArrayCarGroup;
    }
    return _CarGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
    //统一设置单元格的高度
    self.tableView.rowHeight = 60;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.CarGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HTCarGroup *cargroup = self.CarGroups[section];
    return cargroup.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建ID
    static NSString *ID = @"car_cell";
    
    //去缓冲池中查找
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //获取模型数据
    HTCarGroup *cargroup = self.CarGroups[indexPath.section];
    HTCarsModel *car = cargroup.cars[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    
    //返回单元格
    return cell;
    
}

//设置组高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 44;
}

#pragma mark-实现代理方法
//设置组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //获取数据
    HTCarGroup *cargroup = self.CarGroups[section];
    
    //创建headerview
    UIView *headerview = [[UIView alloc] init];
    headerview.bounds = CGRectMake(0, 0, self.view.frame.size.width, 44);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    //设置文字颜色
    titleLabel.textColor = [UIColor blackColor];
    
    //设置frame
    titleLabel.frame = CGRectMake(20, 0, 100, 44);
    
    //设置内容
    titleLabel.text = cargroup.title;
    
    headerview.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
    //添加到headerview
    [headerview addSubview:titleLabel];
    
    //返回headerview
    return headerview;
}

//设置右边的检索条
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.CarGroups valueForKey:@"title"];
}





@end
