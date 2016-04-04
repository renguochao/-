//
//  RGCTextField.m
//  BSBDQJ
//
//  Created by rgc on 16/4/4.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTextField.h"
#import <objc/runtime.h>

static NSString *const RGCPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation RGCTextField

+ (void)initialize {
    
    [self getIvars];
    
}

+ (void)getIvars {
    
    unsigned int count = 0;
    
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i ++) {
        // 取出成员变量
        Ivar ivar = ivars[i];
        // 打印成员变量名字
//        RGCLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    // 释放
    free(ivars);
}

/**
 *  方法1：重载该方法，修改placeholder的样式
 */
//- (void)drawPlaceholderInRect:(CGRect)rect {
//    
//    [self.placeholder drawInRect:CGRectMake(0, 15, rect.size.width, 25) withAttributes:@{
//                                                       NSForegroundColorAttributeName : [UIColor whiteColor],
//                                                       NSFontAttributeName : self.font}];
//}

- (void)awakeFromNib {
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder {
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:RGCPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:RGCPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
