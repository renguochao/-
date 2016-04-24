//
//  RGCTopicViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/4/17.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "RGCTopic.h"
#import "RGCTopicCell.h"

@interface RGCTopicViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation RGCTopicViewController

- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
}

static NSString * const RGCTopicCellId = @"topic";
- (void)setupTableView
{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = RGCTitlesViewY + RGCTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCTopicCell class]) bundle:nil] forCellReuseIdentifier:RGCTopicCellId];
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_footer.hidden = YES;
}

#pragma mark - 数据处理
/**
 * 加载新的帖子数据
 */
- (void)loadNewTopics {
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *responseObject) {
        
        if (self.params != params) {
            return;
        }
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [RGCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新tableview
        [self.tableView reloadData];
        
        // 停止刷新控件
        [self.tableView.mj_header endRefreshing];
        
        // 清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return;
        
        // 停止刷新控件
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 * 加载更多帖子数据
 */
- (void)loadMoreTopics {
    
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *responseObject) {
        
        if (self.params != params) {
            return;
        }
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [RGCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 刷新tableview
        [self.tableView reloadData];
        
        // 停止刷新控件
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return;
        
        // 停止刷新控件
        [self.tableView.mj_footer endRefreshing];
        
        // 恢复页码
        self.page--;
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RGCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCTopicCellId];
    cell.topic = [self.topics objectAtIndex:indexPath.row];
    
    //    RGCTopic *topic = [self.topics objectAtIndex:indexPath.row];
    //    cell.textLabel.text = topic.name;
    //    cell.detailTextLabel.text = topic.text;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出帖子模型
    RGCTopic *topic = [self.topics objectAtIndex:indexPath.row];
    
    // 文字frame属性
    CGFloat textY = RGCTopicCellTextY;
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
    CGFloat textH = [topic.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    CGFloat toolbarH = RGCTopicCellBottomBarH;
    
    return textY + textH + toolbarH + RGCTopicCellMargin + RGCTopicCellMargin;
}

@end
