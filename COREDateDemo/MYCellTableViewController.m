//
//  MYCellTableViewController.m
//  COREDateDemo
//
//  Created by leo on 16/4/13.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "MYCellTableViewController.h"
#import "MYFCellTestTableViewCell.h"
#import "UINavigationBar+myTestChangeBackColor.h"

#define NAVBAR_CHANGE_POINT 50

@interface MYCellTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTestTableView;
}

@end

@implementation MYCellTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    myTestTableView.delegate = self;
//    [self scrollViewDidScroll:myTestTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    myTestTableView.delegate = nil;
    [self.navigationController.navigationBar hao_reset];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-64, self.view.frame.size.width, self.view.frame.size.height)];
    myTestTableView = myTableView;
    myTestTableView.dataSource = self;
    [self.view addSubview:myTableView];

    [self.navigationController.navigationBar hao_setBackgroundColor:[UIColor clearColor]];
    self.title = @"hhhh";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mycellID = @"MYFCellTestTableViewCell";

    MYFCellTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycellID];
    if (!cell) {
        cell = [[MYFCellTestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycellID];
    }
    UIImageView *imaViewOne = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIImage *imageOne = [UIImage imageNamed:@"13"];
    imaViewOne.image = imageOne;
//    imaView.alpha = 0.2;
    imaViewOne.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"删除"]];
    [cell.contentView addSubview:imaViewOne];

    UIImageView *imaViewTwo = [[UIImageView alloc]initWithFrame:CGRectMake(140, 0, 100, 100)];
    UIImage *imageTwo = [UIImage imageNamed:@"01"];
    imaViewTwo.image = imageTwo;
    //    imaView.alpha = 0.2;
    imaViewTwo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"删除"]];
    [cell.contentView addSubview:imaViewTwo];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{


//    UIColor *co = [UIColor greenColor];
//    self.navigationController.navigationBar.backgroundColor = [co colorWithAlphaComponent:scrollView.contentOffset.y/200];
//    return;
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar hao_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar hao_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}



@end
