//
//  RGCMainViewController.m
//  BSBDQJ
//
//  Created by rgc on 16/3/30.
//  Copyright © 2016年 RGC. All rights reserved.
//

#import "RGCMainViewController.h"
#import "RGCEssenceViewController.h"
#import "RGCFriendTrendViewController.h"
#import "RGCMeViewController.h"
#import "RGCNewViewController.h"
#import "RGCNavigationController.h"
#import "RGCTabBar.h"
#import "RGCTopWindow.h"

/**
 *
 [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>];
 颜色:
 
 24bit颜色: R G B
 * #ff0000
 * #ccee00
 * #000000
 * #ffffff
 
 32bit颜色: ARGB
 * #ff0000ff
 
 常见颜色:
 #ff0000 红色
 #00ff00 绿色
 #0000ff 蓝色
 #000000 黑色
 #ffffff 白色
 
 灰色的特点:RGB一样
 
 1024x1024像素的图片  32bit颜色
 
 1024x1024x32\8 == 1024x1024x4
 1024x1024x24\8 == 1024x1024x3
 */

@interface RGCMainViewController ()

@end

@implementation RGCMainViewController

+ (void)initialize {
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self setupChildVc:[[RGCEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[RGCNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[RGCFriendTrendViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[RGCMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换TabBar
    [self setValue:[[RGCTabBar alloc] init] forKey:@"tabBar"];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 添加一个window, 点击这个window, 可以让屏幕上的scrollView滚到最顶部
    [RGCTopWindow show];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
//    [vc.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; 图片不被渲染
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    RGCNavigationController *nav = [[RGCNavigationController alloc] initWithRootViewController:vc];
    // 添加子控制器
    [self addChildViewController:nav];
}

@end
