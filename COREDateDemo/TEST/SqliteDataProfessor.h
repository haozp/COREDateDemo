//
//  SqliteDataProfessor.h
//  COREDateDemo
//
//  Created by leo on 16/7/20.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class Log;
@interface SqliteDataProfessor : NSObject
{
    sqlite3 *db;
}

+ (instancetype)shareSqliteDataProfessor;
//增
- (BOOL) insertData:(NSDictionary *)dict;
//查 isBefore yes 查询多有  no 差一条对应的mytimeDate
- (NSArray *)selectSmilogWithTimeDate:(NSDate *)mytimeDate before:(BOOL)isBefore;
//改
- (void)changeSmilog:(Log *)log;
- (void)changeSmilogS:(NSArray *)logs;

//删
- (void)deleteSmiLogBeforeTimeDate:(NSDate *)mytimeDate;
- (void)deleteLogDataWithSmiLog:(Log *)log;
- (void)deleteLogDataWithSmiLogS:(NSArray *)logs;
- (void)deleteSmiLogBetweenFromeDate:(NSDate *)fromeDate toDate:(NSDate *)toDate;


@end
