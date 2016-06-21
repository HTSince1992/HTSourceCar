//
//  HTDisplayCarModel.h
//  HTSourceCar
//
//  Created by Page on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTDisplayCarModel : NSObject
/**
 *  车源ID
 */
@property (nonatomic,copy) NSString *carId;
/**
 *  车型：宝马528 Li 14
 */
@property (nonatomic,copy) NSString *carModel;
/**
 *  车源类型 国产、美规、中东
 */
@property (nonatomic,copy) NSString *carType;
/**
 *  车源：国产、美规、中东
 */
@property (nonatomic,copy) NSString *carSource;
/**
 *  外观颜色：黑，白
 */
@property (nonatomic,copy) NSString *outsideColor;
/**
 *  内观颜色：黑，白
 */
@property (nonatomic,copy) NSString *insideColor ;

/**
 *  销售地点：销全国，北京
 */
@property (nonatomic,copy) NSString *city;
/**
 *  指导价
 */
@property (nonatomic,copy) NSString *guidePrice ;
/**
 *  下行价格
 */
@property (nonatomic,copy) NSString *disPrice;
/**
 *  成交价
 */
@property (nonatomic,copy) NSString *dealPrice;
/**
 *  销售A名称
 */
@property (nonatomic,copy) NSString *sellerName;
/**
 *  销售A名称
 */
@property (nonatomic,copy) NSString *sellerCity;

/**
 *  发布日期
 */
@property (nonatomic,copy) NSString *createTimeHM;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)displayCarModelWithDict:(NSDictionary *)dict;


@end
