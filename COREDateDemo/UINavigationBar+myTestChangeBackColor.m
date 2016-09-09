//
//  UINavigationBar+myTestChangeBackColor.m
//  COREDateDemo
//
//  Created by leo on 16/5/12.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "UINavigationBar+myTestChangeBackColor.h"
#import "objc/runtime.h"

@implementation UINavigationBar (myTestChangeBackColor)

static char  overlayHaoerViewKey;

-(UIView *)overlayHao
{
    return objc_getAssociatedObject(self, &overlayHaoerViewKey);
}

-(void)setOverlayHao:(UIView *)overlayHao
{
    objc_setAssociatedObject(self, &overlayHaoerViewKey, overlayHao, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)hao_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlayHao) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlayHao = [[UIView alloc]initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)+20)];
        self.overlayHao.userInteractionEnabled = NO;
        self.overlayHao.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlayHao atIndex:0];
    }
    self.overlayHao.backgroundColor = backgroundColor;
}

-(void)hao_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

-(void)hao_setElementsAlpha:(CGFloat)alpha
{

    [[self valueForKey:@"_leftViews"]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {

        view.alpha = alpha;
    }];

    [[self valueForKey:@"_rightViews"]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {

        view.alpha = alpha;
    }];

    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    [[self subviews]enumerateObjectsUsingBlock:^(UIView *obj ,NSUInteger i,BOOL *stop){
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

-(void)hao_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlayHao removeFromSuperview];
    self.overlayHao = nil;
}


@end
