//
//  RGCFriendTrendViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/14.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCFriendTrendViewController.h"

@interface RGCFriendTrendViewController ()

@end

@implementation RGCFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
//    self.title = @"我的关注";
//    self.navigationItem.title = @"我的关注";
//    self.tabBarItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    UIButton *friendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    friendsButton.size = friendsButton.currentBackgroundImage.size;
    [friendsButton addTarget:self action:@selector(friendsClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendsButton];
    
}

- (void)friendsClick {
    RGCLogFunc;
}

@end
