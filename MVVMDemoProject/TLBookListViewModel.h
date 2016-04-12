//
//  TLBookListViewModel.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLBookItemViewModel.h"

@interface TLBookListViewModel : NSObject

@property (nonatomic,strong)NSArray<TLBookItemViewModel *>*bookItemList;

- (void)search:(NSString *)filter;

@end
