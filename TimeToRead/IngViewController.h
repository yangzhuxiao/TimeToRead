//
//  IngViewController.h
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-4-29.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchViewController;
@class IngDetailViewController;

@interface IngViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *dropDownTableView;

@property (strong, nonatomic) IBOutlet UITableView *contentsTableView;

@property (nonatomic, copy) NSArray *dropDownArray;
@property (nonatomic, strong) SearchViewController *searchViewController;
@property (nonatomic, strong) IngDetailViewController *detailViewController;
@end
