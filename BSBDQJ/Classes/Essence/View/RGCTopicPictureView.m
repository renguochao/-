//
//  RGCTopicPictureView.m
//  BSBDQJ
//
//  Created by rgc on 16/4/25.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTopicPictureView.h"
#import "RGCTopic.h"
#import <UIImageView+WebCache.h>

@interface RGCTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@end

@implementation RGCTopicPictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(RGCTopic *)topic {
    _topic = topic;
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 设置gif是否隐藏
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
}

@end
