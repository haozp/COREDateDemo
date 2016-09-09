//
//  SqliteTestViewController.m
//  COREDateDemo
//
//  Created by leo on 16/7/20.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "SqliteTestViewController.h"
#import "SqliteDataProfessor.h"
#import "Log.h"

@interface SqliteTestViewController ()

@end

@implementation SqliteTestViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SqliteDataProfessor *pro = [SqliteDataProfessor shareSqliteDataProfessor];
    NSDictionary *dict = @{
                           @"timeDate":[NSDate date],
                           @"logString":@"logStringffefeffefefefegtgtgtt",
                           @"tryCount":@"",
                           };

    [pro insertData:dict];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    SqliteDataProfessor *pro = [SqliteDataProfessor shareSqliteDataProfessor];
    NSDictionary *dict = @{
                           @"timeDate":[NSDate date],
                           @"logString":@"logStringffefeffefefefegtgtgtt",
                           @"tryCount":@"",
                           };

    [pro insertData:dict];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    SqliteDataProfessor *pro = [SqliteDataProfessor shareSqliteDataProfessor];

    for (int i=0; i<12; i++) {

        NSDictionary *dict = @{
                               @"timeDate":[NSDate date],
                               @"logString":@"logStringffefeffefefefegtgtgtt",
                               @"tryCount":@"",
                               };

        [pro insertData:dict];
    }

   NSArray *logs = [pro selectSmilogWithTimeDate:[NSDate date] before:YES];

    for ( Log *log in logs) {

        NSLog(@"before==%d",log.log_tryCount);
        
    }

    NSLog(@"before==%lu",(unsigned long)logs.count);

    [pro changeSmilogS:logs];
    NSArray *logsBB = [pro selectSmilogWithTimeDate:[NSDate date] before:YES];
    for ( Log *log in logsBB) {

        NSLog(@"after-change==%d",log.log_tryCount);

    }

    [pro deleteLogDataWithSmiLogS:logs];
    NSArray *logsSS = [pro selectSmilogWithTimeDate:[NSDate date] before:YES];
    NSLog(@"after==%lu",(unsigned long)logsSS.count);




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
