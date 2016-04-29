//
//  RGCTopicPictureView.m
//  BSBDQJ
//
//  Created by rgc on 16/4/25.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTopicPictureView.h"
#import "RGCTopic.h"
#import "RGCProgressView.h"
#import "RGCShowPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface RGCTopicPictureView()
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件 */
@property (weak, nonatomic) IBOutlet RGCProgressView *progressView;
@end

@implementation RGCTopicPictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 为图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    RGCShowPictureViewController *showPicture = [[RGCShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(RGCTopic *)topic {
    _topic = topic;
    
    // 立即显示最新的进度值
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // 如果是大图，才需要绘图处理
        if (topic.isBigPicture == NO) {
            return;
        }
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 设置ImageView
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    // 设置gif是否隐藏
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示『点击查看大图』
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
    } else {
        self.seeBigButton.hidden = YES;
    }
}

@end
