//
//  TLLoginViewModel.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/11.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLUser.h"
@interface TLLoginViewModel : NSObject

@property(nonatomic,assign) BOOL isAdmin;
@property(nonatomic,strong) TLUser *user;

- (BOOL)judgeUser;
@end
