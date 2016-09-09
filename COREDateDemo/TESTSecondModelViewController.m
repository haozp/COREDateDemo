//
//  TESTSecondModelViewController.m
//  COREDateDemo
//
//  Created by leo on 16/4/14.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "TESTSecondModelViewController.h"
#import "MyTestViewController.h"
#import "MRCTestViewController.h"

@interface TESTSecondModelViewController ()

@end

@implementation TESTSecondModelViewController
@synthesize testkBlock = _testkBlock;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];

    UIButton *btnGr = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGr.backgroundColor = [UIColor greenColor];
    btnGr.frame = CGRectMake(70, 270, 190, 30);
    [self.view addSubview:btnGr];
    [btnGr addTarget:self action:@selector(presenSomeView:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnOr = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOr.backgroundColor = [UIColor redColor];
    btnOr.frame = CGRectMake(70, 80, 190, 30);
    [btnOr setTitle:@"测试" forState:UIControlStateNormal];
    [self.view addSubview:btnOr];
    [btnOr addTarget:self action:@selector(presen:) forControlEvents:UIControlEventTouchUpInside];

    
    
    // Do any additional setup after loading the view.
}


-(IBAction)presen:(id)sender
{
//    MyTestViewController *testM = [[MyTestViewController alloc]init];
    MRCTestViewController *testM = [[MRCTestViewController
                                     alloc]init];
    [self.navigationController pushViewController:testM animated:YES];
}

-(IBAction)presenSomeView:(id)sender
{
    //支付成功跳转
//    if ([self respondsToSelector:@selector(presentingViewController)]){
//        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//
//    }
//    else {
//        [self.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:nil];
//    }

   [self dismissViewControllerAnimated:YES completion:_testkBlock];
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
