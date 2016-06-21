//
//  HTMinePersDataTableViewController.m
//  HTSourceCar
//
//  Created by 谢亚鹏 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTMinePersDataTableViewController.h"
#import "HTMainPerDataTableViewCell.h"
@interface HTMinePersDataTableViewController ()

@end

@implementation HTMinePersDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"个人资料";
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
//加载cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HTMainPerDataTableViewCell *cell = [[HTMainPerDataTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"HTMainPerDataTableViewCell" owner:nil options:nil]lastObject];
    NSArray *array = @[@"姓名",@"个人头像",@"联系方式",@"所在部门",@"注册电话",@"城市"];
    cell.lablet.text = array[indexPath.row];
    if (indexPath.row == 0) {
        [cell.Btn setTitle:@"刘文明" forState:UIControlStateNormal];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.row == 1){
    
        [cell.Btn setImage:[UIImage imageNamed:@"code-w28h33"] forState:UIControlStateNormal];
        [cell.Btn setTitle:@"" forState:UIControlStateNormal];
        [cell.Btn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row == 2){
        cell.Btn.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath .row == 3){
        [cell.Btn setTitle:@"宝马销售组" forState:normal];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.row == 4){
        [cell.Btn setTitle:@"13001229240" forState:normal];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];


    }else if (indexPath.row == 5){
    [cell.Btn setTitle:@"北京" forState:normal];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
