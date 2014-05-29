//
//  IngBookStore.m
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-27.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import "IngBookStore.h"
#import "IngBook.h"

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

- (NSString *)bookArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingString:@"IngBookStore.data"];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Read in CurrentlyReadingBooks.xcdatamodeld
        modal = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modal];
        
        NSString *path = [self bookArchivePath];
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
        [self loadAllBooks];
    }
    return self;
}

- (void)createNewBookWithTitle:(NSString *)title WithAuthor:(NSString *)author WithImage:(UIImage *)image
{
    IngBook *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"IngBook" inManagedObjectContext:context];
    newBook.title = title;
    newBook.author = author;
    newBook.image = UIImagePNGRepresentation(image);
    [_allBooksArray addObject:newBook];
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

- (void)loadAllBooks
{
    if (!_allBooksArray)
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
        _allBooksArray = [[NSMutableArray alloc] initWithArray:resultArray];
    }
}

@end
