//
//  RGCTopicVideoView.h
//  BSBDQJ
//
//  Created by rgc on 16/5/11.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RGCTopic;

@interface RGCTopicVideoView : UIView
+ (instancetype)videoView;

/** 帖子数据 */
@property (nonatomic, strong) RGCTopic *topic;
@end
