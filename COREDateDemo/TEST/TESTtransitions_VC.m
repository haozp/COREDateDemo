//
//  TEST_ transitions _VC.m
//  COREDateDemo
//
//  Created by leo on 16/2/16.
//  Copyright © 2016年 haozp. All rights reserved.
//  测试下uinavicationcontroller 转场方法

#import "TESTtransitions_VC.h"
#import "TEST_trsnsition_1_VC.h"

#import "SlideAnimation.h"
#import "ShuffleAnimation.h"
#import "ScaleAnimation.h"
#import "ModalAnimation.h"


@interface TESTtransitions_VC ()<UINavigationControllerDelegate, UITabBarControllerDelegate,UIViewControllerTransitioningDelegate>
{
    SlideAnimation   *_slideAnimationController;
    ShuffleAnimation *_shuffleAnimationController;
    ScaleAnimation   *_scaleAnimationController;
    ModalAnimation   *_modalAnimationController;
}
@end

@implementation TESTtransitions_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试转场-transitions";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate =  self;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testTransitonPush:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn];


    NSArray *consLayout_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[btn(==60)]"   options:0 metrics:nil views:@{@"btn":btn}];
    NSArray *consLayout_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[btn(==30)]"   options:0 metrics:nil views:@{@"btn":btn}];
    [self.view addConstraints:consLayout_H];
    [self.view addConstraints:consLayout_V];

    _slideAnimationController = [[SlideAnimation alloc] init];
    _shuffleAnimationController = [[ShuffleAnimation alloc] init];
    _scaleAnimationController = [[ScaleAnimation alloc] initWithNavigationController:self.navigationController];
    _modalAnimationController = [[ModalAnimation alloc] init];



    //------创建按钮用于模态跳转的时候返回
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 370, self.view.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lineView];

    UIButton *btnT = [UIButton buttonWithType:UIButtonTypeCustom];
    btnT.frame = CGRectMake(20, lineView.frame.origin.y+10, 200, 40);
    [btnT setTitle:@"模态返回上层" forState:UIControlStateNormal];
    [btnT addTarget:self action:@selector(dismissMyModelView:) forControlEvents:UIControlEventTouchUpInside];
    btnT.backgroundColor = [UIColor redColor];
    //btnT.translatesAutoresizingMaskIntoConstraints = NO;//不是自动布局这句话要去掉
    [self.view addSubview:btnT];



}



-(IBAction)testTransitonPush:(id)sender
{
    TEST_trsnsition_1_VC *testV = [[TEST_trsnsition_1_VC alloc]init];

    testV.transitioningDelegate = self;
    testV.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:testV animated:YES completion:nil];

}

-(void)dismissMyModelView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Transitioning Delegate (Modal)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _modalAnimationController.type = AnimationTypePresent;
    return _modalAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _modalAnimationController.type = AnimationTypeDismiss;
    return _modalAnimationController;
}



@end
