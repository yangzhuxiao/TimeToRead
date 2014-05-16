//
//  SearchViewController.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-7.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "SearchViewController.h"
#import "DoubanAPI.h"

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(popViewController)];
//    CGFloat yPosition = self.searchDisplayController.searchBar.frame.origin.y + self.searchDisplayController.searchBar.frame.size.height;
//    CGFloat width = self.view.frame.size.width;
//    CGFloat height = self.view.frame.size.height - yPosition;
//    [self.searchDisplayController.searchResultsTableView setFrame:CGRectMake(0,
//                                                                             yPosition,
//                                                                             width/2.0,
//                                                                             height)];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat yPosition = self.searchDisplayController.searchBar.frame.size.height;//此处不加self.searchDisplayController.searchBar.frame.origin.y的原因是tableView第一行上面已经预留了navigationItem高度大小的空间！！！
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - yPosition;
    
    [tableView setFrame:CGRectMake(0,
                                   yPosition,
                                   width,
                                   height)];
    if (_searchResults)
    {
        return [_searchResults count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (_searchResults)
    {
        cell.textLabel.text = [_searchResults objectAtIndex:indexPath.row];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return cell;
}


#pragma mark - UITableViewDelegate Methods


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSString *searchAPI = @"https://api.douban.com/v2/book/search?q=我们";
//    searchString = [searchAPI stringByAppendingString:searchString];
    
    [self sendRequest:searchAPI];
    
    return YES;
}


- (void)sendRequest:(NSString *)searchString
{
    [DoubanAPI searchBook:searchString WithResults:^(NSArray *resultsArray) {
        _searchResults = resultsArray;
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
