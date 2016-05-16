//
//  RGCUser.h
//  BSBDQJ
//
//  Created by rgc on 16/5/12.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGCUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
