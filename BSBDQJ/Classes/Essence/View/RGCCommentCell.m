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
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation RGCCommentCell

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

-(void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(RGCComment *)comment {
    _comment = comment;
    
    [self.profileImageView setHeader:comment.user.profile_image];
    self.genderImageView.image = [comment.user.sex isEqualToString:RGCUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri && ![comment.voiceuri isEqualToString:@""]) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = RGCTopicCellMargin;
    frame.size.width -= RGCTopicCellMargin * 2;
    
    [super setFrame:frame];
}

@end
