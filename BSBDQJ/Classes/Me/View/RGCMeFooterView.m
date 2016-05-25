//
//  RGCMeFooterView.m
//  BSBDQJ
//
//  Created by rgc on 16/5/25.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCMeFooterView.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "RGCSquare.h"
#import "RGCSquareButton.h"

@implementation RGCMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        
        // 请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSArray *squares = [RGCSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:squares];
//            [responseObject writeToFile:@"/Users/rgc/Desktop/1.plist" atomically:YES];
            
            [SVProgressHUD dismiss];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"加载出错!"];
        }];
    }
    
    return self;
}

- (void)createSquares:(NSArray *)squares {
    // 每行列数
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = RGCScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i ++) {
        // 创建按钮
        RGCSquareButton *button = [[RGCSquareButton alloc] init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.square = squares[i];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
    }
    
    NSInteger rows = (squares.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重绘 -- 需要重绘的原因是 取得数据后才会绘制footerView，原有高度如果不更新，按钮不能点击
    [self setNeedsDisplay];
    
    if ([self.delegate respondsToSelector:@selector(footerViewDidFinishLoad)]) {
        [self.delegate footerViewDidFinishLoad];
    }
}

- (void)buttonClick:(RGCSquareButton *)button {
    RGCLog(@"%s", __func__);
}

/**
 *  将UIImage绘制到UIView上
 */
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

@end
