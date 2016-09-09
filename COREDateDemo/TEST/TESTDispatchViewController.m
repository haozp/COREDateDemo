//
//  TESTDispatchViewController.m
//  COREDateDemo
//
//  Created by leo on 16/2/26.
//  Copyright © 2016年 haozp. All rights reserved.
//  测试 dispatch

#import "TESTDispatchViewController.h"

@interface TESTDispatchViewController ()

@end

@implementation TESTDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    [self testGCD];
//    [self testLock];

    [self testSomeThing];
    testGCD_HH([NSDate date]);


}

void testGCD_HH(NSDate *date){
    NSLog(@"%f",[date timeIntervalSince1970]);


    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    dispatch_async(queue, ^{

        sleep(3);
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    //barrier
    dispatch_queue_t myqueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myqueue, ^{
        sleep(3);
    });
    dispatch_async(myqueue, ^{
        sleep(5);
    });

    dispatch_barrier_async(myqueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //code~~~
            NSLog(@"something is finished");

        });
    });

}

-(void)testGCD
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 30, 30)];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];

    __block UIImageView *imaV = imageView;

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{

        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.xiaoxiongbizhi.com/wallpapers/__85/1/v/1v9eyjoh2.jpg"]];
        UIImage *image =[UIImage imageWithData:data];

        if(image){
            dispatch_async(dispatch_get_main_queue(), ^{
                imaV.image = image;
//                imageView.image = image;
            });
        }
        
    });

}

-(void)testLock
{
    NSRecursiveLock *theLock = [[NSRecursiveLock alloc] init];
     static void (^MyRecursiveFunction)(int);

     MyRecursiveFunction = ^(int value){
        [theLock lock];
        if (value != 0) {
            NSLog(@"%d",value);
            --value;
            MyRecursiveFunction(value);
        }
        [theLock unlock];
     };
    MyRecursiveFunction(5);
}

-(void)testSomeThing
{
   CALayer *grayCover = [[CALayer alloc] init];
//    grayCover.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
    grayCover.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor greenColor]);

    [self.view.layer addSublayer:grayCover];

    UIView *testRedView = [[UIView alloc]initWithFrame:CGRectMake(70, 70, 200, 400)];
    testRedView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:testRedView];

    [testRedView.layer addSublayer:grayCover];



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
