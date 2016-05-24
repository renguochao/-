//
//  UIImageView+RGCExtension.m
//  BSBDQJ
//
//  Created by rgc on 16/5/24.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "UIImageView+RGCExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (RGCExtension)
- (void)setHeader:(NSString *)url {
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}
@end
