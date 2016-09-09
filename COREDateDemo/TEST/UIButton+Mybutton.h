//
//  UIButton+Mybutton.h
//  COREDateDemo
//
//  Created by leo on 16/7/4.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MycurrentActionBlock)(void);


@interface UIButton (Mybutton)

@property (nonatomic,assign) NSInteger countTap;

@end
