//
//  DoubanAPI.h
//  
//
//  Created by Yang Xiaozhu on 14-5-13.
//
//

#import <Foundation/Foundation.h>
#import <RestKit.h>

@interface DoubanAPI : NSObject

+ (void)searchBook:(NSString *)searchString WithResults:(void (^)(NSDictionary *resultsDictionary))resultsBlock;


@property (nonatomic, copy) NSNumber *countOfBooks;
@property (nonatomic, copy) NSArray *bookTitle;
@property (nonatomic, copy) NSArray *bookImage;

@end