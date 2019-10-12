//
//  ViewController.m
//  指纹识别
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
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)buttonclick:(UIButton *)button{
    LAContext *lactx = [[LAContext alloc]init];
    [lactx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"我需要您的指纹登录" reply:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"指纹识别成功");
        }else{
            NSLog(@"指纹识别错误");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
