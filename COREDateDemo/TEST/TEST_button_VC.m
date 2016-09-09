//
//  UIButtonViewController.m
//  COREDateDemo
//
//  Created by leo on 15/9/9.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import "TEST_button_VC.h"

@interface TEST_button_VC ()
{
    UIView *viewButtons;
    int i;

    //
    UIButton *btnfather;
}
@end

@implementation TEST_button_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    i=0;
    self.title = @"btn测试";

    btnfather = [UIButton buttonWithType:UIButtonTypeCustom];
    btnfather.frame = CGRectMake(30, 70, 70, 30);
    [btnfather setTitle:@"添加" forState:UIControlStateNormal];
    [btnfather addTarget:self action:@selector(doSomeThingBtn) forControlEvents:UIControlEventTouchUpInside];
    btnfather.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btnfather];

    viewButtons = [[UIView alloc]initWithFrame:CGRectMake(20, 180, 300, 40)];
    viewButtons.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewButtons];


    UILabel *labrel = [[UILabel alloc]initWithFrame:CGRectMake(16, 260, 200, 180)];
    labrel.text = @"上面是为了测试uibutton的方法(sendActionsForControlEvents)";
    labrel.numberOfLines = 0;
    labrel.textColor = [UIColor orangeColor];
    [self.view addSubview:labrel];



}

-(void)doSomeThingBtn
{
    i++;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(i*30+i*15, 5, 30, 20);
    [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(viewBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = i;
    btn.backgroundColor = [UIColor greenColor];
    [viewButtons addSubview:btn];


}

-(IBAction)viewBtnTap:(id)sender
{

    [btnfather sendActionsForControlEvents:UIControlEventTouchUpInside];

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
