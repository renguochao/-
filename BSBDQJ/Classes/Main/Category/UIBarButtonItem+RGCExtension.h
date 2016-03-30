//
//  UIBarButtonItem+RGCExtension.h
//  BSBDQJ
//
//  Created by rgc on 16/3/31.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RGCExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;

@end
