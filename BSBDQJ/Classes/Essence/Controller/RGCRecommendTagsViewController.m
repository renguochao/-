//
//  RGCRecommendTagsViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/4/1.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCRecommendTagsViewController.h"
#import "RGCRecommendTag.h"
#import "RGCRecommendTagCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface RGCRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;

@end

static NSString *const RGCTagId = @"tag";

@implementation RGCRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTableView];
    
    [self loadTags];
}

- (void)setupTableView {
    self.title = @"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:RGCTagId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGCGlobalBg;
    
}

- (void)loadTags {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        self.tags = [RGCRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RGCRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCTagId];
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
