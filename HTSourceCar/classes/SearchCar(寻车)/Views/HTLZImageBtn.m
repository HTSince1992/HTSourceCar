//
//  HTLZImageBtn.m
//  HTSourceCar
//
//  Created by 张 on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTLZImageBtn.h"

@implementation HTLZImageBtn


-(void)layoutSubviews{

    
    [super layoutSubviews];
    [self.imageView sizeToFit];
  [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
     
      make.bottom.mas_equalTo(self.mas_bottom);
      
      make.centerX.mas_equalTo(self.mas_centerX);
      
      
      
  }];

}
@end
