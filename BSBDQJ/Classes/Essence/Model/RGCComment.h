//
//  RGCComment.h
//  BSBDQJ
//
//  Created by rgc on 16/5/12.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGCUser;

@interface RGCComment : NSObject
/** 音频文件时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) RGCUser *user;
@end
