//
//  TESTAutoLyoutVC.m
//  COREDateDemo
//
//  Created by leo on 16/1/21.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "TESTAutoLyoutVC.h"

@interface TESTAutoLyoutVC ()
{
    UIView *redView;
    CGFloat myRedViewhWidth;
}
@end

@implementation TESTAutoLyoutVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(actionShow:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 400, 50, 30);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"动画" forState:UIControlStateNormal];
    [self.view addSubview:button];

    myRedViewhWidth=30;
    /*
    //obj1.PRoperty1 =（obj2.property2 * multiplier）+ constant value

    // 1.添加控件
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    // 2.约束蓝色
    // 2.1.高度
    NSLayoutConstraint *blueHeight =
    [NSLayoutConstraint constraintWithItem:blueView attribute:
     NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:
     nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0
                                  constant:40];
    [blueView addConstraint:blueHeight];
    // 2.2.左边间距
    CGFloat margin = 74;
    NSLayoutConstraint *blueLeft =
    [NSLayoutConstraint constraintWithItem:blueView attribute:
     NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:
     self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:
     margin];
    [self.view addConstraint:blueLeft];
    // 2.3.顶部间距
    NSLayoutConstraint *blueTop =
    [NSLayoutConstraint constraintWithItem:blueView attribute:
     NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:
     self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:
     margin];
    [self.view addConstraint:blueTop];
    // 2.4.右边间距
    NSLayoutConstraint *blueRight =
    [NSLayoutConstraint constraintWithItem:blueView attribute:
     NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:
     self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:
     -margin];
    [self.view addConstraint:blueRight];
    // 3.约束红色
    // 3.1.让红色右边 == 蓝色右边
    NSLayoutConstraint *redRight =
    [NSLayoutConstraint constraintWithItem:redView attribute:
     NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:
     blueView attribute:NSLayoutAttributeRight multiplier:1.0
                                  constant:0.0];
    [self.view addConstraint:redRight];
    // 3.2.让红色高度 == 蓝色高度
    NSLayoutConstraint *redHeight =
    [NSLayoutConstraint constraintWithItem:redView attribute:
     NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:
     blueView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:
     0.0];
    [self.view addConstraint:redHeight];
    // 3.3.让红色顶部 == 蓝色底部 + 间距 特别注意这里NSLayoutAttributeTop$NSLayoutAttributeBottom
    NSLayoutConstraint *redTop =
    [NSLayoutConstraint constraintWithItem:redView attribute:
     NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:
     blueView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:
     margin];
    [self.view addConstraint:redTop];
    // 3.4.让红色宽度 == 蓝色宽度 * 0.5
    NSLayoutConstraint *redWidth =
    [NSLayoutConstraint constraintWithItem:redView attribute:
     NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:
     blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:
     0.0];
    [self.view addConstraint:redWidth];
*/

    //----------------------------- VFL:全称是Visual Format Language，翻译过来是“可视化格式语言”
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    // 2.VFL生成约束
    NSArray *conts =
    [NSLayoutConstraint constraintsWithVisualFormat:
     @"H:|-20-[blueView]-20-|" options:0 metrics:nil views:
  @{@"blueView" : blueView}];
    [self.view addConstraints:conts];

    //metrics 这个使用
    NSNumber *bluewidth = @40;
    NSArray *conts2 =
    [NSLayoutConstraint constraintsWithVisualFormat:
     @"V:|-80-[blueView(bluewidth)]-20-[redView(==20)]" options:NSLayoutFormatAlignAllLeft metrics:@{@"bluewidth":bluewidth} views:@{@"blueView" : blueView, @"redView" : redView}];
    [self.view addConstraints:conts2];
    NSLayoutConstraint *redWidth =
    [NSLayoutConstraint constraintWithItem:redView attribute:
     NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:
     blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:
     myRedViewhWidth];
    [self.view addConstraint:redWidth];

//    NSArray *conAsss = [[NSLayoutConstraint constraintsWithVisualFormat:
//                         @"H:|-20-[blueView]-20-|" options:0 metrics:nil views:
//                         @{@"blueView" : blueView}]arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[blueView(40)]-20-[redView(==30)]" options:NSLayoutFormatAlignAllRight metrics:nil views:@{@"blueView" : blueView, @"redView" : redView}]];
//
//    [self.view addConstraints:conAsss];

    NSDictionary *views =

    NSDictionaryOfVariableBindings(blueView, redView);

    NSString *yi = @"yi";
    NSString *hh = @"hh";
    NSString *ss = @"ss";

    NSDictionary *viefefe =
    NSDictionaryOfVariableBindings(yi, hh,ss);
    NSLog(@"\nviews=%@++++\nviefefe=%@",views,viefefe);

    //myRedViewhWidth=0;
//    [UIView animateWithDuration:2.0 animations:^{
//        //父控件和redView都添加了约束
//        [self.view layoutIfNeeded];
//        //[redView layoutIfNeeded];
//    }];

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)actionShow:(id)sender
{

    NSLayoutConstraint *redWidth =
    [NSLayoutConstraint constraintWithItem:redView attribute:
     NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:
     self.view attribute:NSLayoutAttributeWidth multiplier:0.5 constant:
     0.0];
    [self.view addConstraint:redWidth];

    //父控件和redView添加了新的约束 会有动画
    [UIView animateWithDuration:0.1 animations:^{
        //[self.view layoutIfNeeded];
        [redView layoutIfNeeded];
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
