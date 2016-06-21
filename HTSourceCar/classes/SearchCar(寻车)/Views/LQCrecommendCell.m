//
//  LQCrecommendCell.m
//  HTSourceCar
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LQCrecommendCell.h"

@interface LQCrecommendCell ()

@property(nonatomic, strong) UILabel *detail;

@end

@implementation LQCrecommendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    //车名
    _carName = [[UILabel alloc] initWithFrame:CGRectMake(20, 34, WIDTH * 0.5, 26)];
    
    //_carName.text = self.arr[0];
    
    [self addSubview:_carName];
    
    //价格
    _price = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.5, 34, WIDTH * 0.5 - 20, 26)];
    
    //_price.text = self.arr[1];
    
    _price.textAlignment = 2;
    
    _price.textColor= [UIColor redColor];
    
    [self addSubview:_price];
    
    //detail
    _detail = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, WIDTH * 0.5, 25)];
    
    //_detail.text = self.arr[2];
    
    _detail.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_detail];
    
    //指导价
    _guidPrice = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.5, 80, WIDTH * 0.5 - 20, 25)];
    
    //_guidPrice.text = self.arr[3];
    
    _guidPrice.textAlignment = 2;
    
    _guidPrice.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_guidPrice];
    
    //车主姓名
    _hostName = [[UILabel alloc] initWithFrame:CGRectMake(20, 125, WIDTH * 0.5, 25)];
    
    //_hostName.text = self.arr[4];
    
    _hostName.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_hostName];
    
    //发布时间
    _time = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.5, 125, WIDTH * 0.5 - 20, 25)];
    
    _time.textAlignment = 2;
    
    _time.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_time];
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    //价格
    if ([dic[@"price"] length] > 0)
    {
        CGFloat price = [dic[@"price"] floatValue];
        
        CGFloat aa = arc4random() % 50 / 10.0;
        
        price = arc4random() % 2 ? price + aa : price - aa;
        
        self.myPrice = price;
        
        _price.text = [NSString stringWithFormat:@"%0.2f万", price];
    }
    //NSLog(@"%f", self.myPrice);
    
    if ([dic[@"color"] length] > 0) {
        
        _detail.text = [NSString stringWithFormat:@"现车|%@|销全国",dic[@"color"]];
    } else{
        _detail.text =@"现车|销全国";
    }
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    NSTimeInterval t = 24*60*60;
    
    //时间
    formatter.dateFormat = @"MM月dd日 HH:mm:ss";
    
    NSDate *tow = [NSDate dateWithTimeIntervalSinceNow:-t * (arc4random() % 5)];
    
    _time.text = [formatter stringFromDate:tow];
    _hostName.text = dic[@"hostName"][arc4random() % 5];
    _guidPrice.text = dic[@"price"];
    _carName.text = dic[@"carSeries"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
