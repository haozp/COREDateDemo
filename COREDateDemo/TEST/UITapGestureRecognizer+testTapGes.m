//
//  UITapGestureRecognizer+testTapGes.m
//  COREDateDemo
//
//  Created by leo on 16/7/19.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "UITapGestureRecognizer+testTapGes.h"
#import <objc/message.h>

NSString * const countGesKey = nil;

@implementation UITapGestureRecognizer (testTapGes)

static char  currentActionBlockKey;

-(MycurrentActionBlock )currentActionBlock
{
    return objc_getAssociatedObject(self, &currentActionBlockKey);
}

-(void)setCurrentActionBlock:(MycurrentActionBlock )currentActionBlock
{
    objc_setAssociatedObject(self, &currentActionBlockKey, currentActionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



//-------------------------2---------------------------
-(instancetype)eoc_initWithTarget:(id)target action:(SEL)action
{
    __weak UITapGestureRecognizer *weakSelf = self;

    [self  setCurrentActionBlock:^{
        //运行时 发送 消息 执行方法
        ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(target), action , nil);
        [weakSelf recordTarget:target action:action ges:weakSelf];
    }];

    NSLog(@"%@---%@",NSStringFromClass([super class]),NSStringFromClass([self class]));

    [self eoc_initWithTarget:self action:@selector(tap:)];
    return self;
}

- (void)tap:(UITapGestureRecognizer *)ges
{
    ges.currentActionBlock();
}

- (void)recordTarget:(id)target action:(SEL)action ges:(UIGestureRecognizer *)ges
{
    self.countTap++;
    NSLog(@"%ld",(long)self.countTap);
    NSLog(@"%ld",ges.view.tag);
    NSLog(@"ges=%@--target=%@---action=%@",ges,target,NSStringFromSelector(action));
}


//-------------------------3---------------------------

/*
-(instancetype)eoc_initWithTarget:(id)target action:(SEL)action
{

    {
    Method originalMethod =
    class_getInstanceMethod([target class],
                            action);
    Method swappedMethod =
    class_getInstanceMethod([self class],
                            @selector(eoc_action:));
    method_exchangeImplementations(originalMethod, swappedMethod);
    }

    [self eoc_initWithTarget:target action:action];

    return self;
}

- (void)eoc_action:(UIGestureRecognizer *)ges
{

    [ges performSelector:@selector(eoc_action:) withObject:ges afterDelay:0];
    NSLog(@"手势个蛋=== %@",ges);
}
*/


//计数 记录页面存在期间点击个数
- (void)setCountTap:(NSInteger)countTap
{
    objc_setAssociatedObject(self, &countGesKey, @(countTap),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)countTap
{
    id value = objc_getAssociatedObject(self, &countGesKey);
    NSNumber *countNumber = value;
    return countNumber.integerValue;
}


@end
