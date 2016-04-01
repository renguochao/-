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
#import "RGCRecommendUser.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#define RGCSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

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
    
    // 控件初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [RGCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新左侧表格
        [self.categoryTableView reloadData];
        
        RGCLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
        
    }];
    
}

/**
 *  控件初始化
 */
- (void)setupTableView {
    
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:RGCCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:RGCUserId];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 设置标题
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = RGCGlobalBg;

}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
    
}

#pragma mark - 加载用户数据

- (void)loadNewUsers {
    
    RGCRecommendCategory *c = RGCSelectedCategory;
    
    // 设置当前页码为1
    c.currentPage = 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
    params[@"page"] = @(c.currentPage);
    
    // 发送请求给服务器，加载右侧数据
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 服务器返回的JSON数据
        NSArray *users = [RGCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [c.users removeAllObjects];
        [c.users addObjectsFromArray:users];
        
        // 保存总数
        c.total = [responseObject[@"total"] integerValue];
        
        // 刷新左侧表格
        [self.userTableView reloadData];
        
        // header结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 检测右侧tableview的footer状态
        [self checkFooterState];
        
        RGCLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
    
    
}

- (void)loadMoreUsers {
    
    RGCLogFunc;
    
    RGCRecommendCategory *category = RGCSelectedCategory;
    
    // 发送请求给服务器，加载右侧数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([category id]);
    params[@"page"] = @(++ category.currentPage);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        NSArray *users = [RGCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [[category users] addObjectsFromArray:users];
        
        // 刷新左侧表格
        [self.userTableView reloadData];
        
//        RGCLog(@"%@", responseObject);
        
        // 检测右侧tableview的footer状态
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
    
}

/**
 *  检测右侧tableview的footer状态
 *  根据c.users.count更新footer
 */
- (void)checkFooterState {
    
    // 左边被选中的类别数据
    RGCRecommendCategory *c = RGCSelectedCategory;
    
    // 每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (c.users.count == 0);
    
    // 刷新右边数据时，更新footer
    if (c.users.count == c.total) {  // 全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableView.mj_footer endRefreshing];
    }

}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else { // 右边的用户表格
        // 左边被选中的类别数据
        RGCRecommendCategory *c = RGCSelectedCategory;
        
        // 刷新右边数据时，更新footer
        [self checkFooterState];
//        if (c.users.count == c.total) {  // 全部加载完毕
//            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            [self.userTableView.mj_footer endRefreshing];
//        }
        
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        RGCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCCategoryId];
        cell.category = self.categories[indexPath.row];
        
        return cell;
    } else {
        RGCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCUserId];
        
        RGCRecommendCategory *c = RGCSelectedCategory;
        cell.user = c.users[indexPath.row];
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RGCRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
        
        if (c.users.count == c.total) { // 全部加载完毕
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } else {
        // 清除上一category数据, 马上显示当前category的用户数据
        [self.userTableView reloadData];
        
        // 设置当前页码为1
        c.currentPage = 1;
        
        // 发送请求给服务器，加载右侧数据
        [self.userTableView.mj_header beginRefreshing];
    }
    
}

@end
