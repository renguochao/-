//
//  RGCTopicViewController.h
//  BSBDQJ
//
//  Created by rgc on 16/4/24.
//  Copyright © 2016年 RGC. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>

@interface RGCTopicViewController : UITableViewController

/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) RGCTopicType type;
@end
