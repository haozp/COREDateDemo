//
//  ViewController.m
//  COREDateDemo
//
//  Created by leo on 15/7/17.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import "ViewController.h"

#import "NSString+MyString.h"
#import "objc/runtime.h"


#import "MYDataTableViewController.h"
#import "SMIChatData.h"
#import "SMIServerRequst.h"
#import "TestTableViewController.h"
#import "TESTAutoLyoutVC.h"
#import "TEST2D3DVC.h"
#import "TESTDispatchViewController.h"
#import "TEST/TESTMPMVViewController.h"
#import "MYCellTableViewController.h"

#import "TESTtransitions_VC.h"
#import "TESTUINavigationControllerDelegate.h"
#import "TESTModelFirViewController.h"
#import "ServerRequestViewController.h"

#import "Effective20ViewController.h"
#import "DebugViewController.h"

#import "ModalAnimation.h"
#import "SlideAnimation.h"
#import "ShuffleAnimation.h"
#import "ScaleAnimation.h"

#import "SqliteDataProfessor.h"

@interface ViewController ()<UIWebViewDelegate,SMIServerRequstDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIWebView *webView;
    UIView *redView;
    NSArray *selectArryTitle;


    ModalAnimation *_modalAnimationController;
    SlideAnimation *_slideAnimationController;
    ShuffleAnimation *_shuffleAnimationController;
    ScaleAnimation *_scaleAnimationController;


    UITableView *myTestTableview;
    NSMutableArray *classDataArry;


}

@end

@implementation ViewController

//======单元测试=====
- (int)hhTestDemo
{
    return 100;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    SqliteDataProfessor *pro = [SqliteDataProfessor shareSqliteDataProfessor];
//    NSDictionary *dict = @{
//                           @"timeDate":[NSDate date],
//                           @"logString":@"logStringffefeffefefefegtgtgtt",
//                           @"tryCount":@"",
//                           };
//
//    [pro insertData:dict];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    SqliteDataProfessor *pro = [SqliteDataProfessor shareSqliteDataProfessor];
//    NSDictionary *dict = @{
//                           @"timeDate":[NSDate date],
//                           @"logString":@"logStringffefeffefefefegtgtgtt",
//                           @"tryCount":@"",
//                           };
//
//    [pro insertData:dict];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatMyTableView];
    self.navigationController.delegate = self;

   

    NSString  *Sefee = [@"EFfefefefeFfefefeFFFFefefeLLLAAfe" lowercaseString];


    NSString *mfeef= [Sefee stringByAppendingString:@"MMMMMMMfefe"];
    NSLog(@"%@--%@",Sefee,mfeef);

    int a = 12;
    int b = 22;
    NSLog(@"%d=====%d",a/b,19/4);

    　float m = (float)1/2;

    CGFloat s;
    s = a/b;
    NSLog(@"%f====%f",s,m);

    NSMutableArray *mudata;
    for (int i=0; i<mudata.count; i++) {
        NSLog(@"%d",i);
    }


    classDataArry = [@[@"CollectionViewController",@"WaterfallViewController",@"MasonryTestVC",@"SqliteTestViewController",@"IPoneInformation",@"StatisticsViewController",@"AnimationsViewController",@"TestViewController",@"CDWViewController",@"TestReactivecocoaVC",@"MYDataTableViewController",@"TestTableViewController",@"TESTAutoLyoutVC",@"TEST2D3DVC",@"TESTDispatchViewController",@"TESTMPMVViewController",@"TESTtransitions_VC",@"MYCellTableViewController",@"TESTModelFirViewController",@"Effective20ViewController",@"ServerRequestViewController",@"DebugViewController",@"KazukiTestViewController"]mutableCopy];
    //Load our animation controllers
    _modalAnimationController = [[ModalAnimation alloc] init];
    _slideAnimationController = [[SlideAnimation alloc] init];
    _shuffleAnimationController = [[ShuffleAnimation alloc] init];
    _scaleAnimationController = [[ScaleAnimation alloc] initWithNavigationController:self.navigationController];

    /*
    _modalAnimationController = [[ModalAnimation alloc] init];

    SMIServerRequst *requst = [[SMIServerRequst alloc]init];
    requst.delegate = self;
    [requst getDataFromServerWithServerPath:nil dataDict:nil codeString:nil];

    SMIServerRequst *server = [[SMIServerRequst alloc]init];
    server.delegate =self;
//    NSDictionary *dict = @{
//                           @"userId":@"17000183593"
//                           };

       //[server getDataFromServerWithServerPath:nil dataDict:nil codeString:@"cityaslevelplist" ];



    self.view.backgroundColor = [UIColor whiteColor];
    
    //在这里存数据
    for (int i =0; i<90; i++) {
        
        NSString *fromCustId = @"小小";
        NSString *toCustId = @"isMe";
        NSString *userCustId = @"小小";
        
        NSDate *date = [NSDate date];
        NSString *message = [NSString stringWithFormat:@"===%d==++%@++===%d",i,fromCustId,i];
        //locationTupe  0接收-对方  1中间  2发送
        NSNumber *locationType = [NSNumber numberWithInt:2];
        NSNumber *type = [NSNumber numberWithInt:0];

        
        //入库
        NSDictionary *dictChat = @{
                                   @"date":date,
                                   @"message":message,
                                   @"type":type,
                                   @"fromCustId":fromCustId,
                                   @"toCustId":toCustId,
                                   @"userCustId":userCustId,
                                   @"locationType":locationType
                                   };
        
        SMIChatData *data = [[SMIChatData alloc]init];
        [data saveChatDataToCoreData:dictChat];
        
    }
    
    NSLog(@"++++++OVER+++++++");

//
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showSomeView) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 50, 30);
    button.backgroundColor = [UIColor redColor];
    button.accessibilityLabel = @ "User" ;

    [self.view addSubview:button];
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    webView.hidden = YES;
    [self.view addSubview:webView];


    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 10, 200)];
    UIImage *image = [UIImage imageNamed:@"TC_Moon"];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(14, 0, 0, 0);
    image = [image resizableImageWithCapInsets:edgeInsets];//图片拉伸
    imageView.image = image;

    [self.view addSubview:imageView];

    NSDate *newDate = [NSDate date];

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];

    NSString *destDateString = [dateFormatter stringFromDate:newDate];



    UILabel *timeLabrel = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 300, 60)];
    timeLabrel.text = destDateString;


    UIFont *tfont = [UIFont fontWithName:@"DB LCD Temp" size:16]; //
    timeLabrel.font = tfont;
    [self.view addSubview:timeLabrel];


    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    // 2.VFL生成约束
    NSArray *conts =
    [NSLayoutConstraint constraintsWithVisualFormat:
     @"H:|-20-[blueView]-20-|" options:0 metrics:nil views:
     @{@"blueView" : blueView}];
    [self.view addConstraints:conts];
    NSArray *conts2 =
    [NSLayoutConstraint constraintsWithVisualFormat:
     @"V:|-300-[blueView(40)]-20-[redView(==20)]" options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"blueView" : blueView, @"redView" : redView}];
    [self.view addConstraints:conts2];
    NSLayoutConstraint *redWidth =
    [NSLayoutConstraint constraintWithItem:redView attribute:
     NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:
     blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:
     40.0];
    [self.view addConstraint:redWidth];
*/
   
}

- (void)creatMyTableView
{
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource =  self;
    [self.view addSubview:tableV];
    myTestTableview = tableV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Transitioning Delegate (Modal)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _modalAnimationController.type = AnimationTypePresent;
    return _modalAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _modalAnimationController.type = AnimationTypeDismiss;
    return _modalAnimationController;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    if(![toVC isKindOfClass:[TESTtransitions_VC class]]) return nil;

    BaseAnimation *animationController;

        animationController = _scaleAnimationController;
    switch (operation) {
        case UINavigationControllerOperationPush:
            animationController.type = AnimationTypePresent;
            return  animationController;
        case UINavigationControllerOperationPop:
            animationController.type = AnimationTypeDismiss;
            return animationController;
        default: return nil;
    }

}


#pragma mark-tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return classDataArry.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *myCellId = @"mycellIdTest";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCellId];
    }

    cell.textLabel.text = classDataArry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Class pushVc = NSClassFromString(classDataArry[indexPath.row]);
    UIViewController *pushMYVc = [[pushVc alloc]init];

    [self.navigationController pushViewController:pushMYVc animated:YES];

}


@end
