//
//  RGCCommentCell.h
//  BSBDQJ
//
//  Created by rgc on 16/5/20.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGCComment;

@interface RGCCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) RGCComment *comment;
@end
