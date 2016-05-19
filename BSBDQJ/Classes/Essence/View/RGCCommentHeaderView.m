//
//  RGCCommentHeaderView.m
//  BSBDQJ
//
//  Created by rgc on 16/5/19.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCCommentHeaderView.h"

@interface RGCCommentHeaderView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation RGCCommentHeaderView

+ (instancetype)headerViewWithTabelView:(UITableView *)tableView {
    static NSString *ID = @"header";
    // 先从缓存池中找header
    RGCCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        header = [[RGCCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = RGCGlobalBg;
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGCColor(67, 67, 67);
        label.width = 200;
        label.x = RGCTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    
    _title = [title copy];
    
    self.label.text = title;
}

@end
