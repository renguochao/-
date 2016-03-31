//
//  RGCTestViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/31.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTestViewController.h"

@implementation RGCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XMGTestViewController";
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
