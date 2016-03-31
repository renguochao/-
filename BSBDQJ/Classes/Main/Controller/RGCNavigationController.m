//
//  RGCNavigationController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/31.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCNavigationController.h"

@implementation RGCNavigationController

/**
 *  第一次使用这个类的时候会调用一次
 */
+ (void)initialize {
    
    // 当导航栏用在RGCNavigationController中，appearance设置才会生效
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[([self class])]];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {  // 如果push进来的不是第一个控制器
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 让按钮内部的所有内容往左边偏移30
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
