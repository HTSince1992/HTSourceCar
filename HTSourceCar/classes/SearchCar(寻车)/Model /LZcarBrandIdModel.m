//
//  LZcarBrandIdModel.m
//  HTSourceCar
//
//  Created by 张 on 16/4/13.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "LZcarBrandIdModel.h"

@implementation LZcarBrandIdModel

-(instancetype)initWithDict:(NSDictionary *)dict WithUid:(NSInteger)uid
{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        self.uid = uid;
        
                
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{



}
@end
