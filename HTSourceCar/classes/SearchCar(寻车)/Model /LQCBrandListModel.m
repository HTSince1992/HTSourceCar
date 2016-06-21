//
//  HTBrandListModel.m
//  aa
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LQCBrandListModel.h"



@implementation LQCBrandListModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        //[self setValuesForKeysWithDictionary:dic];
        _data = dic[@"data"];
        _brandList = _data[@"brandList"];
    }
    
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    
}

-(void)setData:(NSDictionary *)data
{
    _data = data;
    
    _brandList = data[@"brandList"];
}

-(void)setBrandList:(NSArray *)brandList
{
    _brandList = brandList;
    
}
@end
