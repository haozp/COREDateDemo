//
//  CollectionViewController.m
//  COREDateDemo
//
//  Created by leo on 16/9/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "CollectionViewController.h"
#import "LineCollectionFlowLayout.h"
#import "CircleCollectionViewLayout.h"

@interface CollectionViewController ()<UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation CollectionViewController

static NSString * const collectionID = @"collection";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setCollectionView];
}

-(void)setCollectionView{
    //创建布局
    LineCollectionFlowLayout *layout = [[LineCollectionFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);

    // 创建CollectionView
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 200;

    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];

    collectionView.dataSource = self;
    [self.view addSubview:collectionView];

    // 注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionID];

    self.collectionView = collectionView;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[LineCollectionFlowLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[CircleCollectionViewLayout alloc] init] animated:YES];
    } else {
        LineCollectionFlowLayout *layout = [[LineCollectionFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
}

#pragma mark - collectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

@end
