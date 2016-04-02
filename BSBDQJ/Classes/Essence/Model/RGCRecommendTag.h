//
//  RGCRecommendTag.h
//  BSBDQJ
//
//  Created by rgc on 16/4/2.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGCRecommendTag : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
