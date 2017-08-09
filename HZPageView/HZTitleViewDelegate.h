//
//  TitleViewDelegate.h
//  
//
//  Created by 侯震 on 2017/8/4.
//
//

#import <Foundation/Foundation.h>
@class HZTitleView;

@protocol HZTitleViewDelegate <NSObject>

-(void)titleView:(HZTitleView *)titleView targetIndex:(NSInteger)index;

@end
