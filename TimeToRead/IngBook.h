//
//  IngBook.h
//  
//
//  Created by Yang Xiaozhu on 14-5-26.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface IngBook : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;

@end
