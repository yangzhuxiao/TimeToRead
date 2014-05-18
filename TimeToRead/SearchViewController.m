//
//  SearchViewController.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-7.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "SearchViewController.h"
#import "DoubanAPI.h"
#import "SearchTableViewCell.h"

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(popViewController)];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.rowHeight = 88;
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
    if (_searchResults)
    {
        cell.title.text = [_searchResults objectAtIndex:indexPath.row];
        cell.author.text = @"test";
    }
    cell.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return cell;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSString *searchAPI = @"https://api.douban.com/v2/book/search?q=我们";
//    searchString = [searchAPI stringByAppendingString:searchString];
    
    [self sendRequest:searchAPI];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"Cancel button clicked...");
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
