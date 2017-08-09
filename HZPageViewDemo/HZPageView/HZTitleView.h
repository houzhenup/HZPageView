//
//  HZTitleView.h
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTitleStyle.h"
#import "HZTitleViewDelegate.h"
#import "HZContentViewDelegate.h"

@interface HZTitleView : UIView
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) HZTitleStyle  *titleStyle;
@property (nonatomic,weak) id<HZTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(HZTitleStyle *)titleStyle;

-(void)setTargetIndex:(NSInteger)index;
-(void)setcurrentIndex:(NSInteger)currentIndex TargetIndex:(NSInteger)index process:(CGFloat)procss;


@end


