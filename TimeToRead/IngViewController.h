//
//  IngViewController.h
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-4-29.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchViewController;

@interface IngViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *dropDownTableView;

@property (nonatomic, copy) NSArray *dropDownArray;
@property (nonatomic, strong) SearchViewController *searchViewController;
@end
