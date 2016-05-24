//
//  RGCTopWindow.m
//  BSBDQJ
//
//  Created by rgc on 16/5/23.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTopWindow.h"

static UIWindow *window_;

@implementation RGCTopWindow

+ (void)initialize {
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, RGCScreenW, 20);
    window_.backgroundColor = [UIColor clearColor];
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show {
    window_.hidden = NO;
}

+ (void)hide {
    window_.hidden = YES;
}

/**
 *  监听窗口点击
 */
+ (void)windowClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview，滚动到最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续递归查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
