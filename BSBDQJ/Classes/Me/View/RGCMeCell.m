//
//  RGCMeCell.m
//  BSBDQJ
//
//  Created by rgc on 16/5/25.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCMeCell.h"

@implementation RGCMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        return;
    }
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + RGCTopicCellMargin;
}

@end
