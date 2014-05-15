//
//  IngViewController.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-4-29.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "IngViewController.h"
#import "UIViewController+RESideMenu.h"
#import "SearchViewController.h"

@implementation IngViewController

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
	self.title = @"在读的书";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    NSLog(@"navigationBarFrame: %@",NSStringFromCGRect(navigationBarFrame));
    
    _dropDownArray = [NSArray arrayWithObjects:@"搜索豆瓣", @"扫描二维码",nil];
    _dropDownTableView.delegate = self;
    _dropDownTableView.dataSource = self;
    _dropDownTableView.backgroundColor = [UIColor lightGrayColor];
    _dropDownTableView.hidden = YES;
    
    
}

- (void)addItem
{
    _dropDownTableView.hidden = NO;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dropDownArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = _dropDownArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    return cell;
}



#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self addByDoubanAPI];
    }
    if (indexPath.row == 1)
    {
        [self addByScanningQRCode];
    }
}



- (void)addByDoubanAPI
{
    _searchViewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:_searchViewController animated:YES];
}

- (void)addByScanningQRCode
{
    
}
@end
