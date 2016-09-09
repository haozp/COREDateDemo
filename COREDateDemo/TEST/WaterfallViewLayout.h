//
//  WaterfallViewFlowLayout.h
//  COREDateDemo
//
//  Created by leo on 16/9/2.
//  Copyright © 2016年 haozp. All rights reserved.
//

//UICollectionViewFlowLayout//流水布局
//UICollectionViewLayout    //基本布局
//UICollectionViewFlowLayout : UICollectionViewLayout


#import <UIKit/UIKit.h>

@class WaterfallViewLayout;

@protocol WaterfallViewFlowLayoutDelegate <NSObject>

@required
- (CGFloat)waterfallView:(WaterfallViewLayout *)waterfallView heightForItemAtIndex:(NSUInteger )index itemWidth:(CGFloat)itemWidth;

@optional

- (NSUInteger)columnCountInWaterfallViewLayout:(WaterfallViewLayout *)waterfallView;
- (CGFloat)columnMarginInWaterfallViewLayout:(WaterfallViewLayout *)waterfallView;
- (CGFloat)rowMarginInWaterfallViewLayout:(WaterfallViewLayout *)waterfallView;
- (UIEdgeInsets)edgeinsetsInWaterfallViewLayout:(WaterfallViewLayout *)waterfallView;

@end

@interface WaterfallViewLayout : UICollectionViewLayout

@property (nonatomic,weak) id<WaterfallViewFlowLayoutDelegate> detegate;

@end
