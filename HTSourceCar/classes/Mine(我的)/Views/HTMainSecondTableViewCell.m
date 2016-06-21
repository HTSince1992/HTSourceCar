//
//  HTMainSecondTableViewCell.m
//  HTSourceCar
//
//  Created by 谢亚鹏 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTMainSecondTableViewCell.h"
#import "HTMineViewController.h"


@implementation HTMainSecondTableViewCell


- (IBAction)mySource:(id)sender {
    [self.delegate cellWithBtnClick:nil];
    

    
    
}
- (IBAction)myMessage:(id)sender {
    
[self.delegate cellWithBtnClick1:nil];
}

- (IBAction)myFindCar:(id)sender {
    [self.delegate cellWithBtnClick2:nil];
}
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}



@end


