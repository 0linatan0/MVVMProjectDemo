//
//  TLLoginViewModel.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/11.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import "TLLoginViewModel.h"
#import "TLUser.h"

@interface TLLoginViewModel(){
}
@end

@implementation TLLoginViewModel

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _user = [[TLUser alloc]init];
    }
    return self;
}

- (BOOL)judgeUser
{
    return [_user validateUserName]&&[_user validatePassword];
}
@end
