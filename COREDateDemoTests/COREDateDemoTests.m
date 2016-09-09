//
//  COREDateDemoTests.m
//  COREDateDemoTests
//
//  Created by leo on 15/7/17.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface COREDateDemoTests : XCTestCase
@property (nonatomic,strong) ViewController *vc;
@end

@implementation COREDateDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //初始化的代码，在测试方法调用之前调用

    self.vc = [[ViewController alloc]init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    // 释放测试用例的资源代码，这个方法会每个测试用例执行后调用
    self.vc = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // 测试用例的例子，注意测试用例一定要test开头

}

- (void)testViewHH
{
    // 调用需要测试的方法，
    int result = [self.vc hhTestDemo];
    // 如果不相等则会提示@“测试不通过”
    XCTAssertEqual(result, 100,@"测试不通过");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    // 测试性能例子
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 需要测试性能的代码
        NSString *str = @"feee";
        for (int i=0; i<10000; i++) {
            str  = [str stringByAppendingString:[NSString stringWithFormat:@"%d",i]];
        }
    }];
}


@end
