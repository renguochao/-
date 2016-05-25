//
//  RGCMeFooterView.h
//  BSBDQJ
//
//  Created by rgc on 16/5/25.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RGCMeFooterViewDelegate <NSObject>

- (void)footerViewDidFinishLoad;

@end

@interface RGCMeFooterView : UIView

/** FooterView高度 */
@property (nonatomic, assign) NSInteger height;

@property (nonatomic, weak) id<RGCMeFooterViewDelegate> delegate;
@end


