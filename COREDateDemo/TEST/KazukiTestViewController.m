//
//  KazukiTestViewController.m
//  COREDateDemo
//
//  Created by leo on 16/6/8.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "KazukiTestViewController.h"

@interface KazukiTestViewController ()

@end

@implementation KazukiTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //Core Foundation 和 Foundation
    CFMutableArrayRef cfobject = NULL;
    {
        id obj = [[NSMutableArray alloc]init];
        cfobject = CFBridgingRetain(obj);
        printf("retain count cfobject= %ld\n",CFGetRetainCount(cfobject));
        printf("retain count obj= %ld\n",CFGetRetainCount((__bridge CFTypeRef)(obj)));

    }
    printf("after retain count = %ld\n",CFGetRetainCount(cfobject));
    CFRelease(cfobject);

    //-----------------------------
    {
        CFMutableArrayRef cfobject2 = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);
        printf("retain count =%ld\n",CFGetRetainCount(cfobject2));

        id obj3 = CFBridgingRelease(cfobject2);
        printf("retain count after = %ld\n",CFGetRetainCount(cfobject2));
        NSLog(@"%@\n",obj3);
    }

    //  id--->void
    id obj2 = [[NSObject alloc]init];
    void *p2 = (__bridge void*)obj2;


    //   void---->id
    id obj3 = (__bridge id)p2;

    CFShow(p2);
    NSLog(@"%@===%@",obj2,obj3);

    [self testMemeryOut];

    // Do any additional setup after loading the view.
}

- (void)testMemeryOut{

    //------------------
    {
    CFMutableArrayRef cfobject = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);
    printf("retain count = %ld\n",CFGetRetainCount(cfobject));
    /*
     core foundation 框架生成并持有对象
     之后的对象引用计数为1
     */
        id obj = (__bridge id)cfobject;
        /*
         因为赋值给附有__strong修饰符的变量中
         所以发生强引用
        */
        printf("retain count after the cast = %ld\n",CFGetRetainCount(cfobject));
        /*
         因为变量obj持有对象强引用并且对象进行
         则引用计数为2
         */

        NSLog(@"class = %@",obj);
    }

    /*
     因为变量超出obj的作用域
     所以其强引用失效，对象得以释放
     */

    /*
     因为引用计数为1，所以对象仍存在
     发生内存泄露
     */


    //因此，在将oc变量赋值给c语言变量，即没有附加所有权修饰符的void*等指针型变量时，伴随着一定的风险。在实现代码时要高度重视。

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
