//
//  LZSiftListTableViewController.m
//  HTSourceCar
//
//  Created by 张 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZSiftListTableViewController.h"
#import "LZcarBrandIdModel.h"
#import "LZSiftView.h"
#import "LZcarBrandIdModel.h"
@interface LZSiftListTableViewController ()

@property(nonatomic,strong)LZcarBrandIdModel *model;
@property(nonatomic,copy)NSString *uid;

@end

@implementation
LZSiftListTableViewController

static NSString *identifier=@"LZSiftListTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.backgroundColor = LXRGBColor(236, 236, 236);
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 30, 40)];
    headLabel.backgroundColor = [UIColor whiteColor];
    headLabel.text = @"   全部";
    headLabel.font = [UIFont systemFontOfSize:16];
    headLabel.textColor = LXRGBColor(186, 186, 186);
    
    self.tableView.tableHeaderView = headLabel;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.BrandIdArray.count;
    ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    LZcarBrandIdModel *model = self.BrandIdArray[indexPath.row];
    
    //    cell.backgroundColor = [UIColor redColor];
    
    //    LXLog(@"name%@ ,color%@,city%@",model.name,model.outsideColor,model.city);
    if (model.uid == 0) {
        
        cell.textLabel.text = model.name;
        self.uid = @"0";
        
    }else if (model.uid == 1){
        
        cell.textLabel.text = model.outsideColor;
        
        self.uid = @"1";
    }else if (model.uid == 2){
        
        cell.textLabel.text = model.city;
        self.uid = @"2";
    }
    // self.model = model;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"certain_link"]];;
    
    
    [cell setSelectedBackgroundView:image];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *userinfo = [NSMutableDictionary dictionary];
    
    
    if ([self.uid isEqualToString:@"0"]) {
        userinfo[@"name"] = cell.textLabel.text;
        
    }else if ([self.uid isEqualToString:@"1"]){
        userinfo[@"color"] = cell.textLabel.text;
    }else if ([self.uid isEqualToString:@"2"]){
        
        userinfo[@"city"] = cell.textLabel.text;
        
    }else{
        
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"siftListData" object:nil userInfo:userinfo];
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = LXRGBColor(236, 236, 236);
    
    view.frame = CGRectMake(0, 0, 10, 10);
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 20;
}

@end
