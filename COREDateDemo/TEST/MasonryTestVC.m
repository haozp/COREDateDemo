//
//  MasonryTestVC.m
//  COREDateDemo
//
//  Created by leo on 16/8/30.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "MasonryTestVC.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface MasonryTestVC ()

@end

@implementation MasonryTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *redV = [[UIView alloc]init];
    redV.backgroundColor = [UIColor redColor];
    [self.view addSubview:redV];

//    [redV mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.size.mas_equalTo(CGSizeMake(100,300));
////        make.width.equalTo(@200);
////        make.height.equalTo(@200);
//        make.right.equalTo(self.view.mas_right).offset(20);
//        make.bottom.equalTo(self.view.mas_bottom).offset(20);
//
//
//    }];

    /*
     约束可以改为下面这样的原因是：必须要添加这两个宏
     #define MAS_SHORTHAND
     #define MAS_SHORTHAND_GLOBALS
     #import "Masonry.h"
     */
    [redV makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(200, 300));
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view.bottom).offset(-20);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
