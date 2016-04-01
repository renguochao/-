//
//  RGCRecommendCategory.h
//  BSBDQJ
//
//  Created by rgc on 16/3/15.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGCRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;

/** 总数 */
@property (nonatomic, assign) NSInteger count;

/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;

/** user总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end
