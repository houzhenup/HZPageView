//
//  HZPageView.m
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import "HZPageView.h"
#import "HZTitleView.h"
#import "HZContentView.h"
#import "UIColor+randomColor.h"




@interface HZPageView ()<HZTitleViewDelegate,HZContentViewDelegate>
/**注释 */
@property (nonatomic,strong) HZTitleView *titleView;
@property (nonatomic,strong) HZContentView *contentView;


@end
@implementation HZPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        self.titleStyle = [[HZTitleStyle alloc]init];
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc titleStyle:(HZTitleStyle *)titleStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        self.titleStyle = titleStyle;
        [self setupUI];
    }
    return self;
}
    

  
-(void)setupUI{
    
    [self setupTitleView];
    [self setupConentView];

}

-(void)setupTitleView{
    
    HZTitleView *titlsView = [[HZTitleView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.titleStyle.titleHeight) titles:self.titles titleStyle:self.titleStyle];
    self.titleView = titlsView;
    self.titleView.delegate = self;

    self.titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titlsView];
}
-(void)setupConentView{
    
    self.contentView = [[HZContentView alloc]initWithFrame:CGRectMake(0,self.titleStyle.titleHeight, self.bounds.size.width,self.bounds.size.height - self.titleStyle.titleHeight) childVcs:self.childVcs parentVc:self.parentVc];
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor randomColor];
    self.contentView.delegate = self;
}

#pragma mark TitleViewDelegate
-(void)titleView:(HZTitleView *)titleView targetIndex:(NSInteger)index{
    [self.contentView setCurrentIndex:index];
}

#pragma mark HZContentViewDelegate
-(void)contentView:(HZContentView *)contentView targetIndex:(int)index{
    [self.titleView setTargetIndex:index];
}
-(void)contentView:(HZContentView *)contentView currentIndex:(int)currentIndex targetIndex:(int)index process:(CGFloat)procss{
    [self.titleView setcurrentIndex:currentIndex TargetIndex:index process:procss];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
