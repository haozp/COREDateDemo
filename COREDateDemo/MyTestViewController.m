//
//  MyTestViewController.m
//  COREDateDemo
//
//  Created by leo on 16/5/12.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "MyTestViewController.h"

@interface MyTestViewController ()

@end

@implementation MyTestViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.alpha = 0.2;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    _myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    _myWebView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_myWebView];
    // Do any additional setup after loading the view.
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

@end
