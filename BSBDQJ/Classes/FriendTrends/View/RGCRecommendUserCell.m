//
//  RGCRecommendUserCell.m
//  BSBDQJ
//
//  Created by rgc on 16/3/15.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCRecommendUserCell.h"
#import "RGCRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface RGCRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation RGCRecommendUserCell

- (void)setUser:(RGCRecommendUser *)user {
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}



@end
