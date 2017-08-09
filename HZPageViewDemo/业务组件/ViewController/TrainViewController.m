//
//  TrainViewController.m
//  HZPageView
//
//  Created by 侯震 on 2017/8/5.
//  Copyright © 2017年 multway. All rights reserved.
//

#import "TrainViewController.h"
#import <AFNetworking.h>
#import "anchor.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>

@interface TrainViewController ()<UITableViewDelegate,UITableViewDataSource>
/**数据*/
@property (nonatomic,strong) NSArray *data;
@end

@implementation TrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];

    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    
    NSDictionary *parameters = @{@"type":self.type,
                          @"index":@0,
                          @"size":@48,
                          };
    [[AFHTTPSessionManager manager] GET:@"http://qf.56.com/home/v4/moreAnchor.ios" parameters:parameters  progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *anchors = responseObject[@"message"][@"anchors"];
        self.data = [anchor mj_objectArrayWithKeyValuesArray:anchors];
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [self.view addSubview:self.tableview];
    
}

//自动布局子控件
-(void)viewDidLayoutSubviews{
    self.tableview.frame = self.view.bounds;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"sada";
    anchor *anchor = self.data[indexPath.row];
    cell.textLabel.text = anchor.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:anchor.avatar] placeholderImage:[UIImage imageNamed:@"placholder"]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
