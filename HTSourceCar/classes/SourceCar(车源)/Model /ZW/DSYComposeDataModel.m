//
//  DSYComposeDataModel.m
//  HTSourceCar
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "DSYComposeDataModel.h"
#import "DSYmain.h"

@implementation DSYComposeDataModel


-(instancetype)initWitchDict:(NSDictionary * )dict{
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)DSYComposeWitchDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
