//
//  MYDataTableViewController.m
//  COREDateDemo
//
//  Created by leo on 15/7/17.
//  Copyright (c) 2015年 haozp. All rights reserved.
//



#import "MYDataTableViewController.h"
#import "SMIChatData.h"
#import "SMIChatMessageModel.h"
#import "Message.h"
#import "ALLDataViewController.h"
#import "TestWebViewViewController.h"

typedef NS_ENUM(NSInteger, DATAButtonType) {
    DATAButtonTypeNormol,
    DATAButtonTypeGetMoreFromServer,
    DATAButtonTypeDelete,
    DATAButtonTypeAdd,

};

@interface MYDataTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *myTableView;
    
    NSMutableArray *dataMutableArry;
    
    //user
    NSString *from;
    NSString *to;
    
    int page;//记录已经加载的数据页数
}
@end

@implementation MYDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"数据列表测试";

    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    myTableView.delegate=  self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    UIButton *buttonT = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonT.frame = CGRectMake(0,10,60, 30);
    buttonT.tag = DATAButtonTypeDelete;
    buttonT.backgroundColor = [UIColor greenColor];
    [buttonT setTitle:@"删除" forState:UIControlStateNormal];
    [buttonT addTarget:self action:@selector(adMoreData:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItemT = [[UIBarButtonItem alloc]initWithCustomView:buttonT];

    UIButton *buttonF = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonF.frame = CGRectMake(0,10,60, 30);
    buttonF.backgroundColor = [UIColor greenColor];
    buttonF.tag = DATAButtonTypeAdd;
    [buttonF setTitle:@"入库" forState:UIControlStateNormal];
    [buttonF addTarget:self action:@selector(adMoreData:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItemF = [[UIBarButtonItem alloc]initWithCustomView:buttonF];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,10,60, 30);
    button.backgroundColor = [UIColor greenColor];
    button.tag = DATAButtonTypeGetMoreFromServer;
    [button setTitle:@"读取更多" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(adMoreData:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];

    self.navigationItem.rightBarButtonItems = @[rightItemT,rightItemF,rightItem];
    page = 0;
    dataMutableArry = [NSMutableArray array];
    from = @"小小";
    to = @"isMe";
    SMIChatData *chatData = [[SMIChatData alloc]init];
    
    NSArray *arry = [chatData predictChatDataFromUser:from to:to WithPage:page onePageNumber:10];
    
    for (Message *messag in arry) {
        SMIChatMessageModel *dateModel = [[SMIChatMessageModel alloc]init];
        dateModel.date = messag.date;
        dateModel.fromCustId = messag.fromCustId;
        dateModel.toCustId = messag.toCustId;
        dateModel.userCustId = messag.userCustId;
        dateModel.locationType = messag.locationType;
        dateModel.type = messag.type;
        dateModel.message = messag.message;
        [dataMutableArry insertObject:dateModel atIndex:0];
    }

//    [self saveTestData];
}

-(void)saveTestData
{
    //在这里存数据
    for (int i =0; i<3; i++) {

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

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataMutableArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellId = @"MYDataTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    SMIChatMessageModel *model = dataMutableArry[indexPath.row];
    SMIChatMessageModel *lastModel;
    if (indexPath.row == 0) {
        lastModel = nil;
    }else{
        lastModel = dataMutableArry[indexPath.row-1];
    }
    [cell addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LONG:)]];
    cell.textLabel.text = model.message;
    cell.detailTextLabel.text =[self showTime:model.date];
    cell.detailTextLabel.hidden = [self isShowOrHideCellTimeWithModel:model lastModel:lastModel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ALLDataViewController *allVc = [[ALLDataViewController alloc]init];
    //    [self.navigationController pushViewController:allVc animated:YES];

//    TestWebViewViewController *testWebV = [[TestWebViewViewController alloc]init];
//    [self.navigationController pushViewController:testWebV animated:YES];

    
}


- (void)LONG:(UILongPressGestureRecognizer *)recognizer {

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UITableViewCell *cell = (UITableViewCell *)recognizer.view;
        [cell becomeFirstResponder];
        
        UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"Flag"action:@selector(flag:)];
        UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"Approve"action:@selector(approve:)];
        UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"deny"action:@selector(deny:)];


        UIMenuController *menu = [UIMenuController sharedMenuController];
        CGRect rect = CGRectMake(cell.frame.origin.x,cell.frame.origin.y, 80, 30);
        [menu setMenuItems:[NSArray arrayWithObjects:deny,deny,flag,flag,flag,flag, approve, nil]];
        [menu setTargetRect:rect inView:cell.superview];
        [menu setMenuVisible:NO];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder{
    
    return YES;
    
}

- (void)flag:(id)sender {
    NSLog(@"Cell was flagged");
}

- (void)approve:(id)sender {
    NSLog(@"Cell was approved");
}

- (void)deny:(id)sender {
    NSLog(@"Cell was denied");
}

-(IBAction)adMoreData:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case DATAButtonTypeAdd:
        {
            NSLog(@"DATAButtonTypeAdd入库 更多数据");
            [self saveTestData];
        }
            break;
        case DATAButtonTypeDelete:
        {
            NSLog(@"DATAButtonTypeDelete删除 更多数据");

            SMIChatData *data = [[SMIChatData alloc]init];
            [data deleteAllChatDataUser:@"小小"];
            page=0;
            [dataMutableArry removeAllObjects];
            [myTableView reloadData];
        }
            break;
        case DATAButtonTypeGetMoreFromServer:
        {
            NSLog(@"DATAButtonTypeGetMoreFromServer获取 更多数据");
            SMIChatData *chatData = [[SMIChatData alloc]init];
            NSArray *arry = [chatData predictChatDataFromUser:from to:to WithPage:page onePageNumber:10];
            if (!arry.count) return;
            page++;
            for (Message *messag in arry) {
                SMIChatMessageModel *dateModel = [[SMIChatMessageModel alloc]init];
                dateModel.date = messag.date;
                dateModel.fromCustId = messag.fromCustId;
                dateModel.toCustId = messag.toCustId;
                dateModel.userCustId = messag.userCustId;
                dateModel.locationType = messag.locationType;
                dateModel.type = messag.type;
                dateModel.message = messag.message;
                [dataMutableArry insertObject:dateModel atIndex:0];
            }

            [myTableView reloadData];
            //[myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: 0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }
            break;
        default:
            break;
    }

}


//递归调用
-(int)returnIntWith:(int)s
{
    
    if (s==0) {
        return 0;
    }
    
    if (s==1) {
        return 1;
    }
    
    if (s!=0 && s!=1) {
        return [self returnIntWith:s-1]+[self returnIntWith:s-2];
    }
    return 0;
}



-(NSString *)showTime:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:S";
    formatter.dateFormat = @"yyyyMMddHHmmssS";

    return [formatter stringFromDate:date];
}


-(BOOL)isShowOrHideCellTimeWithModel:(SMIChatMessageModel *)model lastModel:(SMIChatMessageModel *)lastModel
{
    if (lastModel == nil) {
        return NO;
    }
    
    //201507201119280
    NSString *localString = [self showTime:model.date];
    NSString *lastString = [self showTime:lastModel.date];
    
    //截取字段
    NSString *localYear = [localString substringWithRange:NSMakeRange(0,4)];
    NSString *lastYear = [lastString substringWithRange:NSMakeRange(0,4)];
    
    NSString *localMonth = [localString substringWithRange:NSMakeRange(4,2)];
    NSString *lastMonth = [lastString substringWithRange:NSMakeRange(4,2)];
    
    NSString *localDay = [localString substringWithRange:NSMakeRange(6,2)];
    NSString *lastDay = [lastString substringWithRange:NSMakeRange(6,2)];
    
    NSString *localHour = [localString substringWithRange:NSMakeRange(8,2)];
    NSString *lastHour = [lastString substringWithRange:NSMakeRange(8,2)];
    
    NSString *localMinute = [localString substringWithRange:NSMakeRange(10,2)];
    NSString *lastMinute = [lastString substringWithRange:NSMakeRange(10,2)];
    
    NSString *localSecond = [localString substringWithRange:NSMakeRange(12,2)];
    NSString *lastSecond = [lastString substringWithRange:NSMakeRange(12,2)];

    NSString *local_H_Second = [localString substringWithRange:NSMakeRange(13,1)];
    NSString *last_H_Second = [lastString substringWithRange:NSMakeRange(13,1)];

    if (![localYear isEqualToString:lastYear]) {
        return NO;
    }else{
        if (![localMonth isEqualToString:lastMonth]) {
            return NO;
        }else{
            if (![localDay isEqualToString:lastDay]) {
                return NO;
            }else{
                if (![localHour isEqualToString:lastHour]) {
                    return NO;
                }else{
                    if (![localMinute isEqualToString:lastMinute] ) {
                        return NO;
                    }else{
                        if (![localSecond isEqualToString:lastSecond]) {
                            return NO;
                        }else{
                            if (![local_H_Second isEqualToString:last_H_Second]) {
                                return NO;
                            }else{
                                return YES;
                            }
                        
                        }
                    
                    }
                
                }
            
            }
        
        }
    
    }
    
}

@end
