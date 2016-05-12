//
//  RGCTopic.m
//  BSBDQJ
//
//  Created by rgc on 16/4/17.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTopic.h"
#import <MJExtension.h>

@implementation RGCTopic {
    CGFloat _cellHeight;
    BOOL _bigPicture;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

/**
 今年
     今天
         1分钟内
            刚刚
         1小时内
            xx分钟前
         其他
            xx小时前
     昨天
         昨天 18:56:34
     其他
         06-23 19:56:23
 
 非今年
     2014-05-08 18:45:30
 */
- (NSString *)create_time {
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if(cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

/** cell的高度 */
- (CGFloat)cellHeight {
    
    if (!_cellHeight) {
        // 文字frame属性
        CGFloat textY = RGCTopicCellTextY;
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * RGCTopicCellMargin, MAXFLOAT);
        CGFloat textH = [_text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        CGFloat toolbarH = RGCTopicCellBottomBarH;
        
//        _cellHeight = textY + textH + toolbarH + RGCTopicCellMargin + RGCTopicCellMargin;
        // 文字部分高度
        _cellHeight = textY + textH + RGCTopicCellMargin;
        
        // 根据段子类型计算cell的高度
        if (self.type == RGCTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= RGCTopicCellPictureMaxH) { // 图片高度过长
                pictureH = RGCTopicCellPictureBreakH;
                self.bigPicture = YES; // 大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = RGCTopicCellMargin;
            CGFloat pictureY = textY + textH + RGCTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + RGCTopicCellMargin;
            
        } else if (self.type == RGCTopicTypeVoice) { // 声音帖子
            
            CGFloat voiceX = RGCTopicCellMargin;
            CGFloat voiceY = textY + textH + RGCTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + RGCTopicCellMargin;
            
        } else if (self.type == RGCTopicTypeVideo) {
            CGFloat videoX = RGCTopicCellMargin;
            CGFloat videoY = textY + textH + RGCTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + RGCTopicCellMargin;
        }
        
        _cellHeight += toolbarH + RGCTopicCellMargin;
    }
    
    return _cellHeight;
}
@end
