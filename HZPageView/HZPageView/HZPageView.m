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




@interface HZPageView ()
/**注释 */
@property (nonatomic,strong) HZTitleView *titleView;


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
    self.titleView.backgroundColor = [UIColor randomColor];
    [self addSubview:titlsView];
}
-(void)setupConentView{
    
    HZContentView *contentView = [[HZContentView alloc]initWithFrame:CGRectMake(0,self.titleStyle.titleHeight, self.bounds.size.width,self.bounds.size.height - self.titleStyle.titleHeight) childVcs:self.childVcs parentVc:self.parentVc];
    [self addSubview:contentView];
    contentView.backgroundColor = [UIColor randomColor];
    self.titleView.delegate = contentView;
    contentView.delegate = self.titleView;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
