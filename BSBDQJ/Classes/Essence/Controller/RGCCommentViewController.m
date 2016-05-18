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

@interface RGCCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RGCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasics];
    
    [self setupHeader];
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

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"热门";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    cell.textLabel.text = @"1";
    return cell;
}

@end
