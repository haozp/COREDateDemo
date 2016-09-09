//
//  MRCTestViewController.m
//  COREDateDemo
//
//  Created by leo on 16/6/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "MRCTestViewController.h"

@interface MRCTestViewController ()

@end

@implementation MRCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myWebView.backgroundColor = [UIColor greenColor];
    self.myWebView.frame = CGRectMake(20, 90, 20, 90);
//    [self.myWebView release];
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

-(void)dealloc
{
    [super dealloc];
}

@end
