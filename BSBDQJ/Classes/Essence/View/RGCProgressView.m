//
//  RGCProgressView.m
//  BSBDQJ
//
//  Created by rgc on 16/4/27.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCProgressView.h"

@implementation RGCProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

@end
