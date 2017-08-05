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




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSArray *titles = @[@"美女",@"美女",@"美女",@"美女",@"美女",@"美女",@"美美女",@"美女"];
    NSMutableArray *childVcs = @[].mutableCopy;
  
    for (NSString *title in titles) {
        UIViewController *vc = [[UIViewController alloc]init];
        vc.title = title;
        vc.view.backgroundColor = [UIColor randomColor];
        [childVcs addObject:vc];
    }
    
    HZTitleStyle *style = [[HZTitleStyle alloc]init];
    style.isScrollEnable = YES;
    
    HZPageView *pageView = [[HZPageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height-64) titles:titles childVcs:childVcs parentVc:self titleStyle:style];
    [self.view addSubview:pageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
