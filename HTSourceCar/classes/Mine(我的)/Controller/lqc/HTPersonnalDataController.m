//
//  HTPersonnalDataController.m
//  HTSourceCar
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTPersonnalDataController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>



@interface HTPersonnalDataController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *pickerVc;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, weak) UIImage *image;

@end

@implementation HTPersonnalDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        self.coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        [self.view addSubview:self.coverView];
        
        //取消//摄像头//相册
        NSArray *temArr = @[@"取消",@"摄像头拍照",@"本地相册"];
        for (int i = 0; i < 3; ++i) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, HEIGHT - 49 * (i + 2), WIDTH, 49)];
            
            btn.layer.borderWidth = 1;
            
            btn.layer.borderColor = [UIColor whiteColor].CGColor;
            
            btn.tag = i;
            
            btn.backgroundColor = [UIColor grayColor];
            
            [btn setTitle:temArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:view:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.coverView addSubview:btn];
        }
    }
}

-(void)btnClick:(UIButton *)sender view:(UIView *)view
{
    self.pickerVc = [[UIImagePickerController alloc] init];
    if (sender.tag == 0) {
        
        
        self.coverView.hidden = YES;
        [self.coverView removeFromSuperview];
        return ;
    } else if(sender.tag == 1){
        
        [self isAllowUsePhoto];
        //判断照相机功能是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            //设置拍照后的照片是否允许编辑
            self.pickerVc.allowsEditing=YES;
            
            //设置访问照相机
            self.pickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickerVc.delegate=self;
            
        } else {
            //如果照相功能不可用
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"照相功能不可用!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    } else if (sender.tag == 2){
        //访问相册功能
        [self isAllowUseCamera];

    }
    
}

#pragma mark - 摄像头
-(void)isAllowUsePhoto
{
    //1. 判断
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    //2. 创建ImagePicker
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //3. 设置代理
    picker.delegate = self;
    
    //4. 设置类型
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //5. 弹出
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)isAllowUseCamera{
    
    //1. 判断
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    //2. 创建ImagePicker
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //3. 设置代理
    picker.delegate = self;
    
    //4. 设置类型
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //5. 弹出
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 选中相册图片时调用方法
//选中相册中的图片时，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //相机调用

        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.finish(image);
        
        //保存到相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    else
    {
       
        //self.image =
        self.finish(info[UIImagePickerControllerOriginalImage]);
        self.coverView.hidden = YES;
        
        [self.coverView removeFromSuperview];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
