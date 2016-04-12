//
//  BookListViewController.h
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *booklistLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UITableView *bookListTableView;

@end
