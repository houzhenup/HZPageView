//
//  HZTitleStyle.h
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HZTitleStyle : NSObject

/**title高度 */
@property (nonatomic,assign) CGFloat titleHeight;
/**字体颜色 */
@property (nonatomic,copy) UIColor *normalColor;
/**字体选中颜色 */
@property (nonatomic,copy) UIColor *selectColor;
/**字体大小 */
@property (nonatomic,assign) CGFloat fontSize;
/**是否滚动 */
@property (nonatomic,assign) BOOL isScrollEnable;
/**间距*/
@property (nonatomic,assign) CGFloat itmMargin;
/**是否显示底部指示器*/
@property (nonatomic,assign) BOOL isShowScrollLine;
/**底部指示器高度*/
@property (nonatomic,assign) CGFloat scrollLineHight;
/**底部指示器颜色*/
@property (nonatomic,copy) UIColor *scrollLineColor;

@end
