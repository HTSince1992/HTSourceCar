//
//  LZparticipationTableViewCell.m
//  HTSourceCar
//
//  Created by 张 on 16/4/16.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZparticipationTableViewCell.h"

@implementation LZparticipationTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        UIImageView *myImageView = [[UIImageView alloc] init];
        
        [myImageView sizeToFit];
        
        [self addSubview:myImageView];
        
        self.myImageView = myImageView;
        
        [myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.centerY.mas_equalTo(self.mas_centerY);
            
            make.left.mas_equalTo(self.mas_left).offset(15);
            
        }];
        
        UILabel *myTexeLabel = [[UILabel alloc]init];
        
        myTexeLabel.textColor = [UIColor whiteColor];
        
        
        [self addSubview:myTexeLabel];
        self.myTexeLabel = myTexeLabel;
        
        [myTexeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.mas_equalTo(self.mas_centerY);
            
            make.left.mas_equalTo(myImageView.mas_right).offset(20);
        }];
        
        
    }

    return self;
}
@end
