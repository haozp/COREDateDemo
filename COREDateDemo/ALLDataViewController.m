//
//  ALLDataViewController.m
//  COREDateDemo
//
//  Created by leo on 15/7/20.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import "ALLDataViewController.h"

@interface ALLDataViewController ()

@end

@implementation ALLDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"数据详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *labrel = [[UILabel alloc]initWithFrame:CGRectMake(30,64, 300, 70)];
    labrel.backgroundColor = [UIColor redColor];
    labrel.text = @"+++++jfksjfkskfjkjfkjskfjeijfiejfijeifjiejfijeifjeijfiejfiejifjeifjiejfiejifjeifjeijfiejfiejifjeifjiejfiefijeifeijfiefieieiejfalfakfkasjfksnnicenicneuhuhafdsjkfhdkjfhjdfhdjkfjkd";
    labrel.numberOfLines = 0;
    [self.view addSubview:labrel];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
