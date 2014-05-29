//
//  IngDetailViewController.h
//  TimeToRead
//
//  Created by Yang Xiaozhu on 14-5-26.
//  Copyright (c) 2014年 XiaoZhuAndJiaNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IngDetailViewController : UIViewController

@property (nonatomic, copy) NSString * titleString;
@property (nonatomic, copy) NSString * authorString;
@property (nonatomic, strong) UIImage *image;

@property (strong, nonatomic) IBOutlet UILabel *Progression;
@property (strong, nonatomic) IBOutlet UILabel *bookTitle;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthor;
@property (strong, nonatomic) IBOutlet UILabel *evaluationDegree;

@end
