//
//  RGCCommentHeaderView.h
//  BSBDQJ
//
//  Created by rgc on 16/5/19.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGCCommentHeaderView : UITableViewHeaderFooterView
/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTabelView:(UITableView *)tableView;
@end
