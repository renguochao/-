//
//  RGCPushGuideView.m
//  BSBDQJ
//
//  Created by rgc on 16/4/4.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCPushGuideView.h"

@implementation RGCPushGuideView

+ (instancetype)guideView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

+ (void)show {
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        RGCPushGuideView *guideView = [RGCPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)close {
    [self removeFromSuperview];
}

@end
