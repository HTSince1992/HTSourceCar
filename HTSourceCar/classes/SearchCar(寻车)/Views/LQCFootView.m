//
//  LQCFootView.m
//  HTSourceCar
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LQCFootView.h"
#import "UIView+LZExtension.h"
#import "LZSiftResultFootView.h"

@interface LQCFootView ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation LQCFootView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, WIDTH - 40, 21)];
        
        lable.text = @"联系人:";
        
        [self addSubview:lable];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
        
        tableView.Y = 55;
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        tableView.rowHeight = 80;
        
        [self addSubview:tableView];
    }
    return self;
}

#pragma mark - data数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"leipeng";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"man"];
    //[cell.imageView sizeToFit];
    cell.textLabel.text = self.hostName;
    cell.detailTextLabel.text = @"tel:18233116914";
    
    
    //电话
    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 140, 20, 60, 40)];
    phoneBtn.backgroundColor = [UIColor redColor];
    
    [phoneBtn setTitle:@"电话" forState:UIControlStateNormal];
    
    [cell addSubview:phoneBtn];
    
    //收藏
    UIButton *collectBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 70, 20, 60, 40)];
    collectBtn.backgroundColor = [UIColor redColor];
    
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];

    
    [cell addSubview:collectBtn];
    
    return cell;
}

//-(void)collectBtnClick{
//    
//   // NSString *str = @"defaultaleatAction";
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"collect" object:nil];
//    
//    
//}

@end
