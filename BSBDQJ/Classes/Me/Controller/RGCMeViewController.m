//
//  RGCMeViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/30.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCMeViewController.h"
#import "RGCMeCell.h"
#import "RGCMeFooterView.h"

@interface RGCMeViewController () <UITableViewDelegate, UITableViewDataSource, RGCMeFooterViewDelegate>
@property (nonatomic, strong) RGCMeFooterView *footerView;
@end

@implementation RGCMeViewController

static NSString * const RGCMeId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}

- (void)setupTableView {
    [self.tableView registerClass:[RGCMeCell class] forCellReuseIdentifier:RGCMeId];
    
    // 设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = RGCTopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(RGCTopicCellMargin - 35, 0, 20, 0);
    
    // 设置footerView
    RGCMeFooterView *footerView = [[RGCMeFooterView alloc] init];
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
}

- (void)setupNav {
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, nightModeItem];
    
    // 设置背景色
    self.tableView.backgroundColor = RGCGlobalBg;
}

- (void)settingClick {
    RGCLogFunc;
}

- (void)nightModeClick {
    RGCLogFunc;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else {
        cell.textLabel.text = @"离线下载";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - RGCMeFooterViewDelegate 
- (void)footerViewDidFinishLoad {
    CGFloat height = RGCTopicCellMargin * 3 + 44 * 2 + self.footerView.height;
    self.tableView.contentSize = CGSizeMake(RGCScreenW, height);
    [self.tableView setNeedsDisplay];
}

@end
