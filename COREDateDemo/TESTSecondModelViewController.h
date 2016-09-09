//
//  TESTSecondModelViewController.h
//  COREDateDemo
//
//  Created by leo on 16/4/14.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^testModeBackBlock)(void);

@interface TESTSecondModelViewController : UIViewController

@property (nonatomic, copy)testModeBackBlock testkBlock;
@end
