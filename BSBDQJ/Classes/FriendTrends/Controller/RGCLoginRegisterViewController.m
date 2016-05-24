//
//  RGCLoginRegisterViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/4/4.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCLoginRegisterViewController.h"
#import "RGCTopWindow.h"

@interface RGCLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
/** 登录框距离控制器view左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation RGCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    
//    NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    [placeHolder setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, 1)];
//    [placeHolder setAttributes:@{
//                                 NSForegroundColorAttributeName : [UIColor redColor],
//                                 NSFontAttributeName : [UIFont systemFontOfSize:30]} range:NSMakeRange(1, 1)];
    
//    self.phoneField.attributedPlaceholder = placeHolder;
    
    [RGCTopWindow hide];
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant -= self.view.width;
        button.selected = YES;
//        [button setTitle:@"已有账号" forState:UIControlStateNormal];
    } else {
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
//        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        // 马上更新布局
        [self.view layoutIfNeeded];
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)close:(id)sender {
    [RGCTopWindow show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
