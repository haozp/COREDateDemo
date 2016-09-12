//
//  TestReactivecocoaVC.m
//  COREDateDemo
//
//  Created by leo on 16/6/12.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "TestReactivecocoaVC.h"

@interface TestReactivecocoaVC ()
{
}
@property (nonatomic,copy)   NSString    *frpString;
@property (nonatomic,copy)   NSString    *username;
@property (nonatomic,strong) UITextField *testF;
@property (nonatomic,strong) UITextField *testS;
@property (nonatomic,strong) UIButton    *btnTestRac;


@end

@implementation TestReactivecocoaVC
@synthesize frpString;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _testF = [[UITextField alloc]initWithFrame:CGRectMake(70, 70, 300, 100)];
    _testF.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_testF];
    _testS = [[UITextField alloc]initWithFrame:CGRectMake(70, 220, 300, 100)];
    _testS.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_testS];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.frame = CGRectMake(100, 400, 90, 20);
    [btn addTarget:self action:@selector(touchjij) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    _btnTestRac = btn;


    //信号订阅
    [self signSingnol];

    [[RACObserve(self,frpString )
      filter:^(NSString* value){
          if ([value hasPrefix:@"80"]) {
              return YES;
          } else {
              return NO;
          }
      }]
     subscribeNext:^(NSString* x){
         //request(x);//发送一个请求
         NSLog(@"接收到了消息===%@",x);
     }];

    [RACObserve(self, frpString)subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    [[RACObserve(self, frpString)
      filter:^(NSString *x){//filter 过滤
        if ([x isEqualToString:@"99"]) {
            return YES;
        }else{
            return NO;
        }
    }]subscribeNext:^(id x) {
        NSLog(@"是的 你是对的 %@",x);
    }];

    [RACObserve(self, username) subscribeNext: ^(NSString *newName){
        NSLog(@"newName:%@", newName);
    }];


    //[self testRAC];
    [self doSomeThing];

}

-(void)doSomeThing
{
    for (int i=0; i<120; i++) {
        self.frpString = [NSString stringWithFormat:@"%d",i];
    }
}

-(void)testRAC
{
    //    [self.testF.rac_textSignal subscribeNext:^(id x){
    //        if (x) {
    //            NSLog(@"%@",x);
    //            frpString = x;
    //        }else{
    //            NSLog(@"hhh");
    //        }
    //    }];

//    [[self.testF.rac_textSignal filter:^BOOL(id value) {
//        NSString *text = value;
//        return text.length>5;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    //RACSignal的每个操作都会返回一个RACsignal，这在术语上叫做连贯接口（fluent interface）。这个功能可以让你直接构建管道，而不用每一步都使用本地变量。

//    [[[self.testF.rac_textSignal map:^id(NSString *value) {
//        return @(value.length);
//    }]filter:^BOOL(NSNumber *value) {
//        return [value intValue]>3;
//    }]subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];

    //新加的map操作通过block改变了事件的数据。map从上一个next事件接收数据，通过执行block把返回值传给下一个next事件。在上面的代码中，map以NSString为输入，取字符串的长度，返回一个NSNumber。

    RACSignal *textFsignal = [self.testF.rac_textSignal map:^id(NSString *value) {
        return @(value.length);
    }];

    RAC(self.testF,backgroundColor) = [textFsignal map:^id(NSNumber *value) {
        return [value boolValue]?[UIColor orangeColor]:[UIColor lightGrayColor];
    }];

    RACSignal *textSsignal = [self.testS.rac_textSignal map:^id(NSString *value) {
        return @(value.length);
    }];

    RAC(self.testS,backgroundColor) = [textSsignal map:^id(id value) {
        return [value boolValue]?[UIColor orangeColor]:[UIColor lightGrayColor];
    }];

    //将上面两个信号聚合为一个信号
    @weakify(self);
 RACSignal *combineSignal = [RACSignal combineLatest:@[textFsignal,textSsignal]  reduce:^id(NSNumber *testFNumber,NSNumber *testSNumber){
     return @([testFNumber boolValue]&&[testSNumber boolValue]);
 }];

    [combineSignal subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.btnTestRac.userInteractionEnabled = [x boolValue];
        UIColor *co = [x boolValue]?[UIColor redColor]:[UIColor greenColor];
        [self.btnTestRac setBackgroundColor:co];
    }];

    //你已经知道了ReactiveCocoa框架是如何给基本UIKit控件添加属性和方法的了。目前你已经使用了rac_textSignal，它会在文本发生变化时产生信号。为了处理按钮的事件，现在需要用到ReactiveCocoa为UIKit添加的另一个方法，rac_signalForControlEvents。
    [[self.btnTestRac rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"button  is clicked");
        //这里只是为了说明 @strongify(self)可以直接用，因为上面已经    @weakify(self)，没必要在使用之前再次对其做处理。

        @strongify(self);
        [self.btnTestRac setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    }];


}

-(void)touchjij
{
    NSLog(@"jijiji");
    frpString = _testF.text;
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

#pragma mark-订阅信号
-(void)signSingnol
{
    // RACSignal使用步骤：
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 - (void)sendNext:(id)value

    // RACSignal底层实现：
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock

    // 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // block调用时刻：每当有订阅者订阅信号，就会调用block。

        // 2.发送信号
        [subscriber sendNext:@1];

        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];

        return [RACDisposable disposableWithBlock:^{

            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。

            // 执行完Block后，当前信号就不在被订阅了。

            NSLog(@"信号被销毁");

        }];
    }];

    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"是的你是对的，并且你已经接收到了数据:%@",x);
    }];
}

@end
