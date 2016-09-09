//
//  COREDateDemoUITests.m
//  COREDateDemoUITests
//
//  Created by leo on 16/5/26.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface COREDateDemoUITests : XCTestCase

@end

@implementation COREDateDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testHH {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    for (int i=0; i<1; i++) {


        //=====

        XCUIApplication *app = [[XCUIApplication alloc] init];
        XCUIElementQuery *tablesQuery = app.tables;

        [tablesQuery.staticTexts[@"ServerRequestViewController"] tap];

        XCUIElement *element = [[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"ServerRequestView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
        [[[element childrenMatchingType:XCUIElementTypeTextView] elementBoundByIndex:1] tap];
        [[[element childrenMatchingType:XCUIElementTypeTextView] elementBoundByIndex:0] tap];

        [[[[app.navigationBars[@"ServerRequestView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];


        [tablesQuery.staticTexts[@"TESTModelFirViewController"] tap];
        [[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"TESTModelFirView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton].element tap];
        [[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1] tap];


        [tablesQuery.staticTexts[@"DebugViewController"] tap];
        [[[[app.navigationBars[@"DebugView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];

        [app.tables.staticTexts[@"MYDataTableViewController"] tap];
        XCUIElement *navigationBar = app.navigationBars[@"\u6570\u636e\u5217\u8868\u6d4b\u8bd5"];
        
        XCUIElement *button = navigationBar.buttons[@"\u8bfb\u53d6\u66f4\u591a"];
        [button tap];

        XCUIElement *button2 = navigationBar.buttons[@"\u5165\u5e93"];
        [button2 tap];
        [button2 tap];
        [button2 tap];
        [button tap];
        [navigationBar.staticTexts[@"\u6570\u636e\u5217\u8868\u6d4b\u8bd5"] tap];
        
        
        XCUIElement *testtransitionsVcStaticText = tablesQuery.staticTexts[@"TESTtransitions_VC"];
        [testtransitionsVcStaticText tap];
        
        XCUIElement *backButton = [[[app.navigationBars[@"\u6d4b\u8bd5\u8f6c\u573a-transitions"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0];
        [backButton tap];
        [testtransitionsVcStaticText tap];
        [backButton tap];
        [tablesQuery.staticTexts[@"TEST2D3DVC"] tap];
        [app.buttons[@"\u5f00\u59cb"] tap];
        [app.buttons[@"\u505c\u6b62"] tap];
        [[[[app.navigationBars[@"TEST2D3DVC"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];

        //=====
    }

}

- (void)testFUCK
{

    for (int i=0; i<6; i++) {
        XCUIApplication *app = [[XCUIApplication alloc] init];
        [app.tables.staticTexts[@"MYDataTableViewController"] tap];

        XCUIElement *navigationBar = app.navigationBars[@"\u6570\u636e\u5217\u8868\u6d4b\u8bd5"];
        XCUIElement *button = navigationBar.buttons[@"\u8bfb\u53d6\u66f4\u591a"];
        [button tap];

        XCUIElement *button2 = navigationBar.buttons[@"\u5165\u5e93"];
        [button2 tap];
        [button2 tap];
        [button2 tap];
        [button tap];
        [navigationBar.staticTexts[@"\u6570\u636e\u5217\u8868\u6d4b\u8bd5"] tap];

    }

    
}

@end
