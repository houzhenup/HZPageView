//
//  HZContentView.h
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTitleViewDelegate.h"
#import "HZContentViewDelegate.h"
@interface HZContentView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray *childVcs;
@property (nonatomic,strong) UIViewController *parentVc;
@property (nonatomic,weak) id<HZContentViewDelegate> delegate;
@property (nonatomic,strong) UIScrollView *scrollView;

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc;
-(void)setCurrentIndex:(NSInteger)index;

@end
