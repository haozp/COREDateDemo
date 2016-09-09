//
//  UITapGestureRecognizer+testTapGes.h
//  COREDateDemo
//
//  Created by leo on 16/7/19.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MycurrentActionBlock)(void);

@interface UITapGestureRecognizer (testTapGes)

@property (nonatomic,assign) NSInteger countTap;

//-(instancetype)eoc_initWithTarget:(id)target action:(SEL)action;


@end
