//
//  ViewController.h
//  COREDateDemo
//
//  Created by leo on 15/7/17.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^testModeBackBlock)(void);

@interface ViewController : UIViewController<UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, copy)testModeBackBlock testkBlock;

-(int)hhTestDemo;


@end

