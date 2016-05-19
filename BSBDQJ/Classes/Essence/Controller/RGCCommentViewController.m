//
//  RGCCommentViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/5/16.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCCommentViewController.h"
#import "RGCTopicCell.h"
#import "RGCTopic.h"
#import "RGCComment.h"
#import "RGCCommentHeaderView.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>

//static NSInteger const RGCHeaderLabelTag = 99;

@interface RGCCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
@end

@implementation RGCCommentViewController

- (NSMutableArray *)latestComments {
    if (!_latestComments) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasics];
    
    [self setupHeader];
    
    [self setupRefresh];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)loadNewComments {
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 最热评论
        self.hotComments = [RGCComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [RGCComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupHeader {
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    RGCTopicCell *cell = [RGCTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(RGCScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.height = self.topic.cellHeight + RGCTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
    
}

- (void)setupBasics {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = RGCGlobalBg;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    // 键盘显示、隐藏完毕的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 修改底部约束
    self.bottomSpace.constant = RGCScreenH - frame.origin.y;
    
    // 动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 强制修改的布局更新
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    // 控制器销毁时需要
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  返回section组的评论数据
 *
 *  @param section 组号
 *
 *  @return 该组号里面的评论数据
 */
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    
    return self.latestComments;
}

- (RGCComment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
    if (latestCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    } else {
        return latestCount;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 先从缓存池中找header
    RGCCommentHeaderView *header = [RGCCommentHeaderView headerViewWithTabelView:tableView];
    
    // 设置label数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    static NSString *ID = @"header";
//    // 先从缓存池中找header
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    
//    UILabel *label = nil;
//    
//    if (header == nil) { // 缓存池中没有，自己创建
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor = RGCGlobalBg;
//        // 创建label
//        label = [[UILabel alloc] init];
//        label.textColor = RGCColor(67, 67, 67);
//        label.width = 200;
//        label.x = RGCTopicCellMargin;
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        label.tag = RGCHeaderLabelTag;
//        [header.contentView addSubview:label];
//    } else { // 从缓存池中取出来的
//        label = [header viewWithTag:RGCHeaderLabelTag];
//    }
//    
//    // 设置label数据
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//    
//    return header;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    // 创建header
//    UIView *header = [[UIView alloc] init];
//    header.backgroundColor = RGCGlobalBg;
//    
//    // 创建label
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = RGCColor(67, 67, 67);
//    label.width = 200;
//    label.x = RGCTopicCellMargin;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [header addSubview:label];
//    
//    // 设置文字
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//    
//    return header;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSInteger hotCount = self.hotComments.count;
//    
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        return @"最新评论";
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    RGCComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    return cell;
}

@end
