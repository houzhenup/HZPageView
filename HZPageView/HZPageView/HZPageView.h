//
//  HZPageView.h
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTitleStyle.h"

@interface HZPageView : UIView

@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) HZTitleStyle  *titleStyle;

@property (nonatomic,strong) NSArray *childVcs;

@property (nonatomic,strong) UIViewController *parentVc;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc titleStyle:(HZTitleStyle *)titleStyle;
@end
