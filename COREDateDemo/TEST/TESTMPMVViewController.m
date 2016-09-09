//
//  TESTMPMVViewController.m
//  COREDateDemo
//
//  Created by leo on 16/3/9.
//  Copyright © 2016年 haozp. All rights reserved.
//
#define HEXCOLOR(rgbValue)			[UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0xFF)) / 255.0 alpha : 1.0]
#define IPHONE_WIDTH            [UIScreen mainScreen].bounds.size.width


#import "TESTMPMVViewController.h"

@interface TESTMPMVViewController ()
{
    UIView *lineMove;
    NSMutableArray *btnArry;
    NSArray *movieArry;
}

@end

@implementation TESTMPMVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor orangeColor];

//    UIButton *play = [UIButton buttonWithType:UIButtonTypeCustom];
//    play.frame = CGRectMake(20, 80, 80, 40);
//    play.backgroundColor = [UIColor redColor];
//    [play addTarget:self action:@selector(playMyMusic:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:play];



    NSArray *titleArry = @[@"猜你喜欢",@"随影卡片区"];

    for (int i=0; i<2; i++) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArry[i] forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(0x969696) forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(0xffc023) forState:UIControlStateSelected];

        btn.tag = i+200;
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(pushToSomeView:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(IPHONE_WIDTH/2*i,70,IPHONE_WIDTH/2,44);
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.selected = i==0?YES:NO;
        // btn.backgroundColor = i==0?[UIColor redColor]:[UIColor greenColor];
        [self.view addSubview:btn];
        [btnArry addObject:btn];
    }

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH/2,70, 0.5, 44)];
    lineView.backgroundColor = HEXCOLOR(0xd9d9d9);
    [self.view addSubview:lineView];

    UIView *lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0,104,IPHONE_WIDTH,0.5)];
    lineViewTwo.backgroundColor = HEXCOLOR(0xd9d9d9);
    [self.view addSubview:lineViewTwo];

    lineMove = [[UIView alloc]initWithFrame:CGRectMake(0, 142, IPHONE_WIDTH/2, 2)];
    lineMove.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineMove];

    //UIScrollView *scroWview = [[UIScrollView alloc]init];
    movieArry = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    for (int i=0; i<movieArry.count; i++) {

    }


    UIScrollView *myscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 164, IPHONE_WIDTH,308)];
    myscrollView.backgroundColor = [UIColor greenColor];
    myscrollView.tag = 1111;
    myscrollView.scrollEnabled = YES;
    myscrollView.delegate = self;

    myscrollView.contentSize = CGSizeMake(movieArry.count*108,208);

    for (int i = 0; i<movieArry.count; i++) {

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*128+5, 10, 108, 208)];
        imageView.backgroundColor = [UIColor orangeColor];
        //[imageView setImageWithURL:nil placeholderImage:[]];
        [myscrollView addSubview:imageView];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = imageView.frame;
        btn.tag = i + 300;
        //[scrollView addSubview:btn];
        [btn addTarget:self action:@selector(pushToSomeView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:myscrollView];
    
    


}

-(IBAction)pushToSomeView:(id)sender
{

}
-(IBAction)playMyMusic:(id)sender
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
