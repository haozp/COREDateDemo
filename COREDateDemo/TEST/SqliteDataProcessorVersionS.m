//
//  SqliteDataProcessorVersionS.m
//  COREDateDemo
//
//  Created by leo on 16/7/21.
//  Copyright © 2016年 haozp. All rights reserved.
//  增加对多线程操作的支持

#import "SqliteDataProcessorVersionS.h"
#import <sqlite3.h>
#import "Log.h"

NSString *const SMIDBNAME_S    = @"LOG_DataProfessor_S.sqlite";
NSString *const SMITABLENAME_S = @"LOGINFO_S";
NSString *const timeDate_S     = @"timeDate";
NSString *const logString_S    = @"logString";
NSString *const tryCount_S     = @"tryCount";
NSString *const someString_S   = @"someString";

static char *dispatch = "mySqliteDispatch_S";


@implementation SqliteDataProcessorVersionS
{
    sqlite3 *db;
    dispatch_queue_t my_dispatch_queue;
}

static  SqliteDataProcessorVersionS *professorShareS;

+ (instancetype)shareSqliteDataProfessor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        professorShareS=[[SqliteDataProcessorVersionS alloc]init];
    });

    return professorShareS;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        my_dispatch_queue = dispatch_queue_create(dispatch, DISPATCH_QUEUE_SERIAL);
        [self createDB];
    }
    return self;
}

#pragma mark-  Data

- (void)createDB{
    //sql 语句
    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' \
                                 ('%@' INTEGER,\
                                 '%@' TEXT,\
                                 '%@' INTEGER,\
                                 '%@' TEXT)",
                                 SMITABLENAME_S,
                                 timeDate_S,
                                 logString_S,
                                 tryCount_S,
                                 someString_S];

    [self execSql:sqlCreateTable];
}

-(void)execSql:(NSString *)sql
{
    __block typeof(self) weakSelf = self;
    dispatch_async(my_dispatch_queue, ^{
        [weakSelf openDB];
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSLog(@"数据库操作数据失败!");
            sqlite3_close(db);

        }else{
            NSLog(@"%@",sql);
        }
        [weakSelf closeDB];
    });

}


-(BOOL) openDB{
    //获取数据库路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:SMIDBNAME_S];

    //如果数据库存在，则用sqlite3_open直接打开（不要担心，如果数据库不存在sqlite3_open会自动创建）
    //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采用可移植的C(而不是
    //Objective-C)编写的，它不知道什么是NSString.
    if (sqlite3_open([database_path UTF8String], &db) == SQLITE_OK) {
        return YES;
    }else{
        NSLog(@"数据库打开失败");
        sqlite3_close(db);
        return NO;
    }
}

- (void)closeDB
{
    if (NULL != db) {
        sqlite3_close(db);
    }
    db = NULL;
}

//--------------
-(void) insertData:(NSDictionary *)dict{

    UInt64 dateTimeInter = [self dateToIntWithDate:dict[timeDate_S]];

    NSString *insertSql1= [NSString stringWithFormat:
                           @"INSERT INTO '%@' ('%@', '%@', '%@', '%@')\
                           VALUES ('%llu', '%@', '%@', '%@')",
                           SMITABLENAME_S, timeDate_S, logString_S, tryCount_S,someString_S,
                           dateTimeInter, dict[logString_S],dict[tryCount_S],dict[someString_S]];

    [self execSql:insertSql1];

}

- (void)selectSmilogWithTimeDate:(NSDate *)mytimeDate before:(BOOL)isBefore result:(void(^)(NSArray *dataArry)) result{

    UInt64 dateTimeInterval = [self dateToIntWithDate:mytimeDate];
    NSString *sqlQuery;

    if (isBefore) {
        sqlQuery = [NSString stringWithFormat:
                    @"SELECT * FROM %@ where %@ < %llu",SMITABLENAME_S,timeDate_S,dateTimeInterval];
    }else{
        sqlQuery = [NSString stringWithFormat:
                    @"SELECT * FROM %@ where %@ = %llu",SMITABLENAME_S,timeDate_S,dateTimeInterval];
    }


    __block typeof(self) weakSelf = self;
    dispatch_async(my_dispatch_queue, ^{
        [weakSelf openDB];

        sqlite3_stmt * statement;
        NSMutableArray *dataArry = [NSMutableArray array];

        if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {

            while (sqlite3_step(statement) == SQLITE_ROW) {

                Log *log = [[Log alloc]init];

                UInt64 timeInt = sqlite3_column_int64(statement, 0);
                log.log_timeDate = timeInt;

                char *logS = (char*)sqlite3_column_text(statement, 1);
                NSString *logStr = [[NSString alloc]initWithUTF8String:logS];
                log.log_logString = logStr;

                int tryStr = sqlite3_column_int(statement, 2);
                log.log_tryCount = tryStr;
                char *someS = (char*)sqlite3_column_text(statement, 3);
                NSString *someStr = [[NSString alloc]initWithUTF8String:someS];
                log.log_someString = someStr;
                
                [dataArry addObject:log];
            }

            //感觉这里这三种方式 没有区别
            //            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //                result(dataArry);
            //            });

//            dispatch_async(dispatch_get_main_queue(), ^{
//                result(dataArry);
//            });

                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            result(dataArry);
                        });
        }
        [weakSelf closeDB];
    });
}

- (void)changeSmilog:(Log *)log{

    int tryCoun = log.log_tryCount+1;

    NSString *updateSql = [NSString stringWithFormat:
                           @"UPDATE \"%@\" SET \"%@\" = \"%d\" WHERE \"%@\" = \"%llu\"",
                           SMITABLENAME_S,   tryCount_S,  tryCoun ,timeDate_S,  log.log_timeDate];
    [self execSql:updateSql];

}

- (void)deleteSmiLogBeforeTimeDate:(NSDate *)mytimeDate{

    UInt64 timeInt = [self dateToIntWithDate:mytimeDate];
    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where %@ < '%llu'",
                            SMITABLENAME_S, timeDate_S, timeInt];
    [self execSql:sdeleteSql];
}

- (void)deleteLogDataWithSmiLog:(Log *)log{

    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where %@ < '%llu'",
                            SMITABLENAME_S, timeDate_S, log.log_timeDate];
    [self execSql:sdeleteSql];

}

- (void)deleteSmiLogBetweenFromeDate:(NSDate *)fromeDate toDate:(NSDate *)toDate{
    UInt64 timeIntFrom = [self dateToIntWithDate:fromeDate];
    UInt64 timeIntTo = [self dateToIntWithDate:toDate];

    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where ( %@ < '%llu' and %@ > '%llu' )",
                            SMITABLENAME_S, timeDate_S, timeIntTo,timeDate_S, timeIntFrom];
    [self execSql:sdeleteSql];

}


//
- (UInt64)dateToIntWithDate:(NSDate *)date
{
    UInt64 recordTime = [date timeIntervalSince1970]*1000;
    return recordTime;
}

- (NSDate *)intToDateWith:(UInt64) intDate
{
    return [NSDate dateWithTimeIntervalSince1970:intDate/1000];
}


@end
