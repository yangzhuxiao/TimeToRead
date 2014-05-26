//
//  IngDetailViewController.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-26.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "IngDetailViewController.h"

@implementation IngDetailViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加至已读" style:UIBarButtonItemStylePlain target:self action:@selector(addToAlreadyRead)];
    
}

- (void)addToAlreadyRead
{
    
}

@end
