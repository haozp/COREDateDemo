//
//  WaterfallViewFlowLayout.m
//  COREDateDemo
//
//  Created by leo on 16/9/2.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "WaterfallViewLayout.h"

//默认列数
static const CGFloat DefautcolumnCount = 3;
//列之间的间距
static const CGFloat DefautcolumnMargin = 10;
//行之间的间距
static const CGFloat DefautRowMargin = 10;
//边缘的间距
static const UIEdgeInsets  DefautEdeinsets = {10,10,10,10};

@interface WaterfallViewLayout()

//存放所有cell的布局属性
@property (nonatomic,strong) NSMutableArray *attrsArry;

//存放所有列的高度
@property (nonatomic,strong) NSMutableArray<NSNumber *> *columnHeights;

@end

@implementation WaterfallViewLayout

#pragma mark - 常见数据处理
- (CGFloat)rowMargin{
    if ([self.detegate respondsToSelector:@selector(rowMarginInWaterfallViewLayout:)]) {
        return [self.detegate rowMarginInWaterfallViewLayout:self];
    }else{
        return DefautRowMargin;
    }
}

- (CGFloat)columnMargin{
    if ([self.detegate respondsToSelector:@selector(columnMarginInWaterfallViewLayout:)]) {
        return [self.detegate columnMarginInWaterfallViewLayout:self];
    }else{
        return DefautcolumnMargin;
    }
}

- (NSUInteger)columnCount{
    if ([self.detegate respondsToSelector:@selector(columnCountInWaterfallViewLayout:)]) {
        return [self.detegate columnCountInWaterfallViewLayout:self];
    }else{
        return DefautcolumnCount;
    }
}

- (UIEdgeInsets)edgeInsets{
    if ([self.detegate respondsToSelector:@selector(edgeinsetsInWaterfallViewLayout:)]) {
        return [self.detegate edgeinsetsInWaterfallViewLayout:self];
    }else{
        return DefautEdeinsets;
    }
}


- (NSMutableArray *)attrsArry
{
    if (!_attrsArry) {
        _attrsArry = [NSMutableArray array];
    }
    return _attrsArry;
}


- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

//初始化
-(void)prepareLayout
{

    //清空之前所有的布局属性
    [self.attrsArry removeAllObjects];
    //清除以前计算的多有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i=0; i<self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }

    //创建arry存放cell的布局属性
    NSMutableArray *arry = [NSMutableArray array];
    //创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //属性
        UICollectionViewLayoutAttributes *arrs = [self layoutAttributesForItemAtIndexPath:indexPath];

        [arry addObject:arrs];

    }

    self.attrsArry = arry;

}

//决定cell的排布
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

    return self.attrsArry;
}

//返回cell对应的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *arrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGFloat collectionViewW = self.collectionView.frame.size.width;
    CGFloat w = (collectionViewW-self.edgeInsets.right-self.edgeInsets.left-(self.columnCount-1)*self.columnMargin)/self.columnCount;

    //找出高度最小的那一列
    NSInteger index = 0;
    CGFloat minColumnHeight = self.columnHeights[0].doubleValue;

    for (NSInteger i=1; i<self.columnCount; i++) {
        CGFloat columnHeight = self.columnHeights[i].doubleValue;
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            index = i;
        }
    }

    CGFloat x = self.edgeInsets.left+index*(w+self.columnMargin);

    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y = minColumnHeight+self.rowMargin;
    }
    CGFloat h = [self.detegate waterfallView:self heightForItemAtIndex:indexPath.item itemWidth:w];
    arrs.frame = CGRectMake(x,y,w,h);

    //更新高度
    self.columnHeights[index] = @(CGRectGetMaxY(arrs.frame));

    return arrs;

}

- (CGSize)collectionViewContentSize
{

    //找出高度最大的那一列
    CGFloat maxColumnHeight = self.columnHeights[0].doubleValue;

    for (NSInteger i=1; i<self.columnCount; i++) {
        CGFloat columnHeight = self.columnHeights[i].doubleValue;
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }

    return CGSizeMake(0, maxColumnHeight+self.edgeInsets.bottom);
}

@end
