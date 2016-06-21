//
//  LZSearchCarTableViewCell.m
//  HTSourceCar
//
//  Created by 张 on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//




#import "LZSearchCarTableViewCell.h"
#import "LZSearchCarModel.h"
#import "sys/utsname.h"



@interface LZSearchCarTableViewCell()
@property(nonatomic,weak)UILabel *carName;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *carColorLabel;
@property(nonatomic,weak)UILabel *cityLabel;
@property(nonatomic,weak)UIImageView *LzImageView;


@end
@implementation LZSearchCarTableViewCell

-(void)setSearchCarModel:(LZSearchCarModel *)SearchCarModel{
    
    _SearchCarModel = SearchCarModel;
    
    
    self.carName.text = self.SearchCarModel.carModelName;
    
    self.carColorLabel.text = SearchCarModel.outsideColor;
    
    self.cityLabel.text = [NSString stringWithFormat:@"%@ (%@)",SearchCarModel.userName,SearchCarModel.city];
   // NSString *str = self.SearchCarModel.carModelName;
    
    
    
    NSString *time = [SearchCarModel.createTimeStr substringFromIndex:11];
    
    self.timeLabel.text = time;
    
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self cellSetSubViews];
        
    }
    
    return self;
}



-(void)cellSetSubViews{
    
    UILabel *carName = [[UILabel alloc]init];
    carName.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:carName];
    self.carName = carName;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:14];
    
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    
    
    UILabel *carColorLabel = [[UILabel alloc]init];
    carColorLabel.font = [UIFont systemFontOfSize:14];
    self.carColorLabel = carColorLabel;
    [self addSubview:carColorLabel];
    
    
    UILabel *cityLabel = [[UILabel alloc]init];
    cityLabel.font = [UIFont systemFontOfSize:14];
    cityLabel.textColor = [UIColor blackColor];
    
    
    self.cityLabel = cityLabel;
    [self addSubview:cityLabel];
    
    UIImageView *LzImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cheng-w28h28"]];
    
    [LzImageView sizeToFit];
    [self addSubview:LzImageView];
    self.LzImageView = LzImageView;

    
    [self setmake];
    
    
    
}

//#pragma mark -添加约束
-(void)setmake{
    
    
    [self.carColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.carName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.height.mas_equalTo(30);
        
       // make.right.mas_equalTo(self.timeLabel.mas_left).offset(10);
        
        
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        
        make.centerY.mas_equalTo(self.carName.mas_centerY);
        
        
        
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.carColorLabel.mas_centerY);
        
        
    }];

    [self.LzImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.carName.mas_right).offset(15);
        make.centerY.mas_equalTo(self.carName.mas_centerY);
        
    }];
    
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (iPhone5){

        
        [self.carName mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.size.width.mas_equalTo(180);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.height.mas_equalTo(30);

        }];
        [self.LzImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.carName.mas_centerY);
            make.right.mas_equalTo(self.timeLabel.mas_left).offset(-20);

            
        }];
        
    }

}

@end
