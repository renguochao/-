//
//  RGCRecommendViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/15.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCRecommendViewController.h"
#import "RGCRecommendCategoryCell.h"
#import "RGCRecommendCategory.h"
#import "RGCRecommendUserCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface RGCRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/** 左边类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 左边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@end

@implementation RGCRecommendViewController

static NSString * const RGCCategoryId = @"category";
static NSString * const RGCUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = RGCGlobalBg;
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        RGCLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
        
    }];
    
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:RGCCategoryId];
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:RGCUserId];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        RGCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCCategoryId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    } else {
        RGCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCUserId];
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RGCRecommendCategory *category = self.categories[indexPath.row];
}

@end
