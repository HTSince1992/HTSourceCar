//
//  LZSiftTableViewCell.m
//  HTSourceCar
//
//  Created by 张 on 16/4/15.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZSiftTableViewCell.h"



@implementation LZSiftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            UILabel *topTestLabel = [[UILabel alloc]init];
            
            topTestLabel.font = [UIFont systemFontOfSize:18];
            topTestLabel.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:topTestLabel];
            self.topTextLabel = topTestLabel;
            
            
            [self.topTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {

                make.top.mas_equalTo(self.mas_top).offset(10);
                
                make.left.mas_equalTo(self.mas_left).offset(10);
                
                make.right.mas_equalTo(self.mas_right).offset(-10);
                
                make.height.mas_equalTo(30);
            }];
            
            
            
            UILabel *bottomDetailTextLabel = [[UILabel alloc]init];
            
            bottomDetailTextLabel.font = [UIFont systemFontOfSize:16];
            bottomDetailTextLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:bottomDetailTextLabel];
            self.bottomDetailTextLabel = bottomDetailTextLabel;
            
            
            [self.bottomDetailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.mas_equalTo(self.topTextLabel.mas_bottom).offset(10);
                make.left.mas_equalTo(self.mas_left).offset(10);
                
                make.right.mas_equalTo(self.mas_right).offset(-10);

                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);

                
            }];
            
            
            
        }];
        
        
        
    }
    
    return  self;
}
@end
