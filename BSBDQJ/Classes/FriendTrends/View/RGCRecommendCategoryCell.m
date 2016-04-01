//
//  RGCRecommendCategoryCell.m
//  BSBDQJ
//
//  Created by rgc on 16/3/15.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCRecommendCategoryCell.h"
#import "RGCRecommendCategory.h"

@interface RGCRecommendCategoryCell()

/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation RGCRecommendCategoryCell

- (void)awakeFromNib {
    // 从xib中创建的cell都会执行此方法
    self.backgroundColor = RGCColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = RGCColor(219, 21, 26);
}

/**
 *  这个方法可监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : RGCColor(78, 78, 78);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setCategory:(RGCRecommendCategory *)category {
    
    _category = category;
    
    self.textLabel.text = category.name;
}

@end
