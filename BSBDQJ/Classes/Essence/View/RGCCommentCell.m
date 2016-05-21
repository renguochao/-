//
//  RGCCommentCell.m
//  BSBDQJ
//
//  Created by rgc on 16/5/20.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCCommentCell.h"
#import "RGCComment.h"
#import "RGCUser.h"
#import <UIImageView+WebCache.h>

@interface RGCCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation RGCCommentCell

- (void)setComment:(RGCComment *)comment {
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.genderImageView.image = [comment.user.sex isEqualToString:RGCUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
}

@end
