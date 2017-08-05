//
//  HZTitleStyle.m
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import "HZTitleStyle.h"

@implementation HZTitleStyle

-(instancetype)init{
    self = [super init];
    if (self) {
        self.titleHeight = 44;
        self.itmMargin = 30;
        self.normalColor = [UIColor blackColor];
        self.selectColor = [UIColor orangeColor];
        self.fontSize = 15;
        self.scrollLineColor = [UIColor orangeColor];
        self.scrollLineHight = 2;
        self.isShowScrollLine = YES;
    }
    return self;
}

@end
