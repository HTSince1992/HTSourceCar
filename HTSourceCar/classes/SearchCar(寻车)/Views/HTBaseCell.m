//
//  HTBaseCell.m
//  HTSourceCar
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTBaseCell.h"

@interface HTBaseCell ()<UITextFieldDelegate>
@end

@implementation HTBaseCell

+(instancetype)baseCellWithTableView:(UITableView *)tableView andItem:(NSDictionary *)item accessory:(NSString *)accessory
{
    NSString* cellid = @"cell";
    
    //重用
    HTBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    // 如果缓存池没有找到
    if (!cell) {
        
        cell = [[HTBaseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    

    
    
    cell.item = item;
    
    cell.accessory = accessory;
    
    return cell;
}

//返回cell的类型
+(UITableViewCellStyle)loadCellTypeWithItem:(NSDictionary*)item
{
    NSString* cellType = item[@"cellType"];
    
    if ([cellType isEqualToString:@"UITableViewCellStyleSubtitle"]) {
        return UITableViewCellStyleSubtitle;
    }
    else if ([cellType isEqualToString:@"UITableViewCellStyleValue1"]) {
        return UITableViewCellStyleValue1;
    }
    else if ([cellType isEqualToString:@"UITableViewCellStyleValue2"]) {
        return UITableViewCellStyleValue2;
    }
    else {
        return UITableViewCellStyleDefault;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *midleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, -3, 200, 50)];
        
        self.middleLabel = midleLabel;
        
        [self addSubview:midleLabel];
    }
    return self;
}

-(void)setItem:(NSDictionary *)item
{
    _item = item;
    
    [self setUI:item];
}

-(void)setUI:(NSDictionary *)item
{
    //左侧文字
    self.textLabel.text = item[@"textLabel"];
    
    
    //中间的lable
    if ([item[@"middleLabel"] isEqualToString:@"label"]) {
        
        
        self.middleLabel.text = @"wocaonimei";
        
        
    } else if([item[@"middleLabel"] isEqualToString:@"textField"]){
        UITextField *middleTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 8, WIDTH - 150, 30)];
        
        middleTextField.placeholder = @"请输入金额";
        middleTextField.delegate = self;
        
        middleTextField.backgroundColor = LXRGBColor(239, 239, 239);
        
        self.middleTextField = middleTextField;
        
        self.middleTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 25, WIDTH - 150, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [middleTextField addSubview:line];
        [self addSubview:middleTextField];
    }
    
    //获取 accessory
    if ([item[@"middleLabel"] isEqualToString:@"accessory"]) {
        
        UIImageView *view = [[UIImageView alloc] init];
        
        view.image = [UIImage imageNamed:@"jiantou-w16h30"];
        
        [view sizeToFit];
        
        self.accessoryView = view;
    } else if ([item[@"middleLabel"]  isEqualToString:@"switch"]){
        //获取开关
        UISwitch *sw = [[UISwitch alloc] init];
        
        self.accessoryView = sw;
    }
    
    
}


-(void)setAccessory:(NSString *)accessory
{
    _accessory = accessory;
    
    [self setRightView:accessory];
}

-(void)setRightView:(NSString *)accessory
{
    //获取 accessory
    if ([self.accessory isEqualToString:@"accessory"]) {
        
        UIImageView *view = [[UIImageView alloc] init];
        
        view.image = [UIImage imageNamed:@"jiantou-w16h30"];
        
        [view sizeToFit];
        
        self.accessoryView = view;
    } else if ([accessory isEqualToString:@"switch"]){
        //获取开关
        UISwitch *sw = [[UISwitch alloc] init];
        
        self.accessoryView = sw;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{


    [self.middleTextField resignFirstResponder];
    
    return YES;
    
}
@end
