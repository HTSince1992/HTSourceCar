//
//  HTDetailRecommedController.h
//  HTSourceCar
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQCrecommendCell.h"

@interface HTDetailRecommedController : UITableViewController

@property (nonatomic, strong) NSDictionary *sourceDic;

@property (nonatomic, weak) LQCrecommendCell *superCell;

@end
