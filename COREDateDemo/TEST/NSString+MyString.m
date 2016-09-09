//
//  NSString+MyString.m
//  COREDateDemo
//
//  Created by leo on 16/4/21.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "NSString+MyString.h"
#import "objc/message.h"

@implementation NSString (MyString)

+(void)load
{

    SEL originalSelector = @selector(lowercaseString);
    SEL swizzledSelector = @selector(eoc_myLowercaseString);

    Class class = [self class];
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

//代码调试 开发时有用
-(NSString *)eoc_myLowercaseString
{
    NSString  *lowercaseString = [self eoc_myLowercaseString];
    return lowercaseString;
}

@end
