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
@interface HZContentView : UIView<UICollectionViewDataSource,HZTitleViewDelegate,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *childVcs;
@property (nonatomic,strong) UIViewController *parentVc;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,weak) id<HZContentViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc;

@end
