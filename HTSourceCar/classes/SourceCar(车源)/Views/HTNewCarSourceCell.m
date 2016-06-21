//
//  HTNewCarSourceCell.m
//  HTSourceCar
//
//  Created by Page on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTNewCarSourceCell.h"
#import <Masonry.h>
#import "HTDisplayCarModel.h"

@interface HTNewCarSourceCell ()

//车型
@property (nonatomic,strong) UILabel *CarmodelLabel;

//成交价
@property (nonatomic,strong) UILabel *dealPriceLabel;

//车属性
@property (nonatomic,strong) UILabel *carTypeLabel;

//指导价
@property (nonatomic,strong) UILabel *guidePriceLabel;

//车主及所属城市
@property (nonatomic,strong) UILabel *sellerNameLabel;

//日期
@property (nonatomic,strong) UILabel *createTimeLabel;

@end

@implementation HTNewCarSourceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //自定义控件
        [self setUI];
        
    }
    return self;
}

//自定义控件
- (void)setUI
{
    //车型 Carmodel
    UILabel *CarmodelLabel = [[UILabel alloc] init];
    self.CarmodelLabel = CarmodelLabel;
    
    //添加到父控件
    [self.contentView addSubview:CarmodelLabel];
    
    //成交价格dealPrice
    UILabel *dealPriceLabel = [[UILabel alloc] init];
    self.dealPriceLabel = dealPriceLabel;
    [self.contentView addSubview:dealPriceLabel];
    
    //车类型carType	：现车，热销车型，平行车 //outsideColor 外观色 //内失色insideColor //销售城市
    UILabel *carTypeLabel = [[UILabel alloc] init];
    self.carTypeLabel = carTypeLabel;
    //添加到父控件
    [self.contentView addSubview:carTypeLabel];
    
    //指导价guidePrice //下行价格disPrice
    UILabel *guidePriceLabel = [[UILabel alloc] init];
    guidePriceLabel.font = [UIFont systemFontOfSize:15];
    self.guidePriceLabel = guidePriceLabel;
    //添加到父控件
    [self.contentView addSubview:guidePriceLabel];
    
    //sellerName车主名字(sellerCity销售所属城市)
    UILabel *sellerNameLabel = [[UILabel alloc] init];
    self.sellerNameLabel = sellerNameLabel;
    //添加到父控件
    [self.contentView addSubview:sellerNameLabel];
    
    //日期createTime
    UILabel *createTimeLabel = [[UILabel alloc] init];
    self.createTimeLabel = createTimeLabel;
    //添加到父控件
    [self.contentView addSubview:createTimeLabel];
    
    
}

//设置子控件约束
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //车型 Carmodel
    [self.CarmodelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边20
        make.left.equalTo(self.contentView.mas_left).offset(20);
        
        //居上32
        make.top.equalTo(self.contentView.mas_top).offset(32);
        
//        make.height.equalTo(@60);
        
        
    }];
    
    //成交价格dealPrice
    [self.dealPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //右边20
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        //居上32
        make.top.equalTo(self.contentView.mas_top).offset(32);
        
    }];
    
    //车类型carType
    [self.carTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //居上20
        make.top.equalTo(self.CarmodelLabel.mas_bottom).offset(20);
        //左边
        make.left.equalTo(self.contentView.mas_left).offset(20);
        
        
    }];
    
    //指导价guidePrice
    [self.guidePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //居上20
        make.top.equalTo(self.dealPriceLabel.mas_bottom).offset(20);
        
//        make.width.equalTo(@);
        
        //右边20
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        
    }];
    
    //sellerName车主名字
    [self.sellerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.carTypeLabel.mas_bottom).offset(20);
        
        //左边20
        make.left.equalTo(self.contentView.mas_left).offset(20);
        
        //右边20
        make.right.equalTo(self.contentView.mas_right).offset(-20);

        
    }];
    
    //日期
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //上边20
        make.top.equalTo(self.guidePriceLabel.mas_bottom).offset(20);
        
        //右边20
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    
    }];

}


//重写DisplayCarModel的set的方法,给控件设置值
- (void)setDisplayCarModel:(HTDisplayCarModel *)DisplayCarModel
{
    _DisplayCarModel = DisplayCarModel;
    
    /**
     *  2016-04-13 15:35:57.890 HTSourceCar[55080:316133] 成交价格类型__NSCFNumber
     2016-04-13 15:35:57.890 HTSourceCar[55080:316133] 指导价类型__NSCFNumber
     2016-04-13 15:35:57.890 HTSourceCar[55080:316133] 日期类型__NSCFString
     */
    
    //设置控件值
    //车型Carmodel
    self.CarmodelLabel.text = DisplayCarModel.carModel;
    
//    //成交价格dealPrice
     int price2 = [DisplayCarModel.dealPrice  intValue]/10000;
    self.dealPriceLabel.text = [NSString stringWithFormat:@"%02d万",price2];
    
    //车类型carType	：现车，热销车型，平行车 //outsideColor 外观色 //内失色insideColor //销售城市
    self.carTypeLabel.text = [NSString stringWithFormat:@"%@|%@/%@",DisplayCarModel.carType,DisplayCarModel.outsideColor,DisplayCarModel.insideColor];
    
//    //指导价guidePrice //下行价格disPrice
    int price1 = [DisplayCarModel.guidePrice  intValue]/10000;
    self.guidePriceLabel.text = [NSString stringWithFormat:@"指导价:%02d万/%@",price1,DisplayCarModel.disPrice];
    
    //sellerName车主名字(sellerCity销售所属城市)
    if (DisplayCarModel.sellerCity == nil) {
        self.sellerNameLabel.text = [NSString stringWithFormat:@"%@",DisplayCarModel.sellerName];
    }else
    {
        self.sellerNameLabel.text = [NSString stringWithFormat:@"%@(%@)",DisplayCarModel.sellerName,DisplayCarModel.sellerCity];
    }
    
    //日期createTime
    self.createTimeLabel.text = DisplayCarModel.createTimeHM;
    
}



@end
