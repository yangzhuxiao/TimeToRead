//
//  DoubanAPI.m
//  
//
//  Created by Yang Xiaozhu on 14-5-13.
//
//

#import "DoubanAPI.h"

@implementation DoubanAPI

+ (void)searchBook:(NSString *)searchString WithResults:(void (^)(NSArray * resultsArray))resultsBlock
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DoubanAPI class]];
//    [mapping addAttributeMappingsFromArray:@[@"count", @"books.origin_title", @"books.image"]];
    [mapping addAttributeMappingsFromDictionary:@{@"count": @"countOfBooks",
                                                  @"books.title": @"bookTitle",
                                                  @"books.image": @"bookImage"
                                                  }];

    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSURL *url = [NSURL URLWithString:searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"mappingResult.array.count: %d", mappingResult.array.count);
        NSLog(@"count: %@", [mappingResult.array[0] valueForKey:@"countOfBooks"]);
        NSLog(@"bookTitle: %@", [mappingResult.array[0] valueForKey:@"bookTitle"]);
        resultsBlock(mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Shit, Searching failed...");
    }];
    [operation start];
}

@end
