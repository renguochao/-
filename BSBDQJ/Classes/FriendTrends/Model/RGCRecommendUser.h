//
//  RGCRecommendUser.h
//  BSBDQJ
//
//  Created by rgc on 16/3/31.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGCRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
