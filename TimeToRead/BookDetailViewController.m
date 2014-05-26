//
//  BookDetailViewController.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-19.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "BookDetailViewController.h"
#import "IngBook.h"
#import "IngBookStore.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBookToReadingStore)];
    
    
    _titleLabel.text = _titleString;
    _authorLabel.text = _authorString;

    NSURL *imageURL = [NSURL URLWithString:_imageString];
    [_imageView setImageWithURL:imageURL placeholderImage:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBookToReadingStore
{
    [[IngBookStore sharedStore] createNewBookWithTitle:_titleString WithAuthor:_authorString];
    
    [[IngBookStore sharedStore] saveChanges];
}
@end
