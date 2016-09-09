//
//  TEST_trsnsition_1_VC.m
//  COREDateDemo
//
//  Created by leo on 16/2/16.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "TEST_trsnsition_1_VC.h"

@interface TEST_trsnsition_1_VC ()

@end

@implementation TEST_trsnsition_1_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIImageView *imaV = [[UIImageView alloc]init];
    imaV.image = [UIImage imageNamed:@"02"];
    imaV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imaV];


    NSArray *consLayout_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[imaV(==100)]"   options:0 metrics:nil views:@{@"imaV":imaV}];
    NSArray *consLayout_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[imaV(==100)]"   options:0 metrics:nil views:@{@"imaV":imaV}];
    [self.view addConstraints:consLayout_H];
    [self.view addConstraints:consLayout_V];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"关闭模态View" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testTransitonPush:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn];

    NSArray *consLayout_btn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[btn(==200)]"   options:0 metrics:nil views:@{@"btn":btn}];
    NSArray *consLayout_btn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-200-[btn(==30)]"   options:0 metrics:nil views:@{@"btn":btn}];
    [self.view addConstraints:consLayout_btn_H];
    [self.view addConstraints:consLayout_btn_V];



}

-(IBAction)testTransitonPush:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
