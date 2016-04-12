//
//  TLBookListViewModel.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import "TLBookListViewModel.h"
#import "Book.h"
@interface TLBookListViewModel()
{
    NSArray *_itemArray;
}
@end
@implementation TLBookListViewModel
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _itemArray = [NSMutableArray array];
        [self readFile:@"books" withType:@"txt"];
        [self search:@""];
    }
    return self;
}

- (void)readFile:(NSString *)fileName withType:(NSString *)type
{
    NSError *error = nil;
    NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:type] encoding:NSUTF8StringEncoding error: &error];
    
    // If there are no results, something went wrong
    if (textFileContents == nil)
    {
        // an error occurred
        NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
    }
    _itemArray = [textFileContents componentsSeparatedByString:@"\n"];
    NSLog(@"%@", _itemArray);
}

- (void)search:(NSString *)filter
{
    NSMutableArray<TLBookItemViewModel *> *books = [NSMutableArray<TLBookItemViewModel *> array] ;
    for (NSString *item in _itemArray)
    {
        if ([filter isEqualToString:@""] || [item containsString:filter])
        {
            NSArray *itemContent = [item componentsSeparatedByString:@"/"];
            Book *book = [[Book alloc]initWithBookId:itemContent[0] withName:itemContent[1] withPublishDate:itemContent[2]];
            TLBookItemViewModel *bookListViewModel = [[TLBookItemViewModel alloc]initWithBook:book];
            [books addObject: bookListViewModel];
        }
    }
    _bookItemList = books;
}

@end
