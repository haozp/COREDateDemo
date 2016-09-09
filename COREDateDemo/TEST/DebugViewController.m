//
//  DebugViewController.m
//  COREDateDemo
//
//  Created by leo on 16/5/13.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "DebugViewController.h"
#import "UINavigationBar+myTestChangeBackColor.h"



@interface DebugViewController ()
{
}

@property(nonatomic,strong) UIView *myview;
@property(nonatomic,strong) UIImageView *imageView;


@end

@implementation DebugViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];


}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar hao_reset];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

        self.title = @"你是傻逼";

    [self.navigationController.navigationBar hao_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];



    [self createUI];

#if DEBUG
    dispatch_queue_t queue = dispatch_get_main_queue();
    static dispatch_source_t source = nil;

    __typeof(self) __weak weakSelf = self;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGSTOP, 0, queue);
        if (source)
        {
            dispatch_source_set_event_handler(source, ^{
                NSLog(@"Hi, I am: %@", weakSelf);
            });
            dispatch_resume(source);
        }
    });
#endif

    // The other stuff
}

/*
 动态改变 使用方法
 (lldb) po weakSelf.myview.backgroundColor = [UIColor redColor];
 UIDeviceRGBColorSpace 1 0 0 1

 2016-05-24 16:35:03.225 COREDateDemo[2177:249319] Hi, I am: <DebugViewController: 0x7b71c5f0>
 2016-05-24 16:35:18.406 COREDateDemo[2177:249319] Hi, I am: <DebugViewController: 0x7b71c5f0>
 (lldb) po weakSelf.myview.frame = CGRectMake(0, 200, 20, 90);
 (origin = (x = 0, y = 200), size = (width = 20, height = 90))

 2016-05-24 16:35:50.507 COREDateDemo[2177:249319] Hi, I am: <DebugViewController: 0x7b71c5f0>

 */

-(void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    _myview = [[UIView alloc]initWithFrame:CGRectMake(20, 130, 300, 30)];
    _myview.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_myview];

    UIImageView *imageViewSuper = [[UIImageView alloc]initWithFrame:CGRectMake(20, 200, 350, 100)];
    imageViewSuper.image = [UIImage imageNamed:@"superBack"];
    imageViewSuper.contentStretch = CGRectMake(0.1,0.1, 0.8, 0.8);
    [self.view addSubview:imageViewSuper];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 350, 350, 260)];
    UIImage *imageTest = [UIImage imageNamed:@"backTest4"];

//    CGFloat top = 0; // 顶端盖高度
//    CGFloat left = 0; // 左端盖宽度
//    CGFloat bottom =  imageTest.size.height ; // 底端盖高度
//    CGFloat right  =  imageTest.size.height; // 右端盖宽度
//
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
//    imageTest = [imageTest resizableImageWithCapInsets:UIEdgeInsetsMake(150, 0,0, 0)];

    imageTest = [imageTest resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0,150, 0) resizingMode:UIImageResizingModeStretch];
//    _imageView.contentStretch = CGRectMake(0,0, 0.1, 0.01);
//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = imageTest;
    [self.view addSubview:_imageView];

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
