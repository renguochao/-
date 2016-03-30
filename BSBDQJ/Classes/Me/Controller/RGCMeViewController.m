//
//  RGCMeViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/30.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCMeViewController.h"

@interface RGCMeViewController ()

@end

@implementation RGCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];

    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];

    self.navigationItem.rightBarButtonItems = @[settingItem, nightModeItem];
    
}

- (void)settingClick {
    RGCLogFunc;
}

- (void)nightModeClick {
    RGCLogFunc;
}

@end
