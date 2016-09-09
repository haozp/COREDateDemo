//
//  TESTModelFirViewController.m
//  COREDateDemo
//
//  Created by leo on 16/4/14.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "TESTModelFirViewController.h"
#import "TESTSecondModelViewController.h"

@interface TESTModelFirViewController ()

@end

@implementation TESTModelFirViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(70, 70, 90, 30);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(presenSomeView:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)presenSomeView:(id)sender
{

    TESTSecondModelViewController *sec = [[TESTSecondModelViewController alloc]init];
    sec.testkBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"hhhhh");
    };

    //=====  1 =======
//    [self presentViewController:sec animated:YES completion:^{
//    }];

    //=====  2  =======
    //区别上一句的结果  如果是上一句则 pre的view 不能push到其他view
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:sec];
    [self presentViewController:nav animated:YES completion:^{
    }];

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
