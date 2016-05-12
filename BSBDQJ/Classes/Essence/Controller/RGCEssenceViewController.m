//
//  RGCEssenceViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/30.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCEssenceViewController.h"
#import "RGCRecommendTagsViewController.h"
#import "RGCTopicViewController.h"

@interface RGCEssenceViewController () <UIScrollViewDelegate>
/** 标签栏底部的指示器view */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的Button */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的标签栏view */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的contentView */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation RGCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVcs];
    
    // 设置顶部的标签
    [self setupTitlesView];
    
    // 底部的scrollView
    [self setupContentView];
    
}

/**
 *  初始化子控制器
 */
- (void)setupChildVcs {
    
    RGCTopicViewController *all = [[RGCTopicViewController alloc] init];
    all.title = @"全部";
    all.type = RGCTopicTypeAll;
    [self addChildViewController:all];
    
    RGCTopicViewController *video = [[RGCTopicViewController alloc] init];
    video.title = @"视频";
    video.type = RGCTopicTypeVideo;
    [self addChildViewController:video];
    
    RGCTopicViewController *voice = [[RGCTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = RGCTopicTypeVoice;
    [self addChildViewController:voice];
    
    RGCTopicViewController *picture = [[RGCTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = RGCTopicTypePicture;
    [self addChildViewController:picture];
    
    RGCTopicViewController *word = [[RGCTopicViewController alloc] init];
    word.title = @"段子";
    word.type = RGCTopicTypeWord;
    [self addChildViewController:word];
    
}


/**
 *  设置顶部的标签
 */
- (void)setupTitlesView {
    // 标签整体
    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = RGCTitlesViewH;
    titlesView.y = RGCTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;

    // 底部指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    //    indicatorView.width = width;
    indicatorView.tag = 100;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * button.width;
        button.tag = i;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
//        [button layoutIfNeeded]; // 强制布局（强制更新子控件的frame）
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
    
}

- (void)titleClicked:(UIButton *)button {
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    self.selectedButton = button;
    self.selectedButton.enabled = NO;
    
    // 让标签执行动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  底部的scrollView
 */
- (void)setupContentView {
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * contentView.width, 0);
//    [contentView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
//    contentView.contentSize = CGSizeMake(self.view.width, 1000);
//    [self.view addSubview:contentView];
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)setupNav {
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = RGCGlobalBg;
}

- (void)tagClick {
    
    RGCRecommendTagsViewController *tags = [[RGCRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:tags animated:YES];
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 添加子控制器的view
    // 当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    // vc默认的y值为20，需手动调整
    vc.view.y = 0;
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger tag = scrollView.contentOffset.x / scrollView.width;
    UIButton *btn = self.titlesView.subviews[tag];
    [self titleClicked:btn];
}

@end
