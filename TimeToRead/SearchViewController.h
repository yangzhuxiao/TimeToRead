//
//  SearchViewController.h
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-7.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DoubanAPI;
@class BookDetailViewController;

@interface SearchViewController : UITableViewController

@property (nonatomic, copy) NSArray *titlesArray;
@property (nonatomic, copy) NSArray *authorsArray;
@property (nonatomic, copy) NSArray *imageArray;

@property (nonatomic, strong) BookDetailViewController *detailViewController;


@end
