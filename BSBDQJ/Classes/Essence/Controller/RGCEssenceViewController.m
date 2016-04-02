//
//  RGCEssenceViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/30.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCEssenceViewController.h"
#import "RGCRecommendTagsViewController.h"

@interface RGCEssenceViewController ()

@end

@implementation RGCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick {
    
    RGCRecommendTagsViewController *tags = [[RGCRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:tags animated:YES];
    
}

@end
