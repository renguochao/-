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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
}

- (void)friendsClick {
    RGCLogFunc;
}

@end
