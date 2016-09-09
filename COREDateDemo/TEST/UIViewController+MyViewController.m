//
//  UIViewController+MyViewController.m
//  COREDateDemo
//
//  Created by leo on 16/7/4.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "UIViewController+MyViewController.h"
#import "objc/message.h"

@implementation UIViewController (MyViewController)

+(void)load
{
    swizzedMethod([self class], @selector(viewWillAppear:), @selector(eoc_viewWillAppear:));
    swizzedMethod([self class], @selector(viewWillDisappear:), @selector(eoc_viewWillDisappear:));
}

void swizzedMethod(Class class,SEL originalSelector,SEL swizzledSelector){

    Method originalMethod =class_getInstanceMethod(class,
                                                   originalSelector);
    Method swizzledMethod =class_getInstanceMethod(class,
                                                   swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }

}

- (void)eoc_viewWillAppear:(BOOL)animated
{

    [self eoc_viewWillAppear:animated];
    NSLog(@"\n--------Appear==%@",NSStringFromClass([self class]));

}

- (void)eoc_viewWillDisappear:(BOOL)animated
{
    [self eoc_viewWillAppear:animated];
    NSLog(@"\n--------Disappear==%@",NSStringFromClass([self class]));
}

@end
