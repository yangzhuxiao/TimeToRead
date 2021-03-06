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
@property (nonatomic, copy) NSMutableArray *allBooksArray;


+ (IngBookStore *)sharedStore;
- (NSString *)bookArchivePath;
- (void)createNewBookWithTitle:(NSString *)title WithAuthor:(NSString *)author WithImage:(UIImage *)image;
- (BOOL)saveChanges;
- (void)loadAllBooks;
@end
