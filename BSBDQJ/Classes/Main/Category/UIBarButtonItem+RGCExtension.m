//
//  UIBarButtonItem+RGCExtension.m
//  BSBDQJ
//
//  Created by rgc on 16/3/31.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "UIBarButtonItem+RGCExtension.h"

@implementation UIBarButtonItem (RGCExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
