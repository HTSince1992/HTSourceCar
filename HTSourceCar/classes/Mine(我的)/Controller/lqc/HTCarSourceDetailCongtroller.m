//
//  HTAttentionDetailCongtroller.m
//  HTSourceCar
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTCarSourceDetailCongtroller.h"
#import "LZparticipationTableViewController.h"

@interface HTCarSourceDetailCongtroller ()

@property (nonatomic, assign) BOOL RightItemIsClick;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, weak) UIView *secendCoverView;
@end

@implementation HTCarSourceDetailCongtroller

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (IBAction)rightItemClick:(id)sender {
    
    self.coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.coverView];
    
    UIButton *coverBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    
    [coverBtn setTitle:@"" forState:0];
    
    [coverBtn addTarget:self action:@selector(CoverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.coverView addSubview:coverBtn];
    
    //取消//摄像头//相册
    NSArray *temArr = @[@"收藏",@"分享",@"退定金",@"成交"];
    for (int i = 0; i < 4; ++i) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 80, 64 + 50 * i , 80, 50)];
        
        btn.layer.borderWidth = i;
        
        btn.hidden = YES;
        
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        
        btn.tag = i;
        
        btn.backgroundColor = [UIColor grayColor];
        
        [btn setTitle:temArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.coverView addSubview:btn];
    }

    
}

#pragma mark - CoverBtnClick
-(void)CoverBtnClick
{
    self.coverView.hidden = YES;
    [self.coverView removeFromSuperview];
}

-(void)btnClick:(UIButton *)sender
{
    NSString *str = @"确定退定金后,当前的车源信息状态讲变更为新发布状态.";
    NSString *str1 = @"确定成交后,当前的车源信息状态讲变更为全额成交状态.";
    switch (sender.tag) {
        case 0:
            
            break;
        case 1:
            
            [self myShare];
            break;
        case 2:
            
            [self creatMiddleView:str];
            break;
        case 3:
            
            [self creatMiddleView:str1];
            break;
            
        default:
            break;
    }
}

#pragma mark - 分享
-(void)myShare
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *shareText  = @"这个是分享文字";
        NSURL    *shareUrl   = [NSURL URLWithString:@"http://www.baidu.com"];
        //UIImage  *shareImage = [UIImage imageNamed:@"123"];
        NSArray  *shareArr   = @[shareText,shareUrl];
        
        UIActivityViewController *actionController = [[UIActivityViewController alloc] initWithActivityItems:shareArr applicationActivities:nil];
        
        // 分享回调：iOS8以后用completionWithItemsHandler了
        actionController.completionHandler = ^(NSString *activityType, BOOL completed) {
            
            
            if (completed) {
                
                NSLog(@"分享成功");
            }
        };
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 推出界面
            [self presentViewController:actionController animated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"defaultaleat" object:nil];
            
        });
        
        
        
    });
}
-(void)creatMiddleView:(NSString *)content{
    
    self.coverView.hidden = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    
    self.secendCoverView = view;
    
    view.backgroundColor = [UIColor colorWithWhite:239 / 255.0 alpha:0.5];
    
    [self.view addSubview:view];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, WIDTH - 80, 150)];
    
    middleView.center = self.view.center;
    
    middleView.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:middleView];
    
    UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, WIDTH - 120, 25)];
    
    tishiLabel.text = @"提示";
    
    tishiLabel.textColor = [UIColor blueColor];
    
    [middleView addSubview:tishiLabel];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, WIDTH - 80, 1)];
    
    topLineView.backgroundColor = [UIColor blueColor];
    
    [middleView addSubview:topLineView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, WIDTH - 120, 60)];
    
    
    
    contentLabel.numberOfLines = 0;
    
    contentLabel.text = content;
    
    [middleView addSubview:contentLabel];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, WIDTH - 80, 1)];
    
    bottomLineView.backgroundColor = [UIColor blackColor];
    
    [middleView addSubview:bottomLineView];
    
    NSArray *arr = @[@"取消",@"确定"];
    
    for (int i = 0; i < 2; ++i) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0 + (WIDTH - 80) * 0.5 * i, 110, (WIDTH - 80) * 0.5, 40)];
        
        btn.tag = i;
        
        [btn setTitle:arr[i] forState:0];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn addTarget:self action:@selector(middleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [middleView addSubview:btn];
        
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH - 80) * 0.5, 120, 1, 20)];
    
    lineView.backgroundColor = [UIColor blackColor];
    
    [middleView addSubview:lineView];
}
-(void)middleBtnClick:(UIButton *) sender
{
    [self.secendCoverView removeFromSuperview];
    if (sender.tag) {
        
        [self.coverView removeFromSuperview];
        
    } else {
        self.coverView.hidden = NO;
    }
}

@end
