//
//  HTBaseCell.h
//  HTSourceCar
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTBaseCell : UITableViewCell

@property (strong, nonatomic) NSMutableDictionary* item;

@property (nonatomic, copy) NSString *accessory;

@property (nonatomic, weak) UILabel *middleLabel;

@property (nonatomic, weak) UITextField *middleTextField;

+(instancetype)baseCellWithTableView:(UITableView*)tableView andItem:(NSDictionary*)item accessory:(NSString *)accessory;
@end
