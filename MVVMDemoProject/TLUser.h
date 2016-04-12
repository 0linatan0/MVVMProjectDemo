//
//  TLUser.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/11.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLUser : NSObject

@property(nonatomic,strong)NSString *userName;

@property(nonatomic,strong)NSString *password;

- (BOOL)validateUserName;

- (BOOL)validatePassword;

@end
