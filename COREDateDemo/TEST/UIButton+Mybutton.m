//
//  UIButton+Mybutton.m
//  COREDateDemo
//
//  Created by leo on 16/7/4.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "UIButton+Mybutton.h"
#import "objc/message.h"

static char  currentActionBlockKey;

static char  countButtonKey;
//NSString * const countButtonKey = nil;


@implementation UIButton (Mybutton)



-(MycurrentActionBlock )currentActionBlock
{
    return objc_getAssociatedObject(self, &currentActionBlockKey);
}

-(void)setCurrentActionBlock:(MycurrentActionBlock )currentActionBlock
{
    objc_setAssociatedObject(self, &currentActionBlockKey, currentActionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{

    __weak UIButton *weakSelf = self;

    [self  setCurrentActionBlock:^{
        //运行时 发送 消息 执行方法
        ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(target), action , nil);
        [weakSelf recordTarget:target forControlEvents:controlEvents button:weakSelf];
    }];
    NSLog(@"%@---%@",NSStringFromClass([super class]),NSStringFromClass([self class]));
    [super addTarget:self action:@selector(btnClicked:) forControlEvents:controlEvents];
}

- (void)btnClicked:(UIButton *)sender
{
    //执行原来要执行的方法
    sender.currentActionBlock();
}

- (void)recordTarget:(id)target forControlEvents:(UIControlEvents)controlEvents button:(UIButton *)sender
{
    NSLog(@"%ld",(long)self.countTap);

    self.countTap++;
    NSLog(@"%ld",(long)self.countTap);
    NSLog(@"target%@--controlEvents%lu--sender%@--senderTitle%@--",target,(unsigned long)controlEvents,sender,[sender titleForState:UIControlStateNormal]);
}

//计数 记录页面存在期间点击个数
- (void)setCountTap:(NSInteger)countTap
{
    objc_setAssociatedObject(self, &countButtonKey, @(countTap),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)countTap
{
    id value = objc_getAssociatedObject(self, &countButtonKey);
    NSNumber *countNumber = value;
    return countNumber.integerValue;
}


@end
