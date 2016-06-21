//
//  HTBaseControllerTableViewController.h
//  HTSourceCar
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTBaseControllerTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *sourceDic;

@property (nonatomic, strong) NSArray *dataSourceArr;

@property (nonatomic, strong) NSMutableDictionary *params;

@end
