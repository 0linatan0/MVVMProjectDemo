//
//  BookListViewController.m
//  MVVMDemoProject
//
//  Created by tanli on 16/4/12.
//  Copyright © 2016年 tanli. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "BookListViewController.h"
#import "TLBookListViewModel.h"

@interface BookListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    TLBookListViewModel *_bookListViewModel;
}
@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bookListViewModel = [[TLBookListViewModel alloc]init];
    
    _bookListTableView.delegate = self;
    _bookListTableView.dataSource = self;
    
    [RACObserve(_bookListViewModel, bookItemList) subscribeNext:^(id x) {
        NSLog(@"bookItemList change");
        [self updateView];
    }];
    
    [_searchText.rac_textSignal
     subscribeNext:^(id x){
        [_bookListViewModel search:x];
        [self updateView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateView
{
    [_bookListTableView reloadData];
}


# pragma mark - tabelView代理方法.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number  = _bookListViewModel.bookItemList.count;
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellReuseIdentifier = @"bookCellIdentifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellReuseIdentifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    TLBookItemViewModel * bookItem = _bookListViewModel.bookItemList[indexPath.row];
    NSString * content = bookItem.desc;
    cell.textLabel.text = content;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



@end
