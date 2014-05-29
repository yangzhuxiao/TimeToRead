//
//  EdBook.h
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-29.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EdBook : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * image;

@end
