//
//  CellTypeTicket.m
//  COREDateDemo
//
//  Created by leo on 16/4/12.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "CellTypeTicket.h"

@implementation CellTypeTicket

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 30);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"CellTypeTicket" forState:UIControlStateNormal];
    [self addSubview:btn];
}

@end
