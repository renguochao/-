//
//  RGCRecommendViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/15.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCRecommendViewController.h"
#import "RGCRecommendCategoryCell.h"
#import "RGCRecommendCategory.h"
#import "RGCRecommendUserCell.h"

@interface RGCRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/** 左边类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 左边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@end

@implementation RGCRecommendViewController

static NSString * const RGCCategoryId = @"category";
static NSString * const RGCUserId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:RGCCategoryId];
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:RGCUserId];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        RGCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCCategoryId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    } else {
        RGCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCUserId];
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RGCRecommendCategory *category = self.categories[indexPath.row];
}

@end
