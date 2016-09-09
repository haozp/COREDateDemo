//
//  TESTUINavigationControllerDelegate.m
//  COREDateDemo
//
//  Created by leo on 16/2/19.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "TESTUINavigationControllerDelegate.h"
#import "SlideAnimation.h"
#import "ShuffleAnimation.h"
#import "ScaleAnimation.h"

#import "TESTtransitions_VC.h"
#import "TEST_trsnsition_1_VC.h"

@interface TESTUINavigationControllerDelegate ()
{

    SlideAnimation *_slideAnimationController;
    ShuffleAnimation *_shuffleAnimationController;
    ScaleAnimation *_scaleAnimationController;
}

@end


@implementation TESTUINavigationControllerDelegate

- (void)awakeFromNib
{
    _slideAnimationController = [[SlideAnimation alloc] init];
    _shuffleAnimationController = [[ShuffleAnimation alloc] init];
    _scaleAnimationController = [[ScaleAnimation alloc] init];
}

#pragma mark - Navigation Controller Delegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {


    if (([fromVC isKindOfClass:TESTtransitions_VC.class]&& [toVC isKindOfClass:TEST_trsnsition_1_VC.class])||([fromVC isKindOfClass:TEST_trsnsition_1_VC.class]&& [toVC isKindOfClass:TESTtransitions_VC.class])) {
        BaseAnimation *animationController;

        animationController = _shuffleAnimationController;//_shuffleAnimationController _slideAnimationController
        switch (operation) {
            case UINavigationControllerOperationPush:
                animationController.type = AnimationTypePresent;
                return  animationController;
            case UINavigationControllerOperationPop:
                animationController.type = AnimationTypeDismiss;
                return animationController;
            default: return nil;
        }

    }else{
        return nil;
    }

    //animationController =_shuffleAnimationController;



}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return nil;
}


@end
