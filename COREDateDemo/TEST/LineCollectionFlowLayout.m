//
//  CollectionFlowLayout.m
//  COREDateDemo
//
//  Created by leo on 16/9/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "LineCollectionFlowLayout.h"

@implementation LineCollectionFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    CGFloat width = (self.collectionView.frame.size.width - self.itemSize.width)/2;
    self.sectionInset = UIEdgeInsetsMake(0, width, 0, width);
}

/**
 *当collectionview显示范围改变时 是否需要重新刷新布局
 *即重新处理布局属性
 */

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *返回的数组(存放rect范围内所有元素的布局属性)
 *这个方法返回值决定rect范围内所有元素的排布(frame)
 */

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

    CGFloat centerX = self.collectionView.contentOffset.x+self.collectionView.frame.size.width*0.5;

    //获得super已经计算好的布局属性 在原有布局属性的基础上进行微调
//    NSArray *arry = [super layoutAttributesForElementsInRect:rect];
    NSArray *arry = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];

    for (UICollectionViewLayoutAttributes *attrs in arry) {

     CGFloat delta = ABS(attrs.center.x - centerX);

        CGFloat scale = 1.1 - delta/(self.collectionView.frame.size.width);
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        //在这里终于感觉到数学的用处了
       // CGFloat y = scale *attrs.center.y;
        CGFloat y = attrs.center.y+attrs.size.height*(1-scale)/2;

//        CGFloat x = attrs.center.x;
        attrs.center = CGPointMake(attrs.center.x, y);
    }

    return arry;
}

/**
 *这个方法决定滚动结束时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{

    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;

    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;

    NSArray *arry = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];


    CGFloat mindelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in arry) {

        if (ABS(mindelta) > ABS(attrs.center.x - centerX)) {
            mindelta = attrs.center.x - centerX;
        }
    }
    CGFloat s = proposedContentOffset.x+mindelta;
    if (s<0&&s>-0.00000001) {//这里处理数据精度的问题
        s = 0;
    }
    proposedContentOffset.x = s;
    return proposedContentOffset;
}
@end
