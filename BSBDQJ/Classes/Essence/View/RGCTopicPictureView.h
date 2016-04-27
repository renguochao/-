//
//  RGCTopicPictureView.h
//  BSBDQJ
//
//  Created by rgc on 16/4/25.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RGCTopic;

@interface RGCTopicPictureView : UIView

+ (instancetype)pictureView;

/** 帖子数据 */
@property (nonatomic, strong) RGCTopic *topic;

@end
