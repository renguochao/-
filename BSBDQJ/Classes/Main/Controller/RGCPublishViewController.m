//
//  RGCPublishViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/4/29.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCPublishViewController.h"
#import "RGCVerticalButton.h"
#import <POP.h>

@interface RGCPublishViewController ()
@property (nonatomic, weak) UIImageView *sloganView;
@end

@implementation RGCPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = RGCScreenH * 0.2;
    sloganView.centerX = RGCScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (RGCScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (RGCScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        RGCVerticalButton *button = [[RGCVerticalButton alloc] init];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 设置frame
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        [self.view addSubview:button];
    }
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    // 设置开始时间
    anim.beginTime = CACurrentMediaTime() + 0.5;
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        
    };
    
    [self.sloganView pop_addAnimation:anim forKey:nil];
}


@end
