//
//  anchor.h
//  HZPageView
//
//  Created by 侯震 on 2017/8/7.
//  Copyright © 2017年 multway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface anchor : NSObject

@property (nonatomic,copy) NSString * avatar;
@property (nonatomic,assign) int      charge;
@property (nonatomic,copy) NSString * focus;
@property (nonatomic,copy) NSString * gameIcon;
@property (nonatomic,copy) NSString * gameId;
@property (nonatomic,copy) NSString * gameName;
@property (nonatomic,assign) int      live;
@property (nonatomic,assign) int      mic;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * pic51;
@property (nonatomic,copy) NSString * pic74;
@property (nonatomic,assign) int      push;
@property (nonatomic,assign) long     roomid;
@property (nonatomic,copy) NSString * uid;
@property (nonatomic,assign) int      weeklyStar;
@property (nonatomic,assign) int      yearParty;

@end
