//
//  TestTableViewController.m
//  COREDateDemo
//
//  Created by leo on 15/9/6.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import "TestTableViewController.h"
#import "TEST_button_VC.h"
#import "TEST_scrowView_VC.h"

@interface TestTableViewController ()

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

       static NSString *cellId = @"CELLTEST";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    cell.textLabel.text = @"你是个好人吗？";
    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel *labrel  =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 20)];
    labrel.text = [NSString stringWithFormat:@"nihao==%ld",(long)section];
    labrel.textColor = [UIColor whiteColor];
    [view addSubview:labrel];
    view.backgroundColor = [UIColor redColor];
    return view;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    TEST_scrowView_VC *scro = [[TEST_scrowView_VC alloc]init];

   // UIButtonViewController *buttonVC = [[UIButtonViewController alloc]init];
    [self.navigationController pushViewController:scro animated:YES];





}



@end
