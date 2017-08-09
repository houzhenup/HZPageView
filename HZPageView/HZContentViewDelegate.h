//
//  HZContentViewDelegate.h
//  HZPageView
//
//  Created by 侯震 on 2017/8/5.
//  Copyright © 2017年 multway. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HZContentView;
@protocol HZContentViewDelegate <NSObject>
-(void)contentView:(HZContentView *)contentView targetIndex:(int)index;
-(void)contentView:(HZContentView *)contentView currentIndex:(int)currentIndex targetIndex:(int)index process:(CGFloat)procss;
@end
