//
//  RGCShowPictureViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/4/27.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCShowPictureViewController.h"
#import "RGCTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface RGCShowPictureViewController ()
@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation RGCShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    // 设置图片的frame
    if (pictureH > screenH) { // 图片显示高度超过一个屏幕
        // 需滚动查看
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        self.imageView.size = CGSizeMake(pictureW, pictureH);
        self.imageView.centerY = screenH * 0.5;
        
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

@end
