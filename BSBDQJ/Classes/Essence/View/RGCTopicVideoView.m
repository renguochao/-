//
//  RGCTopicVideoView.m
//  BSBDQJ
//
//  Created by rgc on 16/5/11.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTopicVideoView.h"
#import "RGCTopic.h"
#import "RGCShowPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface RGCTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation RGCTopicVideoView

+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
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
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 设置ImageView
        self.imageView.image = image;
        
    }];
    
    // 设置播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 设置音频时长
    NSInteger minutes = topic.voicetime / 60;
    NSInteger seconds = topic.voicetime % 60;
    
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minutes, seconds];
    
}

@end
