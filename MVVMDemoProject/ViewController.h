//
//  ViewController.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/10.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *heading;

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *cloudOne;

@property (weak, nonatomic) IBOutlet UIImageView *cloudTwo;

@property (weak, nonatomic) IBOutlet UIImageView *cloudThree;

@property (weak, nonatomic) IBOutlet UIImageView *cloudFour;

- (IBAction)login:(UIButton *)sender;

@end

