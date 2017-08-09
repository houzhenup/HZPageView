//
//  HZTitleView.m
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import "HZTitleView.h"
#import "UIColor+randomColor.h"




@interface HZTitleView()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *titleLabels;
@property (nonatomic,assign) NSInteger currntindex;
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation HZTitleView
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(HZTitleStyle *)titleStyle{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.titleStyle = titleStyle;
        [self setView];
    }
    return self;
}
-(void)setView{
    [self addSubview:self.scrollView];
    [self setUpTitleLabels];
    [self setTitleLabelsFrame];
    if (self.titleStyle.isShowScrollLine) {
        [self.scrollView addSubview:self.bottomView];

    }
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = self.titleStyle.scrollLineColor;
        
    }
    return _bottomView;
}
-(void)setUpTitleLabels{
    
    _titleLabels = [NSMutableArray array];
    for (int i = 0; i<self.titles.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.tag = i;
        titleLabel.text = self.titles[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            titleLabel.textColor = self.titleStyle.selectColor;
            _currntindex = 0;
            
        }else{
            titleLabel.textColor = self.titleStyle.normalColor;
        }
        titleLabel.font = [UIFont systemFontOfSize:self.titleStyle.fontSize];
      
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectLabel:)];
        [titleLabel addGestureRecognizer:tap];
        titleLabel.userInteractionEnabled = YES;
        [_titleLabels addObject:titleLabel];
        [_scrollView addSubview:titleLabel];
    }
    
}
-(void)setTitleLabelsFrame{
    long count = self.titles.count;
    for (int i = 0; i<count ;i++) {
        
        UILabel *titleLabel = self.titleLabels[i];
        CGFloat w =0;
        CGFloat h =self.bounds.size.height;
        CGFloat x =0;
        CGFloat y =0;
        if(self.titleStyle.isScrollEnable){
          w = [titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size.width;
            if (i == 0) {
                x = self.titleStyle.itmMargin *0.5;
                if (self.titleStyle.isShowScrollLine) {
                    self.bottomView.frame = CGRectMake(x, self.bounds.size.height - self.titleStyle.scrollLineHight, w, self.titleStyle.scrollLineHight);
                }
                
            }else{
                UILabel *label = self.titleLabels[i - 1];
                x = label.frame.origin.x+label.frame.size.width + self.titleStyle.itmMargin;
            }
            
        }else{
            w = self.bounds.size.width/(CGFloat)count;
            x = w *(CGFloat)i;
            self.bottomView.frame = CGRectMake(0, self.bounds.size.height - self.titleStyle.scrollLineHight, w, self.titleStyle.scrollLineHight);
        }
        
        titleLabel.frame = CGRectMake(x, y, w, h);
        if (i == count -1) {
            _scrollView.contentSize = CGSizeMake(x + w +self.titleStyle.itmMargin *0.5,  h);
   
        }
    }
}

#pragma mark 监听Label点击事件

-(void)selectLabel:(UITapGestureRecognizer*)tap{
    
    UILabel *selectLabel = (UILabel *)tap.view;
    [self adjustSelectTitleLabel:selectLabel];
    
    [_delegate titleView:self targetIndex:_currntindex];
    
    
}
-(void)adjustSelectTitleLabel:(UILabel *)selectLabel{
    if (selectLabel.tag == _currntindex) {
        return;
    }
    selectLabel.textColor  = self.titleStyle.selectColor;
    UILabel *currntLabel = self.titleLabels[_currntindex];
    currntLabel.textColor = self.titleStyle.normalColor;
    _currntindex = selectLabel.tag;
   
    if (self.titleStyle.isShowScrollLine) {
        
    [UIView animateWithDuration:0.2 animations:^{
      self.bottomView.frame = CGRectMake(selectLabel.frame.origin.x, self.bounds.size.height - self.titleStyle.scrollLineHight, selectLabel.frame.size.width, self.titleStyle.scrollLineHight);
    }];
      
    }

    if (self.titleStyle.isScrollEnable) {
        CGFloat x = selectLabel.frame.origin.x + selectLabel.frame.size.width/2;
        x = x - self.scrollView.bounds.size.width/2;
        if (x<0) {
            x=0;
        }
        if (x>self.scrollView.contentSize.width  - self.scrollView.bounds.size.width) {
            x = self.scrollView.contentSize.width  - self.scrollView.bounds.size.width;
        }
        [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    }

}

-(void)setTargetIndex:(NSInteger)index{
 
    UILabel *selectLabel = self.titleLabels[index];
   
    [self adjustSelectTitleLabel:selectLabel];
}

-(void)setcurrentIndex:(NSInteger)currentIndex TargetIndex:(NSInteger)index  process:(CGFloat)procss{

    UILabel *targtLabel = self.titleLabels[index];
    UILabel *currentLabel = self.titleLabels[currentIndex];
    
    //1.Label 颜色渐变
    NSArray *selectRGB =[UIColor getRGBWithColor:self.titleStyle.selectColor];
    NSArray *normalRGB =[UIColor getRGBWithColor:self.titleStyle.normalColor];
    NSArray *deltaColorArray = [self getdeltaColorWithfirstColor:selectRGB secondColor:normalRGB];
    
    float r =  [normalRGB[0] floatValue] + [deltaColorArray[0] floatValue]*procss;
    float g =  [normalRGB[1] floatValue] + [deltaColorArray[1] floatValue]*procss;
    float b =  [normalRGB[2] floatValue] + [deltaColorArray[2] floatValue]*procss;
    float r1 = [selectRGB[0] floatValue] - [deltaColorArray[0] floatValue]*procss;
    float g1 = [selectRGB[1] floatValue] - [deltaColorArray[1] floatValue]*procss;
    float b1 = [selectRGB[2] floatValue] - [deltaColorArray[2] floatValue]*procss;
    
    targtLabel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    currentLabel.textColor = [UIColor colorWithRed:r1 green:g1 blue:b1 alpha:1];
    //2.指示器长度渐变
    if(self.titleStyle.isShowScrollLine){
        
        float deltaX = targtLabel.frame.origin.x - currentLabel.frame.origin.x;
        float deltaW = targtLabel.frame.size.width - currentLabel.frame.size.width;
        self.bottomView.frame = CGRectMake(currentLabel.frame.origin.x + deltaX*procss, self.bounds.size.height - self.titleStyle.scrollLineHight,currentLabel.frame.size.width +deltaW *procss , self.titleStyle.scrollLineHight);
    }
    
}
-(NSArray *)getdeltaColorWithfirstColor:(NSArray *)firstRGB secondColor:(NSArray *)secondRGB{
    
    float r =  [firstRGB[0] floatValue] - [secondRGB[0] floatValue];
    float g =  [firstRGB[1] floatValue] - [secondRGB[1] floatValue];
    float b =  [firstRGB[2] floatValue] - [secondRGB[2] floatValue];

    return @[@(r), @(g), @(b)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
