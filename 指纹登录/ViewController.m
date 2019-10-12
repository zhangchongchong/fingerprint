//
//  ViewController.m
//  指纹登录
//
//  Created by 张冲 on 2018/2/28.
//  Copyright © 2018年 张冲. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"指纹识别" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)buttonclick:(UIButton *)button{
    LAContext *lactx = [[LAContext alloc]init];
    lactx.localizedFallbackTitle = @"999";
    lactx.localizedCancelTitle = @"0000";
    NSError *error = nil;
   __block NSString *messageString = @"";
    if ([lactx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [lactx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"我需要您的指纹登录" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"指纹识别成功");
            }else{
                switch (error.code) {
                    case LAErrorAuthenticationFailed: //三次机会失败 -- 身份验证失败
                        NSLog(@"三次机会，身份验证失败");
                        messageString = @"三次机会，身份验证失败";
                        break;
                    case LAErrorUserCancel: //认证被取消
                        NSLog(@"用户点击取消按钮");
                        messageString = @"用户点击取消按钮";
                        break;
                    case LAErrorSystemCancel: //身份验证被系统取消（比如另一个应用程序去前台,切换到其他app）
                        NSLog(@"身份信息被系统取消");
                        messageString = @"身份信息被系统取消";
                        break;
                    case  LAErrorPasscodeNotSet: //身份验证无法启动，因为密码在设备上没有设置
                        NSLog(@"身份验证无法启动,没有设置密码");
                        messageString = @"身份验证无法启动,没有设置密码";

                        break;
                    case kLAErrorTouchIDNotAvailable: //身份验证无法启动，因为触摸id在设备上不可用
                        NSLog(@"touchId无法使用");
                        messageString = @"touchId无法使用";
                        break;
                    case LAErrorBiometryNotEnrolled: //身份验证无法启动，因为没有等级的手指触摸id
                        NSLog(@"没有设置指纹");
                        messageString = @"没有设置指纹";
                        break;
                    default:
                        NSLog(@"Touch ID没配置");
                        messageString = @"Touch ID没配置";
                        break;
                }
                dispatch_async (dispatch_get_main_queue(), ^{

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误提示"
                                                                message:messageString
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
                NSLog(@"指纹识别错误");
                });
            }
        }];
    }else{
        dispatch_async (dispatch_get_main_queue(), ^{

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误提示"
                                                            message:@"您的设备没有触摸ID."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        });
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
