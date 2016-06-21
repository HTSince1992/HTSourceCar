//
//  HTDetailSourceCarController.h
//  HTSourceCar
//
//  Created by Page on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTDisplayCarModel.h"

@interface HTDetailSourceCarController : UITableViewController

//接收传递过来的数据模型
@property (nonatomic,strong) HTDisplayCarModel *carmodel;

@end
