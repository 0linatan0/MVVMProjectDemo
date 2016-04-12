//
//  Book.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property(nonatomic,strong)NSString *bookId;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *publisDate;

- (instancetype)initWithBookId:(NSString *)bookID withName:(NSString *)name withPublishDate:(NSString *)publisDate;

@end
