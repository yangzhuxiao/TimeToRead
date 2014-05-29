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
#import "IngBook.h"
#import "IngBookStore.h"
#import "IngDetailViewController.h"
#import "SearchTableViewCell.h"

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0000 ? YES : NO)


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
    if (IS_IOS7)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
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
    
    _dropDownTableView.backgroundColor = [UIColor yellowColor];
    _dropDownTableView.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [_contentsTableView reloadData];
}

- (void)addItem
{
    _dropDownTableView.hidden = NO;
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _dropDownTableView)
    {
        return [_dropDownArray count];
    }
    else return [[[IngBookStore sharedStore] allBooksArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _contentsTableView)
    {
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
        if (!cell)
        {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SearchTableViewCell" owner:nil options:nil];
            
            for (id item in nibArray)
            {
                if ([item isKindOfClass:[SearchTableViewCell class]])
                {
                    cell = (SearchTableViewCell *)item;
                }
            }
        }
        
        IngBook *book = [[[IngBookStore sharedStore] allBooksArray] objectAtIndex:indexPath.row];
        
        cell.title.text = book.title;
        NSString *authorPref = @"作者：";
        NSString *firstAuthor = firstAuthor = book.author;
        
        cell.author.text = [authorPref stringByAppendingString:firstAuthor];
        
        cell.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageWithData:book.image];
        
        cell.imageView.image = image;
        
        [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        return cell;

    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        
        UIFont *dropDownFont = [UIFont systemFontOfSize:10.f];
        cell.textLabel.font = dropDownFont;
        cell.textLabel.text = _dropDownArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        
        [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        return cell;
    }
}
#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _dropDownTableView)
    {
        return 22.f;
    }
    return 88.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _dropDownTableView)
    {
        if (indexPath.row == 0)
        {
            [self addByDoubanAPI];
        }
        if (indexPath.row == 1)
        {
            [self addByScanningQRCode];
        }
        _dropDownTableView.hidden = YES;
    }
    else
    {
        
        
        _dropDownTableView.hidden = YES;
        _detailViewController = [[IngDetailViewController alloc] init];
        
        IngBook *book = [[[IngBookStore sharedStore] allBooksArray] objectAtIndex:indexPath.row];
        _detailViewController.titleString = book.title;
        _detailViewController.authorString = book.author;
        UIImage *image = [UIImage imageWithData:book.image];
        _detailViewController.image = image;
        [self.navigationController pushViewController:_detailViewController animated:YES];
    }
}


- (void)addByDoubanAPI
{
    _searchViewController = [[SearchViewController alloc] init];
//    _searchViewController.ingViewController = self;
    [self.navigationController pushViewController:_searchViewController animated:YES];
}

- (void)addByScanningQRCode
{
    
}
@end
