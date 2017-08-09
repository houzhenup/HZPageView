//
//  ViewController.m
//  HZPageView
//
//  Created by 侯震 on 2017/8/4.
//  Copyright © 2017年 multway. All rights reserved.
//

#import "ViewController.h"
#import "HZPageView.h"
#import "HZTitleStyle.h"
#import "UIColor+randomColor.h"
#import "TrainViewController.h"
@interface ViewController ()
/**注释 */
@property (nonatomic,strong) NSArray *vcs;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"今日新闻";
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    NSString *file = [[NSBundle mainBundle]  pathForResource:@"types" ofType:@"plist"];
    NSArray *titles = [NSArray arrayWithContentsOfFile:file];
    NSMutableArray *titlesText = [NSMutableArray array];
    NSMutableArray *childVcs = @[].mutableCopy;
   
    for (int i =0 ;i<titles.count ; i++) {
        TrainViewController *vc = [[TrainViewController alloc]init];
        vc.type = titles[i][@"type"];
        [childVcs addObject:vc];
        [titlesText addObject:titles[i][@"title"]];
    }
    
    HZTitleStyle *style = [[HZTitleStyle alloc]init];
    style.isScrollEnable = YES;

    HZPageView *pageView = [[HZPageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height-64) titles:titlesText childVcs:childVcs parentVc:self titleStyle:style];
    
    [self.view addSubview:pageView];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
