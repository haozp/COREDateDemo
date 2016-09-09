//
//  StatisticsViewController.m
//  
//
//  Created by leo on 16/7/4.
//
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    //添加两个按钮到View上面
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = (CGRect){100,200,50,50};
    [btn addTarget:self action:@selector(btn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"添加A" forState:UIControlStateNormal];
    [self.view addSubview:btn];


    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn2.frame = (CGRect){200,200,50,50};
    [btn2 addTarget:self action:@selector(btn2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"添加B" forState:UIControlStateNormal];

    [self.view addSubview:btn2];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,300,100, 130)];
    imageView.tag = 300;
    imageView.backgroundColor = [UIColor redColor];
    [imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnPicture:)];
    [singletap setNumberOfTapsRequired:1];
    [imageView addGestureRecognizer:singletap];

    [self.view addSubview:imageView];

    UIImageView *imageViewTwo = [[UIImageView alloc]initWithFrame:CGRectMake(130+10,300,100, 130)];
    imageViewTwo.tag = 400;
    imageViewTwo.backgroundColor = [UIColor redColor];
    [imageViewTwo setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singletapTwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnPicture:)];
    [singletapTwo setNumberOfTapsRequired:1];
    [imageViewTwo addGestureRecognizer:singletapTwo];

    [self.view addSubview:imageViewTwo];


}

- (void)tapOnPicture:(UIGestureRecognizer *)ges
{
    NSLog(@"手势 %d  %s %d",__LINE__,__FUNCTION__,__APPLE_CC__);
}

#pragma mark - 按钮点击事件
- (void)btn1Clicked:(UIButton *)btn{
    NSLog(@"btn1");


}
- (void)btn2Clicked:(UIButton *)btn{
    NSLog(@"btn2");
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
