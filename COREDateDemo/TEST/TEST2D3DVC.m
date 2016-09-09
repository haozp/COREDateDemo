//
//  TESTCGAffineTransformVC.m
//  COREDateDemo
//
//  Created by leo on 16/1/25.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "TEST2D3DVC.h"

@interface TEST2D3DVC ()
{
    UIImageView *imagess;
    double angle;
    NSTimer *scrowTimer;
    BOOL isScrow;

    CGAffineTransform testTransform;
    CATransform3D rotationAndPerspectiveTransform;
    UIView *testOrangeView;
}
@end

@implementation TEST2D3DVC

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    imagess.hidden = YES;
    [scrowTimer invalidate];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self addBtn];

    //------------------------------旋转-----------------------------------
    imagess = [[UIImageView alloc]init];
    //这个一定要在设置frame之前设置 设置绕着哪个旋转 如果是在设置frame后设置改值，要注意对view视图的影响
    imagess.layer.anchorPoint = CGPointMake(0.0, 0.0);

    imagess.frame = CGRectMake(70, 170, 290, 100);
    imagess.image = [UIImage imageNamed:@"TC_Moon"];
    [self.view addSubview:imagess];
    UIView *viewBack = [[UIView alloc]initWithFrame:imagess.frame];
    viewBack.backgroundColor = [UIColor greenColor];
    [self.view addSubview:viewBack];

    //CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI*0.38);
    // imagess.transform = transform;//旋转

    /*关于M_PI
     #define M_PI     3.14159265358979323846264338327950288
     其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
     旋转方向为：顺时针旋转

     */
    imagess.backgroundColor = [UIColor redColor];


    [UIView animateKeyframesWithDuration:1.0 delay:0.6 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.15 animations:^{
            //90 degrees (clockwise)
           // imagess.transform = CGAffineTransformMakeRotation(M_PI * 1.3);
        }];
    } completion:nil];

    [self addTEST_2D_ViewScrowView];
    [self addTEST_3D_ViewScrowView];


}

-(void)addBtn
{
    UIButton *btnTest = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTest.frame = CGRectMake(100, 370, 60, 30);
    btnTest.backgroundColor = [UIColor redColor];
    [self.view addSubview:btnTest];
    btnTest.tag = 3;
    [btnTest addTarget:self action:@selector(actionScrow:) forControlEvents:UIControlEventTouchUpInside];
    [btnTest setTitle:@"测试" forState:UIControlStateNormal];


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 370, 60, 30);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    btn.tag = 0;
    [btn addTarget:self action:@selector(actionScrow:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"开始" forState:UIControlStateNormal];

    UIButton *btnS = [UIButton buttonWithType:UIButtonTypeCustom];
    btnS.frame = CGRectMake(200, 370, 60, 30);
    btnS.backgroundColor = [UIColor redColor];
    [self.view addSubview:btnS];
    btnS.tag = 1;
    [btnS addTarget:self action:@selector(actionScrow:) forControlEvents:UIControlEventTouchUpInside];
    [btnS setTitle:@"停止" forState:UIControlStateNormal];


    

}

-(void)addTEST_2D_ViewScrowView
{

    UIView *orangeView = [[UIView alloc]init];
    testOrangeView = orangeView;
    orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:orangeView];
    orangeView.translatesAutoresizingMaskIntoConstraints = NO;
    //H水平方向 V 竖直方向
    NSArray *transV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[orangeView(80)]-40-|" options:0 metrics:nil views:@{@"orangeView":orangeView}];
    NSArray *transH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[orangeView(80)]-200-|" options:0 metrics:nil views:@{@"orangeView":orangeView}];

    [self.view addConstraints:transV];
    [self.view addConstraints:transH];

   //------------------------------2D-测试旋转------------------

    //CGAffineTransform 是个矩阵变换 3*3矩阵变化 http://www.th7.cn/Program/IOS/201312/165775.shtml
    //testTransform= CGAffineTransformMake(a, b, c, d, T, W);

    /*
     这是个变换 变换值可以自定义对应的变换 变换前坐标(x,y)  变换后(X,Y)
     X = ax+cy+T   Y= bx+dy+W
     */

   //testTransform= CGAffineTransformMakeRotation(M_PI*0.38);//旋转
      //testTransform = CGAffineTransformMakeTranslation(10, -200);//移动
    testTransform = CGAffineTransformMakeScale(0.5, 0.5);//缩放,注意这里会有坐标变换


    //testTransform = CGAffineTransformConcat(testTransform, CGAffineTransformMakeRotation(M_PI*0.38));//t1*t2


    //+++++++++++++++++++++++++++++++++2D++++++++++++++++++++++++++++++++
     // testTransform = CGAffineTransformRotate(testTransform, M_PI*0.38); 旋转
     //testTransform=CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI*0.5), 10, -200);//移动 前一个值为上次变换的设置
     //CGAffineTransformScale(<#CGAffineTransform t#>, <#CGFloat sx#>, <#CGFloat sy#>) 缩放
    //CGAffineTransformInvert(testTransform) 返回testTransform的相反变换


}

-(void)addTEST_3D_ViewScrowView
{

//    rotationAndPerspectiveTransform = CATransform3DIdentity;
//    //rotationAndPerspectiveTransform.m34 = 1.0 / -500;
//    rotationAndPerspectiveTransform.m33 = -0.5;
//    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 180.0f * M_PI / 180.0f, 0.7f, 0.0f, 0.5f);
//    //layer.transform = rotationAndPerspectiveTransform;

    [UIView animateWithDuration:2.0 delay:0 options: UIViewAnimationOptionRepeat |UIViewAnimationOptionAutoreverse animations:^{
        CATransform3D rotationTransform2 = CATransform3DIdentity;
        rotationTransform2.m34 = -1.0f/200.0f;
        rotationTransform2 = CATransform3DRotate(rotationTransform2, -0.25* M_PI_2, 0.0f, 1.0f, 0.0f);
        testOrangeView.layer.transform = rotationTransform2;

        testOrangeView.layer.zPosition = 100;
        
    } completion:^(BOOL finished) {
        
    }];

}

-(IBAction)actionScrow :(id)sender
{

    UIButton *btn = (UIButton *)sender;
    if (btn.tag==0) {
        if (isScrow) {
            return;
        }
        scrowTimer= [NSTimer scheduledTimerWithTimeInterval: 0.001 target: self selector:@selector(transformAction) userInfo: nil repeats: YES];
        isScrow  = YES;
    }else if(btn.tag==1){
        if (!isScrow) {
            return;
        }
        [scrowTimer invalidate];
        isScrow = NO;
        
    }else if (btn.tag==3){
        //------------------2D-----------
        //testOrangeView.transform = testTransform;
        //testTransform=CGAffineTransformTranslate(testOrangeView.transform, 10, -200);//移动 前一个值为上次平移的设置
        //testOrangeView.transform = CGAffineTransformTranslate(testOrangeView.transform, 10, -200);
       // testTransform= CGAffineTransformMakeTranslation(10, -200);//移动

//        [UIView animateWithDuration:4.0 // 动画时长
//                              delay:0.0 // 动画延迟
//             usingSpringWithDamping:0.8 // 类似弹簧振动效果 0~1
//              initialSpringVelocity:9.0 // 初始速度
//                            options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
//                         animations:^{
//                             // code...
//                             CGPoint point = testOrangeView.center;
//                             point.y += 10;
//                             [testOrangeView setCenter:point];
//                         } completion:^(BOOL finished) {
//                             // 动画完成后执行
//                             // code...
//                             [testOrangeView setAlpha:1];
//                         }];

        //[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(transformActionTwo) userInfo:nil repeats:NO];

        //-----------------3D----------------------------------
        //UIViewKeyframeAnimationOptionRepeat
        [UIView animateKeyframesWithDuration:1.0 delay:0 options:0 animations:^{
            testOrangeView.layer.transform = rotationAndPerspectiveTransform;
        }completion: ^(BOOL finished){
            testOrangeView.backgroundColor = [UIColor greenColor];
        }];


    }

}

-(void)transformActionTwo
{
    testOrangeView.transform = testTransform;


}

-(void)transformAction
{

        angle = angle + 0.15;//angle角度 double angle;
        if (angle > 6.28) {//大于 M_PI*2(360度) 角度再次从0开始
            angle = 0;
        }
        CGAffineTransform transform=CGAffineTransformMakeRotation(angle);
        imagess.transform = transform;
    //NSLog(@"%f==%f==%f==%f",imagess.frame.size.height,imagess.frame.size.width,imagess.frame.origin.x,imagess.frame.origin.y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
