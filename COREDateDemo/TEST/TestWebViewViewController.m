//
//  TestWebViewViewController.m
//  COREDateDemo
//
//  Created by leo on 15/7/21.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import "TestWebViewViewController.h"

@interface TestWebViewViewController ()<UIWebViewDelegate>

@end

@implementation TestWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL* url = [NSURL URLWithString:@"http://114.119.5.17:17303/app/resources/pages/index.html"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end
