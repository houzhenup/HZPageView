# HZPageView
HZPageView简单集成
两行代码简单集成选项卡控件
HZTitleStyle提供多个属性可直接设置

    HZTitleStyle *style = [[HZTitleStyle alloc]init];
    style.isScrollEnable = YES;
 
    HZPageView *pageView = [[HZPageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height-64) titles:titlesText childVcs:childVcs parentVc:self titleStyle:style];
