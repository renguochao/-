//
//  RGCSquareButton.h
//  BSBDQJ
//
//  Created by rgc on 16/5/25.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RGCSquare;

@interface RGCSquareButton : UIButton
/** 方块模型 */
@property (nonatomic, strong) RGCSquare *square;
@end
