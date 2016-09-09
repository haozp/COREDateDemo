//
//  ServerRequestViewController.m
//  COREDateDemo
//
//  Created by leo on 16/4/26.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "ServerRequestViewController.h"
#import "SMIServerRequst.h"

@interface ServerRequestViewController ()
{
    UITextView *responseViewUp;
    UITextView *responseViewDown;

}
@end

@implementation ServerRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    responseViewUp = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 270)];
    responseViewUp.backgroundColor = [UIColor lightGrayColor];
    responseViewUp.textColor = [UIColor orangeColor];
    [self.view addSubview:responseViewUp];

    responseViewDown = [[UITextView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 270)];
    responseViewDown.backgroundColor = [UIColor greenColor];
    responseViewDown.textColor = [UIColor blueColor];
    [self.view addSubview:responseViewDown];



    [self getServerDataUp];
    //[self getServerDataDown];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getServerDataUp
{
    [SMIServerRequst requestPOSTWithChildUrlStr:@"api/mall/advert/getItemAdverts" andParameters:nil response:^(NSError *error, NSDictionary *result)
    {
        if(result){
            responseViewUp.text = [result description];
        }else{
            responseViewUp.text = [error description];
        }
    }];

}

-(void)getServerDataDown
{
    NSDictionary * p = @{@"ma": @"8009",
                         @"pinyin":@"0",
                         };

    [SMIServerRequst requestWithParameters:p response:^(NSError *error, NSDictionary *result) {
        if(result){
            responseViewDown.text = [result description];
        }else{
            responseViewDown.text = [error description];
        }

    }];

}


@end
