//
//  CircleCollectionViewLayout.m
//  COREDateDemo
//
//  Created by leo on 16/9/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "CircleCollectionViewLayout.h"

@interface CircleCollectionViewLayout()

@property (nonatomic,strong) NSMutableArray *attrsArry;


@end

@implementation CircleCollectionViewLayout

- (NSMutableArray *)attrsArry
{
    if (!_attrsArry) {
        _attrsArry = [NSMutableArray array];
    }
    return _attrsArry;
}

- (void)prepareLayout
{
    [super prepareLayout];


    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //属性
        UICollectionViewLayoutAttributes *arrs = [self layoutAttributesForItemAtIndexPath:indexPath];

        [self.attrsArry addObject:arrs];
        
    }

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArry;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];

    CGFloat radius = 70;
    //圆心的位置
    CGFloat oX = self.collectionView.frame.size.width*0.5;
    CGFloat oY = self.collectionView.frame.size.height*0.5;

    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.size = CGSizeMake(50, 50);
    CGFloat angle = (2*M_PI)/count * indexPath.item;
    CGFloat centerX = oX + radius*sin(angle);
    CGFloat centerY = oY + radius*cos(angle);
    attr.center = CGPointMake(centerX, centerY);
    return  attr;

}

@end
