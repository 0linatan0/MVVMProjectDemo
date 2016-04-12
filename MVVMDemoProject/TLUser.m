//
//  TLUser.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/11.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import "TLUser.h"

@implementation TLUser

- (instancetype)init{

    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)validateUserName
{
    if ([_userName isEqualToString:@"admin"])
    {
        return YES;
    }
    return NO;
}

- (BOOL)validatePassword
{
    if ([_password isEqualToString:@"12345"])
    {
        return YES;
    }
    return NO;
}

@end
