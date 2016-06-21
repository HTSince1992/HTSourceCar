//
//  HTBrandListModel.h
//  aa
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detail : NSDictionary

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL boolean;

@end


@interface LQCBrandListModel : NSObject

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, copy) NSArray *brandList;

@property (nonatomic, strong) detail *brandtail;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end




