//
//  HTComposeSourceController.m
//  HTSourceCar
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "HTComposeSourceController.h"
#import "HTComposeTableViewCell.h"
#import "DSYComposeDataModel.h"
#import  "HTAccount.h"
#import "DSYmain.h"
#import "HTdsyTextView.h"

//----------
#import  "HTdsyCarTypeController.h"
#import "HTdsyCarSourecController.h"
#import "HTdsyMakeColorController.h"
#import "HTdsyMeCityController.h"


static NSString * cellID = @"DSYcellID";
@interface HTComposeSourceController ()<UITabBarControllerDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>

///  品牌列表
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSArray * temparr;

/// 文字信息
@property(nonatomic,copy) NSString * massage;

//选中cell
@property(nonatomic,weak) HTComposeTableViewCell * cell;

//判断颜色按钮cell
@property(nonatomic,weak) HTComposeTableViewCell * colorCell;

@property(nonatomic,strong)NSMutableArray *nmarray;

@property(nonatomic,copy) NSString * brandId;

@property(nonatomic,strong)HTdsyTextView * textView;




@end

@implementation HTComposeSourceController

//push 是不显示BottomBar
- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

//发布控制器
//懒加载数组
-(NSArray *)dataArray{

    if (_dataArray ==nil) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)nmarray{

    if (_nmarray == nil) {
        _nmarray = [NSMutableArray arrayWithObjects:@"",@"",@"38.5",@"",@"",@"",@"",@"",@"",@"", nil];
    }
    return _nmarray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //添加footerView
    [self setTextView];
   
    self.tableView.showsVerticalScrollIndicator = NO;
 
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"notification" object:nil];
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jianpanshouqi) name:UIKeyboardWillShowNotification object:nil];
    
    //设置标题
    self.navigationItem.title = @"发布车源";
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVc)];
    
    //添加 提交按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitItemClick)];
    
    // 注册cell
    [self.tableView registerClass:[HTComposeTableViewCell class] forCellReuseIdentifier:cellID];
    [self tempData];
     [self dataWith:0];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //赋通知回来的值
    if (self.massage!=nil) {
        //获取当前行
        NSInteger  row = [self.tableView indexPathForCell:self.cell].row;
        //获取当前数据
//        NSString * st = self.nmarray[row];
        [self.nmarray removeObjectAtIndex:row];
    
//        st = self.massage;
//        self.nmarray[row] = st ;
        [self.nmarray insertObject:self.massage atIndex:row];

        [self.tableView reloadData];
    }
    [self.tableView reloadData];
    //赋值完成清空
    self.massage = nil;
    
}
#pragma mark ----通知方法-

-(void) loadData:(NSNotification*) noti{
    
    //获取数据
  self.massage = noti.userInfo[@"text"];

//    [self.nmarray addObject:noti.userInfo[@"text"]];
//    [self.nmarray insertObject: noti.userInfo[@"text"] atIndex:row];
    
    
//    NSIndexPath * inde = [NSIndexPath indexPathForRow:row inSection:0];
//    HTComposeTableViewCell * cell =  [self.tableView cellForRowAtIndexPath:inde];
//    cell.massageLb.text =  self.nmarray.lastObject;
    
}
-(void)dismissVc{
    [self.tableView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)tempData{
    
    //创建临时假数据数组
    self.temparr = @[
                     @{@"name":@"类型"},
                     @{@"name":@"车型"},
                     @{@"name":@"指导价",@"image":@0,},
                     @{@"name":@"颜色",},
                     @{@"name":@"成交价",@"image":@0,@"textField":@1,@"rightLb":@1},
                     @{@"name":@"优惠",@"image":@0,@"textField":@2,@"rightLb":@1},
                     @{@"name":@"区域",},
                     @{@"name":@"现车",@"UISwitch":@1},
                     @{@"name":@"热销车型",@"UISwitch":@1},
//                     @{@"name":@"备注",@"image":@0,@"textField":@1,@"TextView":@1,}
                 
                     ];

}

//提交按钮
-(void)commitItemClick{


   NSLog(@"点击提交按钮了");
  
   
    [self.tableView reloadData ];
    [self.tableView endEditing:YES];
    
     [self dataString];
    NSLog(@"%@",self.nmarray);
//    [self meaAnimation];
}

//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.temparr.count;
    
}

//cell长啥样
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    HTComposeTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[HTComposeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
     NSDictionary * dic = self.temparr[indexPath.row];
    //当车型没选中是 颜色不可点击
        if ( indexPath.row == 1){
            self.colorCell = cell;
        }
        if (indexPath.row == 3 && self.colorCell.massageLb.text.length == 0) {
            cell.userInteractionEnabled = NO;
            cell.titleLb.textColor = [UIColor colorWithWhite:239/255.0 alpha:1];
        }else{
            cell.userInteractionEnabled = YES;
            cell.titleLb.textColor = [UIColor blackColor];
        }//indexPath.row ==4||indexPath.row ==5||
    if (indexPath.row == 2||indexPath.row ==7||indexPath.row ==8) {
        cell.zzView.hidden = NO;
        
    }else{
        cell.zzView.hidden = YES;
    
    }
    
     cell.titleLb.text = dic[@"name"];
    cell.txtf.tag = indexPath.row;
    if(cell.txtf.tag==4 ){
        cell.txtf.keyboardType = UIKeyboardTypeNumberPad;
    
    }
    cell.txtf.delegate = self;

    if (dic[@"image"]) {
        cell.imag.hidden =YES;
    }else{
        cell.imag.hidden = NO;
    }
    //是否有按钮
    if (dic[@"UISwitch"]) {
        cell.sw.hidden = NO;
        cell.imag.hidden = YES;
        cell.massageLb.hidden = YES;
    }else{
        cell.sw.hidden = YES;
        cell.massageLb.hidden = NO;
    }
    if (dic[@"textField"]) {
        cell.txtf.hidden = NO;
        cell.line.hidden = NO;
        cell.massageLb.hidden = NO;
//       
            if (cell.txtf.tag == 4) {
               cell.txtf.placeholder = @"例:30.2";
            }else if(cell.txtf.tag ==5){
               cell.txtf.placeholder = @"例:下8或者下10点";
            }else{
               cell.txtf.placeholder = @"";
            }

////        cell.txtf.str = dic[@"textField"];
//        if ([dic[@"name"] isEqualToString:@"成交价"]) {
//            cell.txtf.placeholder = @"例:30.2";
//        }else if([dic[@"name"] isEqualToString:@"优惠"]){
//        cell.txtf.placeholder = @"例:下8或者下10点";
////           
//        }else {
//            cell.line.hidden = YES;
//        }
        
    }else{
        cell.txtf.hidden = YES;
        cell.line.hidden = YES;
        cell.massageLb.hidden = NO;
    }
    if (dic[@"rightLb"]) {
        cell.rightLb.hidden = NO;
        cell.rightLb .text = @"万";
    }else{
        cell.rightLb.hidden = YES;
    }

    if (indexPath.row == 7|| indexPath.row==8) {
          cell.massageLb.text = @"";
    }else{
    cell.massageLb.text = self.nmarray[indexPath.row];
    }
    
  
    return  cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


//点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell = [tableView cellForRowAtIndexPath:indexPath];
    HTComposeTableViewCell * dataCell =  [tableView cellForRowAtIndexPath:indexPath];
    dataCell.sw.on = !dataCell.sw.on ;
    dataCell.userInteractionEnabled = !dataCell.userInteractionEnabled;
   [dataCell.contentView bringSubviewToFront:dataCell.sw];
    
   HTdsyCarTypeController * tpVC = [[HTdsyCarTypeController alloc]init];
    HTdsyMeCityController * meCity = [[HTdsyMeCityController alloc]init];
    switch (indexPath.row) {
        case 0:
            //类型
            [self.navigationController pushViewController:tpVC  animated:YES];
            break;
           case 1:
            //车型
            [self dataWith:indexPath.row];//发送网络请求
            [self.navigationController pushViewController:[[HTdsyCarSourecController alloc]initwith:self.dataArray ]animated:YES];
            case 2:
            NSLog(@"点击了2");
            break;
        case 3:
            /// 请求 发布颜色列表
            [self.navigationController pushViewController:[[HTdsyMakeColorController alloc]initWithString:self.brandId]  animated:YES];
            break;
            case 4:
         
            NSLog(@"点击了4");
            break;
            
            case 5:

           NSLog(@"点击了5");
            break;
        case 6:
            //城市列表
            [self.navigationController pushViewController:meCity animated:YES];
            break;
        case 7:
            [dataCell.contentView bringSubviewToFront:dataCell.sw];
            dataCell.sw.on = !dataCell.sw.on;
            if (!dataCell.sw.isOn) {
                [self.nmarray removeObjectAtIndex:7];
                [self.nmarray insertObject:dataCell.titleLb.text atIndex:7];
//                [dataCell.contentView sendSubviewToBack:dataCell.sw];
                 NSLog(@"点击了7 -- %@",self.nmarray);
            }else{
                [self.nmarray removeObjectAtIndex:7];
                [self.nmarray insertObject:@"" atIndex:7];
                  NSLog(@"点击了7 -- %@",self.nmarray);
            }

            break;
        case 8:
            [dataCell.contentView bringSubviewToFront:dataCell.sw];
            dataCell.sw.on = !dataCell.sw.on;
            if (!dataCell.sw.isOn) {
                [self.nmarray removeObjectAtIndex:8];
                [self.nmarray insertObject:dataCell.titleLb.text atIndex:8];
//                [dataCell.contentView sendSubviewToBack:dataCell.sw];
                
            }else{
                [self.nmarray removeObjectAtIndex:8];
                [self.nmarray insertObject:@""atIndex:8];
                NSLog(@"点击了7 -- %@",self.nmarray);
            }
            
           NSLog(@"点击了8");
            break;
        default:
            break;
    }
    dataCell.sw.on = !dataCell.sw.on ;
    
     [dataCell.contentView sendSubviewToBack:dataCell.sw];
    [self.tableView reloadData];
}

//滚动动协议
//开始滚动 收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.view endEditing:YES];

}

/// 获取品牌列表

-(void)dataWith:(NSInteger)row {

    NSMutableDictionary  * dict = [NSMutableDictionary dictionary];
    dict[@"accountid"] = @"1";
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://iosapi.itcast.cn/car/band.json.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //反序列化
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //获取品牌列表
        NSArray * arr = dict[@"data"][@"brandList"];
        
        //获取brandId
        self.brandId = dict[@"data"][@"brandList"][row][@"brandId"];
     
        //创建可变数组
        NSMutableArray * muArr = [ NSMutableArray array];
        
        for (NSDictionary * dic in arr) {
            
        DSYComposeDataModel * mo = [[DSYComposeDataModel alloc] initWitchDict:dic];
            
            [muArr addObject:mo];
        }
      
      //给数组赋值
        self.dataArray = muArr.copy;
        
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

///车源发布
-(void)composeCar{
//http://iosapi.itcast.cn/car/publish.json.php
     NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    ///    响应报文格式:
    
    //opttype	int	不可以	1:发布；2：编辑
    dict[@"opttype"] =@1;
    // cartype	字符串	不可以	车源类型 国产、美规、中东
    dict[@"opttype"] =@"国产";
    //carmodelid	字符串	不可以	车型ID
    dict[@"carmodelid"] = @"车型ID";
    //outsidecolor	字符串	不可以	外观颜色:红，蓝，白...
    dict[@"outsidecolor"] = @"红";
    //insidecolor	字符串	不可以	内观颜色：红，蓝，白...
    dict[@"insidecolor"] = @"蓝";
    //guideprice	Int	不可以	指导价格(转换成单位：元)
    dict[@"guideprice"] = @1;
    //city	字符串	不可以	销售城市：不限，北京，上海。
    dict[@"city"] = @"北京";
    //disprice	字符串	不可以	优惠价。下8万
    dict[@"disprice"] = @"优惠价。下8万";
    //dealrice	int	不可以	成交价(转换成单位：元)
    dict[@"dealrice"] = @252;
    //iscurcar	字符串	不可以	是否现车：Y：是；N：不是
    dict[@"iscurcar"] = @"是否现车：Y：是；N：不是";
    //ishotcar	字符串	不可以	是否热销车型：Y：是；N：不是
    dict[@"ishotcar"] = @"是否热销车型：Y：是";
    //isparcar	字符串	不可以	是否平行进口车：Y：是；N：不是
    dict[@"isparcar"] = @"是否平行进口车：Y：是；N：不是";
    //remark	字符串	不可以	备注
    dict[@"remark"] = @"备注";
    //accountid	字符串	不可以	用户ID
    dict[@"accountid"] = @1;
    //响应报文格式:
    //用户id
    dict[@"accountid"] = @1;
    
    [[HTNetworkTool sharedNetWorkTools]objectWithURLString:@"http://iosapi.itcast.cn/car/bandcity.json.php" RequsetOp:@"POST" AndParams:dict completeBlock:^(id object) {
        
        NSDictionary  *dict = (NSDictionary*)object;
        //            NSLog(@"%@",object);
        
        NSArray * arr = dict[@"data"][@"attrList"];
        
        NSLog(@"%@--",arr[0]);
        
   
    }];
}
-(void)jianpanshouqi{
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.contentOffset = CGPointMake(0, 200);
    }];
}


-(void)meaAnimation{
    //创建遮罩
    UIView * vi = [[UIView alloc]init];
    vi.frame = [UIScreen mainScreen].bounds;
    vi.alpha = 0.5;
    vi.backgroundColor = [UIColor blackColor];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, 200, 200)];
    //    label.backgroundColor = [UIColor colorWithWhite:239/255 alpha:1];
    label.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5,-200 );
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:25];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [vi addSubview:label];
    [self.navigationController.view insertSubview:vi aboveSubview:self.navigationController.navigationBar];
    //创建一个字符串
    NSString * str = @"我就静静的看着你装逼!";
    label.text  = str;
    //创建一个attributed
    NSMutableAttributedString *  attributed = [[NSMutableAttributedString alloc]initWithString:str] ;
    //添加属性  给所有字符设置字体为Zapfino，字体高度为13像素
    [attributed addAttribute: NSFontAttributeName value:[UIFont fontWithName:@"Zapfino" size:25] range:NSMakeRange(0, str.length)];
    
    //分段控制 最开始4个字符颜色设置成蓝色
    [attributed  addAttribute: NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(2, 1)];
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(3, 1)];
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4, 1)];
    //青色
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(5, 1)];
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(6, 1)];
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(7, 1)];
    
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, str.length-8)];
    //添加富文本
    
    label.attributedText = attributed;
    //添加动画
    [UIView animateWithDuration:3 animations:^{
        //改变freme
        label.center = vi.center;
    } completion:^(BOOL finished) {
        if (finished) {
            //旋转
            [UIView animateWithDuration:1 animations:^{
                //
                //label.transform = CGAffineTransformRotate(label.transform, 0.5);
                label.transform = CGAffineTransformMakeRotation(-M_PI);
            } completion:^(BOOL finished) {
                if (finished) {
                    //旋转
                    [UIView animateWithDuration:2 animations:^{
                        label.transform = CGAffineTransformMakeRotation(2*M_PI);
                        //缩小
                        label.transform  = CGAffineTransformScale(label.transform,0.5, 0.5);
                        
                    } completion:^(BOOL finished) {
                        if (finished) {
                            //放大
                            [UIView animateWithDuration:2 animations:^{
                                label.transform = CGAffineTransformScale(label.transform, 2.0, 2.0);
                                label.text = @"我走了,你慢慢玩";
                            } completion:^(BOOL finished) {
                                //设置延迟
                                [NSThread sleepForTimeInterval:1];
                                [label removeFromSuperview];
                                //                                self.navigationItem.rightBarButtonItem.enabled = YES;
                                //                                self.navigationItem.leftBarButtonItem.enabled = YES;
                                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                                    
                                    //弹框
                                    UIAlertView * lert = [[UIAlertView alloc]initWithTitle:@"已发布" message:@"请您细心等待" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消 ", nil];
                                    [lert show];
                                    
                                }];
                            }];
                            
                        }
                        
                    }];
                }
                
            }];
            
        }
        
    }];
    //  NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(meaAnimation) userInfo:nil repeats:YES];
    //    [timer fire];
    
    
}

//FooterView
-(void)setTextView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    
    UILabel * titleLb = [[UILabel alloc]init];
    titleLb.textColor = [UIColor blackColor];
    titleLb.font  = [UIFont systemFontOfSize:20];
    titleLb.text =@"备注";
    //创建TextView
    self.textView = [[HTdsyTextView alloc]init];
    self.textView .backgroundColor = [UIColor grayColor];
    self.textView.returnKeyType=UIReturnKeyDone;
    self.textView.alwaysBounceVertical = YES;
    //设置占位符
    self.textView.str = @"请输入您的备注信息";
    //设置代理
    self.textView.delegate = self;
    //代理方法   删除
    [self.textView deleteBackward];
    [view addSubview:titleLb];
    [view addSubview:self.textView];
    
    //设置约束
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(20);
        make.top.equalTo(view.mas_top).offset(10);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(110);
        make.top.equalTo(view.mas_top).offset(10);
        make.bottom.equalTo(view.mas_bottom);
        make.right.mas_equalTo(-60);
    }];
    
    self.tableView.tableFooterView  = view;
      [self.tableView reloadData];
}



-(void)textViewDidChange:(HTdsyTextView *)textView{
    if ( textView.hasText) {
       
        self.textView.str = @"";
        [self.textView need];
        [self.nmarray removeObjectAtIndex:9];
        [self.nmarray addObject:textView.text];
       
    }else{
      //保存信息
        self.textView.str = @"请输入您的备注信息";
         [self.textView need];
        [self.nmarray removeObjectAtIndex:9];
        [self.nmarray addObject:@""];
        [self.tableView reloadData];
    }
    
}

- (BOOL)textView:(HTdsyTextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder]; //当遇到\n失去响应 收起键盘
        
        return NO;
    }
    return YES;
}



//UITextFiel代理方法 监听改变完成
//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%ld",textField.tag);
    
    textField.placeholder = @"";
    [self.nmarray removeObjectAtIndex:textField.tag];
    [self.nmarray insertObject:@"" atIndex:textField.tag];
    
};

//结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 4 && textField.text.length == 0) {
        textField.placeholder = @"例:30.2";
    }
    if(textField.tag == 5 && textField.text.length == 0){
        textField.placeholder = @"例:下8或者下10点";
    }
    [self.nmarray removeObjectAtIndex:textField.tag];
    [self.nmarray insertObject:textField.text atIndex:textField.tag];

}

//清空
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    textField.placeholder = @"";
    [self.nmarray removeObjectAtIndex:textField.tag];
    [self.nmarray insertObject:@"" atIndex:textField.tag];
    return YES;
}
//点击return
- (BOOL)textFieldShouldReturn:( UITextField *)textField{
//    [self.tableView reloadData];
        return YES;
}

-(void)dataString{
    UITextView * TextView = [[UITextView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100,-350, 100, 350)];
    TextView.textColor = [UIColor magentaColor];
//    TextView.center = self.tableView.center;
    [self.view addSubview:TextView];
    TextView.text =[NSString stringWithFormat:@"类型:%@\n车型:%@\n指导价格:%@ 万\n颜色:%@\n成交价: 万%@\n优惠:%@ 万\n区域:%@\n是否现车:%@\n是否热销车型:%@\n备注:%@\n",self.nmarray[0],self.nmarray[1],self.nmarray[2],self.nmarray[3],self.nmarray[4],self.nmarray[5],self.nmarray[6],self.nmarray[7],self.nmarray[8],self.nmarray[9]];
    
    [UIView animateWithDuration:2 animations:^{
         TextView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,8, 350, 350);
    } completion:^(BOOL finished) {
        if (finished) {
            [TextView removeFromSuperview];
            [NSThread  sleepForTimeInterval:1];
            [self meaAnimation];
        }
        
    }];
    NSLog(@"%@--%@",TextView.text,self.nmarray[9] );
}

//移除通知
-(void)viewDisAppear:(BOOL)animated{
    

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
