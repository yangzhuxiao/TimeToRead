//
//  EdViewController.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-4-29.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "EdViewController.h"
#import "RESideMenu.h"
#import "EdBook.h"
#import "EdBookStore.h"
#import "SearchTableViewCell.h"

@implementation EdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
	self.title = @"已读的书";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
}

#pragma mark -- UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[EdBookStore sharedStore] allBooksArray] count];
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
    
    EdBook *book = [[[EdBookStore sharedStore] allBooksArray] objectAtIndex:indexPath.row];
    
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

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
