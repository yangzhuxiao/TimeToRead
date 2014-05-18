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
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];//用于延长左边分割线
    }
    return [_titlesArray count];
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
    cell.title.text = [_titlesArray objectAtIndex:indexPath.row];
    NSString *authorPref = @"作者：";
    NSString *firstAuthor = @"";
    if ([[_authorsArray objectAtIndex:indexPath.row] count] > 0)//some may miss the authors
    {
        firstAuthor = [[_authorsArray objectAtIndex:indexPath.row] objectAtIndex:0];
    }
    
    cell.author.text = [authorPref stringByAppendingString:firstAuthor];
    NSString *imagePath = [_imageArray objectAtIndex:indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:imagePath];
    [cell.imageView setImageWithURL:imageURL placeholderImage:nil];
    
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
        _titlesArray = [resultsArray valueForKey:@"bookTitle"];
        _authorsArray = [resultsArray valueForKey:@"bookAuthor"];
        _imageArray = [resultsArray valueForKey:@"bookImage"];
        NSLog(@"authorArray: %@", _authorsArray);
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
