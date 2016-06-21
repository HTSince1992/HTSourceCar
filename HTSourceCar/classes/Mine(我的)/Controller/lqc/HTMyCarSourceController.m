//
//  HTMyAttentionController.m
//  HTSourceCar
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTMyCarSourceController.h"


@interface HTMyCarSourceController ()

@end

@implementation HTMyCarSourceController

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @[
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:NSLocalizedString(@"编辑", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                 ////这里就是点击后执行的代码
                 
                 [self performSegueWithIdentifier:@"edit" sender:self];
                 
             }],
             
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:NSLocalizedString(@"删除", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                 
             }]
             ];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // HTAttentionDetailCongtroller *pushVc = [[HTAttentionDetailCongtroller alloc] init];
    
    //[self.navigationController performSegueWithIdentifier:@"attentionDetail" sender:nil];
}

@end
