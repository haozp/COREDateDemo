//
//  WaterfallViewController.m
//  COREDateDemo
//
//  Created by leo on 16/9/1.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "WaterfallViewController.h"
#import "WaterfallViewLayout.h"
#import "MJRefresh.h"

@interface WaterfallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterfallViewFlowLayoutDelegate>

@property (nonatomic,weak) UICollectionView *collectView;
@property (nonatomic,strong) NSMutableArray *dataArry;

@property (nonatomic,strong) NSString *str;

@end

@implementation WaterfallViewController


static NSString * const XMGShopId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
    [self setRefresh];

    for (int i=0; i<20; i++) {
        [self.dataArry addObject:@0];
    }
}

- (NSMutableArray *)dataArry
{
    if (!_dataArry) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}

- (void)setupLayout
{
    //创建布局
    WaterfallViewLayout *layout = [[WaterfallViewLayout alloc]init];
    layout.detegate = self;

    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];

    // 注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:XMGShopId];

    self.collectView = collectionView;

}

- (void)setRefresh
{
    self.collectView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.collectView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (void)loadNew{
    [self.dataArry removeAllObjects];
    for (int i=0; i<20; i++) {
        [self.dataArry addObject:@0];
    }
    sleep(0.3);
    [self.collectView.header endRefreshing];
    [self.collectView reloadData];
}

- (void)loadMore
{
    for (int i=0; i<20; i++) {
        [self.dataArry addObject:@0];
    }
    sleep(0.3);
    [self.collectView.footer endRefreshing];
    [self.collectView reloadData];

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGShopId forIndexPath:indexPath];

    cell.backgroundColor = [UIColor orangeColor];


    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"\nitem:%ld--row:%ld---section:%ld",(long)indexPath.item,(long)indexPath.row,(long)indexPath.section);
}

#pragma mark - WaterfallViewFlowLayoutDelegate
-(CGFloat)waterfallView:(WaterfallViewLayout *)waterfallView heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return 30+arc4random_uniform(200);
}

- (NSUInteger)columnCountInWaterfallViewLayout:(WaterfallViewLayout *)waterfallView
{
    return 3;
}

- (UIEdgeInsets)edgeinsetsInWaterfallViewLayout:(WaterfallViewLayout *)waterfallView
{
    return UIEdgeInsetsMake(10, 10, 30, 10);
}


@end
