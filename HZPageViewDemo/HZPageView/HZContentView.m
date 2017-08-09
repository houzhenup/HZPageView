//
//  HZContentView.m
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import "HZContentView.h"
#import "UIColor+randomColor.h"

static  NSString *cellid = @"cellid";
@interface HZContentView()
@property (nonatomic,assign)CGFloat startOffsetX;
@property (nonatomic,assign) BOOL isScrollMathed;



@end

@implementation HZContentView
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc{
   self =  [super initWithFrame:frame];
    if (self) {
        self.childVcs  = childVcs;
        self.parentVc = parentVc;
        [self setupUI];
        [self contentViewEndScroll];
    }
    return self;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate  = self;
        _scrollView.bounces = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width*self.childVcs.count, self.bounds.size.height);
    }
    return _scrollView;
}

-(void)setupUI{
    for (UIViewController *childvc in self.childVcs) {
        [self.parentVc addChildViewController:childvc];
    }
    [self addSubview:self.scrollView];
}


#pragma mark UIScrollViewDelegate

//开始拖拽记录X值
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startOffsetX = scrollView.contentOffset.x;
    _isScrollMathed = YES;

}
//实时滚动scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    if (!_isScrollMathed) {
        return ;
    }
    if (_startOffsetX == scrollView.contentOffset.x) {
        return;
    }
    int currentIndex =  _startOffsetX / scrollView.bounds.size.width;
    
    CGFloat progess = 0.0;
    int targetIndex = 0;

    //左划
    if (scrollView.contentOffset.x > _startOffsetX) {
        targetIndex = currentIndex + 1;
        if (targetIndex > self.childVcs.count-1) {
            targetIndex = (int)self.childVcs.count -1;
        }
        
        progess = (scrollView.contentOffset.x - _startOffsetX) / self.scrollView.bounds.size.width;
       
        if (scrollView.contentOffset.x - _startOffsetX > self.scrollView.bounds.size.width) {
            progess = 1;
            currentIndex = targetIndex;
        }
    }
    else if(scrollView.contentOffset.x<_startOffsetX){
        
        targetIndex = currentIndex - 1;
        if (targetIndex < 0) {
            targetIndex = 0;
        }
    
        progess = ( _startOffsetX - scrollView.contentOffset.x) / self.scrollView.bounds.size.width;
        
    }else{
        return ;
    }
    
    NSLog(@"%d---%d---%f",currentIndex,targetIndex,progess);
    [_delegate contentView:self currentIndex:currentIndex targetIndex:targetIndex process:progess];

}

//减速完成
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        [self contentViewEndScroll];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self contentViewEndScroll];
    }
}

-(void)contentViewEndScroll{
    
    int index = (int)(self.scrollView.contentOffset.x/self.scrollView.bounds.size.width);
    UIViewController *vc = self.childVcs[index];
    vc.view.frame = CGRectMake(index * self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    vc.view.backgroundColor = [UIColor redColor];
    
    [self.scrollView addSubview:vc.view];
    
    [_delegate contentView:self targetIndex:index];
}


#pragma mark  对外暴露的方法
-(void)setCurrentIndex:(NSInteger)index{
//    NSLog(@"%s",__func__);
    //拖动collctionViews时才调用相关方法 所以此处设置 _isScrollMathed = NO
    
    _isScrollMathed = NO;
    
    [self.scrollView setContentOffset:CGPointMake(index*self.scrollView.bounds.size.width, 0) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
