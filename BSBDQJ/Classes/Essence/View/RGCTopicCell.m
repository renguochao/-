//
//  RGCTopicCell.m
//  BSBDQJ
//
//  Created by rgc on 16/4/22.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCTopicCell.h"
#import "RGCTopic.h"
#import "RGCTopicPictureView.h"
#import "RGCTopicVoiceView.h"
#import <UIImageView+WebCache.h>

@interface RGCTopicCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪会员下标 */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) RGCTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic, weak) RGCTopicVoiceView *voiceView;
@end

@implementation RGCTopicCell

- (RGCTopicPictureView *)pictureView {
    if (!_pictureView) {
        RGCTopicPictureView *pictureView = [RGCTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (RGCTopicVoiceView *)voiceView {
    if (!_voiceView) {
        RGCTopicVoiceView *voiceView = [RGCTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentLabel.backgroundColor = self.contentView.backgroundColor;
}

- (void)setTopic:(RGCTopic *)topic {
    _topic = topic;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 设置帖子文字内容
    self.contentLabel.text = topic.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == RGCTopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
    } else if (topic.type == RGCTopicTypeVoice) {
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
    } else {
        
    }
}

- (void)testDate:(NSString *)create_time {
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 当前时间
    NSDate *now = [NSDate date];
    // 发帖时间
    NSDate *create = [fmt dateFromString:create_time];
    
    RGCLog(@"%@ %@", now, create);
    NSDateComponents *cmps = [now deltaFrom:create];
    RGCLog(@"%zd %zd %zd %zd %zd %zd", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = RGCTopicCellMargin;
    frame.size.width -= 2 * RGCTopicCellMargin;
    frame.origin.y += RGCTopicCellMargin;
    frame.size.height -= RGCTopicCellMargin;
    
    [super setFrame:frame];
}

@end
