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
@property (nonatomic,assign)CGFloat X;
@property (nonatomic,assign) BOOL isScrollMathed;
@end

@implementation HZContentView
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc{
   self =  [super initWithFrame:frame];
    if (self) {
        self.childVcs  = childVcs;
        self.parentVc = parentVc;
        [self setupUI];
    }
    return self;
}



-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellid];
        _collectionView.dataSource = self;
        _collectionView.delegate  = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(void)setupUI{
    for (UIViewController *childvc in self.childVcs) {
        [self.parentVc addChildViewController:childvc];
    }
    [self addSubview:self.collectionView];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    for (UIView *subView in  cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *vc = self.childVcs[indexPath.row];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    return  cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.childVcs.count;
}

#pragma mark UICollectionViewDelegate

//开始拖拽记录X值
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _X = scrollView.contentOffset.x;
    _isScrollMathed = YES;
}
//实时滚动scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!_isScrollMathed) {
        return ;
    }
    
    if (_X == scrollView.contentOffset.x) {
        return;
    }
    int currentIndex =  _X / scrollView.bounds.size.width;
    
    CGFloat progess = 0.0;
    int targetIndex = 0;
    
    //左划
    if (scrollView.contentOffset.x>_X) {
        targetIndex = currentIndex + 1;
        if (targetIndex > self.childVcs.count-1) {
            targetIndex = (int)self.childVcs.count -1;
        }
        progess = (scrollView.contentOffset.x - _X) / self.collectionView.bounds.size.width;
        
    }else if(scrollView.contentOffset.x<_X){
        
        targetIndex = currentIndex - 1;
        if (targetIndex < 0) {
            targetIndex = 0;
        }
        progess = ( _X - scrollView.contentOffset.x) / self.collectionView.bounds.size.width;

    }else{
        return ;
    }
    NSLog(@"%d",targetIndex);
    
    [_delegate contentView:self targetIndex:targetIndex process:progess];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        [self contentViewEndScroll];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self contentViewEndScroll];

    }
}
-(void)contentViewEndScroll{
    
   int index = (int)(self.collectionView.contentOffset.x/self.collectionView.bounds.size.width);
    [_delegate contentView:self targetIndex:index];
}


#pragma mark TitleViewDelegate
-(void)titleView:(HZTitleView *)titleView targetIndex:(NSInteger)index{
    
    _isScrollMathed = NO;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
