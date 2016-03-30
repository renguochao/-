//
//  RGCEssenceViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/30.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCEssenceViewController.h"

@interface RGCEssenceViewController ()

@end

@implementation RGCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边按钮
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
}

- (void)tagClick {
    RGCLogFunc;
}

@end
