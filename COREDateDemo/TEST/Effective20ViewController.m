//
//  Effective20ViewController.m
//  COREDateDemo
//
//  Created by leo on 16/4/21.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "Effective20ViewController.h"

@interface Effective20ViewController ()

@end

@implementation Effective20ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSString *seee = [@"MMiiiiNNN---LLLLKKK====JJJoooo" lowercaseString];
    NSLog(@"%@",seee);

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
