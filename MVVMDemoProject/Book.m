//
//  Book.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import "Book.h"

@implementation Book

- (instancetype)initWithBookId:(NSString *)bookID
                      withName:(NSString *)name
               withPublishDate:(NSString *)publisDate
{
    self = [super init];
    if (self)
    {
        _bookId = bookID;
        _name = name;
        _publisDate = publisDate;
    }
    return  self;
}

@end
