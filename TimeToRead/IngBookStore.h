//
//  IngBookStore.h
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-27.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IngBookStore : NSObject
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *modal;
}
@property (nonatomic, copy) NSMutableArray *allIngBooksArray;
@property (nonatomic, copy) NSMutableArray *allEdBooksArray;


+ (IngBookStore *)sharedStore;
- (id)initWithBookType:(NSInteger)bookType;

- (NSString *)IngBookArchivePath;
- (NSString *)EdBookArchivePath;

- (void)createIngBookWithTitle:(NSString *)title WithAuthor:(NSString *)author;
- (void)createEdBookWithTitle:(NSString *)title WithAuthor:(NSString *)author;


- (BOOL)saveChanges;
- (void)loadAllIngBooks;
- (void)loadAllEdBooks;

@end
