//
//  IngBookStore.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-27.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "IngBookStore.h"
#import "IngBook.h"
#import "EdBook.h"

@implementation IngBookStore

+ (IngBookStore *)sharedStore
{
    static IngBookStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (NSString *)IngBookArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingString:@"IngBookStore.data"];
}

- (NSString *)EdBookArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingString:@"EdBookStore.data"];
}

- (id)initWithBookType:(NSInteger)bookType
{
    self = [super init];
    if (self) {
        // Read in CurrentlyReadingBooks.xcdatamodeld
        modal = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modal];
        NSString *path;
        switch (bookType)
        {
            case 0:
                path = [self IngBookArchivePath];
            case 1:
                path = [self EdBookArchivePath];
            default:
                break;
        }
        
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error])
        {
            [NSException raise:@"Open failed" format:@"Readon: %@", [error localizedDescription]];
        }
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        [context setUndoManager:nil];
        switch (bookType)
        {
            case 0:
                [self loadAllIngBooks];
            case 1:
                [self loadAllEdBooks];
            default:
                break;
        }
    }
    return self;
}

- (void)createIngBookWithTitle:(NSString *)title WithAuthor:(NSString *)author
{
    IngBook *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"IngBook" inManagedObjectContext:context];
    newBook.title = title;
    newBook.author = author;
    [_allIngBooksArray addObject:newBook];
}

- (void)createEdBookWithTitle:(NSString *)title WithAuthor:(NSString *)author
{
    EdBook *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"EdBook" inManagedObjectContext:context];
    newBook.title = title;
    newBook.author = author;
    [_allEdBooksArray addObject:newBook];
}

- (BOOL)saveChanges
{
    NSError *error = nil;
    BOOL success = [context save:&error];
    if (!success) {
        NSLog(@"Errow saving: %@", [error localizedDescription]);
    }
    return success;
}

- (void)loadAllIngBooks
{
    if (!_allIngBooksArray)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDiscription = [[modal entitiesByName] objectForKey:@"IngBook"];
        [request setEntity:entityDiscription];
        
        NSError *error;
        NSArray *resultArray = [context executeFetchRequest:request error:&error];
        if (!resultArray)
        {
            [NSException raise:@"Fetch failed..." format:@"Reason: %@", [error localizedDescription]];
        }
        _allIngBooksArray = [[NSMutableArray alloc] initWithArray:resultArray];
    }
}

- (void)loadAllEdBooks
{
    if (!_allIngBooksArray)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDiscription = [[modal entitiesByName] objectForKey:@"EdBook"];
        [request setEntity:entityDiscription];
        
        NSError *error;
        NSArray *resultArray = [context executeFetchRequest:request error:&error];
        if (!resultArray)
        {
            [NSException raise:@"Fetch failed..." format:@"Reason: %@", [error localizedDescription]];
        }
        _allEdBooksArray = [[NSMutableArray alloc] initWithArray:resultArray];
    }
}

@end
