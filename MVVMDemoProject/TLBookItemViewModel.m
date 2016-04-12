//
//  TLBookItemViewModel.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import "TLBookItemViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Book.h"

@implementation TLBookItemViewModel

- (instancetype)initWithBook:(Book *)book
{
    self = [super init];
    if (self)
    {
        RAC(self, desc) = [RACSignal combineLatest:@[RACObserve(book, name), RACObserve(book, publisDate)] reduce:^id(NSString * title, NSString * desc){
            NSString * descInfo = [NSString stringWithFormat: @"书名:%@ 出版日期:%@", book.name , book.publisDate];
            return descInfo;
        }];
        // 设置self.bookd与model.id的相互关系.
        [RACObserve(book, bookId) subscribeNext:^(id x) {
            self.bookId = x;
        }];
    }
    return self;
}

@end
