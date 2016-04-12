//
//  TLBookItemViewModel.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Book;
@interface TLBookItemViewModel : NSObject

@property (copy, nonatomic) NSString * bookId; //书本ID
@property (copy, nonatomic) NSString * desc; //书本简介

- (instancetype)initWithBook:(Book *)book;

@end
