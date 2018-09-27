//
//  ViewController.m
//  TextFiledDemo
//
//  Created by yfc on 17/5/19.
//  Copyright © 2017年 yfc. All rights reserved.
//

#import "ViewController.h"
#import "MTextField.h"
#import "LikeCellView.h"
#import "UIView+Utils.h"

@interface ViewController ()
@property(nonatomic,retain)MTextField *cardNoWTTextFiled;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    UIScrollView *scrollow = [[UIScrollView alloc]initWithFrame:CGRectZero];
    scrollow.top = 0;
    scrollow.left = 0;
    scrollow.width = SCREEN_WIDTH_NEW;
    scrollow.height = SCREEN_HEIGHT_NEW;
    scrollow.contentSize = CGSizeMake(SCREEN_WIDTH_NEW, SCREEN_HEIGHT_NEW+1);
    [self.view addSubview:scrollow];
    
#warning 如果模拟器运行 要打开HardWare->Keyboard->Toggle Software Keyboard
    
    double space = 0.0;
    //
    //这里就只拿系统键盘了 自己定义键盘就不展示了
    //
    LikeCellView *a1 = [[LikeCellView alloc]initWithFrame:CGRectZero title:@"测试1" placeholder:@"数字键盘" keyBoardType:@"N"];
    a1.top = 280;
    [scrollow addSubview:a1];

    LikeCellView *a2 = [[LikeCellView alloc]initWithFrame:CGRectZero title:@"测试2" placeholder:@"UIKeyboardTypeDefault" keyBoardType:@"UIKeyboardTypeDefault"];
    a2.top = a1.bottom + space;
    [scrollow addSubview:a2];
    
    LikeCellView *a3 = [[LikeCellView alloc]initWithFrame:CGRectZero title:@"测试3" placeholder:@"UIKeyboardTypeASCIICapable" keyBoardType:@"UIKeyboardTypeASCIICapable"];
    a3.top = a2.bottom + space;
    [scrollow addSubview:a3];
    
    LikeCellView *a4 = [[LikeCellView alloc]initWithFrame:CGRectZero title:@"测试4" placeholder:@"UIKeyboardTypeNumbersAndPunctuation" keyBoardType:@"UIKeyboardTypeNumbersAndPunctuation"];
    a4.top = a3.bottom + space;
    [scrollow addSubview:a4];
    
    LikeCellView *a5 = [[LikeCellView alloc]initWithFrame:CGRectZero title:@"测试5" placeholder:@"UIKeyboardTypeURL" keyBoardType:@"UIKeyboardTypeURL"];
    a5.top = a4.bottom + space;
    [scrollow addSubview:a5];
    
    LikeCellView *a6 = [[LikeCellView alloc]initWithFrame:CGRectZero title:@"测试6" placeholder:@"NN" keyBoardType:@"NN"];
    a6.top = a5.bottom + space;
    [scrollow addSubview:a6];
    
    
    scrollow.contentSize = CGSizeMake(SCREEN_WIDTH, a6.bottom +100);
}




@end
