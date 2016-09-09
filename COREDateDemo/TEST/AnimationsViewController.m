//
//  AnimationsViewController.m
//  COREDateDemo
//
//  Created by leo on 16/6/17.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "AnimationsViewController.h"
#import "PiechartView.h"


@interface AnimationsViewController ()
{
    PiechartView   *_chartOne;
}
@end

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation AnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];

    _chartOne = [[PiechartView alloc]initWithFrame:CGRectMake(140, 170, 100, 100) withStrokeWidth:10 andColor:[UIColor whiteColor] andPercent:0.9f andAnimation:NO];
    //    _chartOne.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_chartOne];


    UIView *viewBB = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 300, 300)];
   // [self.view addSubview:viewBB];
    viewBB.backgroundColor =[UIColor orangeColor];

    CGFloat radius = (viewBB.frame.size.width -10)/2 -2;

    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:viewBB.center radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:NO];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:viewBB.bounds];
    [shapeLayer setPosition:viewBB.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setLineWidth:3.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:100],
      [NSNumber numberWithInt:185],nil]];

    // Setup the path
//    CGMutablePathRef path = (__bridge CGMutablePathRef)(circlePath);
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, 0,0);
//
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    
//    [[viewBB layer] addSublayer:shapeLayer];


    CGFloat testWidth;
    testWidth = 360;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat viewWidth = testWidth;
    CGFloat viewHeight = testWidth;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - viewWidth)/2, (screenSize.height - viewHeight) / 2, viewWidth, viewHeight)];
    view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    view.layer.cornerRadius = CGRectGetWidth(view.bounds)/2;

    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));

    //    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
   // CGFloat  ss = 20. / [[UIScreen mainScreen] scale];
    borderLayer.lineWidth = 3;
    //虚线边框

    // 3=线的宽度 1=每条线的间距 [shapeLayer setLineDashPattern:
    [borderLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
      [NSNumber numberWithInt:10],nil]];

//    borderLayer.lineWidth = 5;
//    borderLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:5], [NSNumber numberWithInt:5], [NSNumber numberWithInt:2], nil];
    //shapeLayer.lineDashPhase = 15;

   // NSNumber *hh = [NSNumber numberWithFloat:ss];
   // borderLayer.lineDashPattern = @[hh,hh];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor redColor].CGColor;
    borderLayer.lineCap = kCALineCapRound;
    [view.layer addSublayer:borderLayer];
    //[self.view addSubview:view];

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
