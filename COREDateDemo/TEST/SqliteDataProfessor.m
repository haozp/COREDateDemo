//
//  SqliteDataProfessor.m
//  COREDateDemo
//
//  Created by leo on 16/7/20.
//  Copyright © 2016年 haozp. All rights reserved.
//  对于----多线程操数据库会出问题--

#import "SqliteDataProfessor.h"
#import "Log.h"

NSString *const SMIDBNAME    = @"SMILOG_DataProfessor.sqlite";
NSString *const SMITABLENAME = @"SMILOGINFO";
NSString *const timeDate     = @"timeDate";
NSString *const logString    = @"logString";
NSString *const tryCount     = @"tryCount";
NSString *const someString   = @"someString";

@implementation SqliteDataProfessor

static SqliteDataProfessor *professorShare;

+ (instancetype)shareSqliteDataProfessor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        professorShare=[[SqliteDataProfessor alloc]init];
    });

    return professorShare;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
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
                    SMITABLENAME,
                            timeDate,
                            logString,
                            tryCount,
                            someString];

    [self execSql:sqlCreateTable];
}

-(BOOL)execSql:(NSString *)sql
{
    if ([self openDB]) {
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSLog(@"数据库操作数据失败!");
            sqlite3_close(db);

            return NO;
        }else{
            NSLog(@"%@",sql);
            sqlite3_close(db);
            return YES;
        }
    }
    return NO;
}


-(BOOL) openDB{
    //获取数据库路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:SMIDBNAME];
    NSLog(@"%@",database_path);


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

//--------------
-(BOOL) insertData:(NSDictionary *)dict{

    UInt64 dateTimeInter = [self dateToIntWithDate:dict[timeDate]];

    NSString *insertSql1= [NSString stringWithFormat:
                           @"INSERT INTO '%@' ('%@', '%@', '%@', '%@')\
                                       VALUES ('%llu', '%@', '%@', '%@')",
                    SMITABLENAME, timeDate, logString, tryCount,someString,
                    dateTimeInter, dict[logString],dict[tryCount],dict[someString]];

   return  [self execSql:insertSql1];

}

- (NSArray *)selectSmilogWithTimeDate:(NSDate *)mytimeDate before:(BOOL)isBefore{

    UInt64 dateTimeInterval = [self dateToIntWithDate:mytimeDate];
    [self openDB];

    NSString *sqlQuery;

    if (isBefore) {
        sqlQuery = [NSString stringWithFormat:
                    @"SELECT * FROM %@ where %@ < %llu",SMITABLENAME,timeDate,dateTimeInterval];
    }else{
        sqlQuery = [NSString stringWithFormat:
                    @"SELECT * FROM %@ where %@ = %llu",SMITABLENAME,timeDate,dateTimeInterval];
    }

    sqlite3_stmt * statement;

    NSMutableArray *dataArry = [NSMutableArray array];

    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {

        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值


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
    }else{
        NSLog(@"select error:%@",sqlQuery);

    }
    sqlite3_close(db);

    return dataArry;
}

- (void)changeSmilog:(Log *)log{

    int tryCoun = log.log_tryCount+1;

        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE \"%@\" SET \"%@\" = \"%d\" WHERE \"%@\" = \"%llu\"",
                               SMITABLENAME,   tryCount,  tryCoun ,timeDate,  log.log_timeDate];
        [self execSql:updateSql];

}

//这样 操作数据不行 会出问题
- (void)changeSmilogS:(NSArray *)logs;
{

    NSString *updateSql = [NSString stringWithFormat:@"UPDATE \"%@\" SET ",SMITABLENAME];
    NSString *valueS = @"";
    NSString *whereS = @"";
    for (Log *log in logs) {

        int tryCoun = log.log_tryCount+1;

      NSString *des_valueS = [NSString stringWithFormat:@" \"%@\" = \"%d\" ,",tryCount,tryCoun];
        valueS = [valueS stringByAppendingString:des_valueS];

      NSString *des_whereS = [NSString stringWithFormat:@" \"%@\" = \"%llu\" ,",timeDate,log.log_timeDate];
        whereS = [whereS stringByAppendingString:des_whereS];


//      NSString *desc = [NSString stringWithFormat:
//                               @" \"%@\" = \"%d\" WHERE \"%@\" = \"%llu\"  and",
//                                  tryCount,  tryCoun ,timeDate,  log.log_timeDate];
//        updateSql = [updateSql stringByAppendingString:desc];

    }

    valueS = [valueS substringToIndex:valueS.length -1];

    whereS = [whereS substringToIndex:whereS.length -1];
    NSString *hh = [NSString stringWithFormat:@"%@ %@ WHERE %@",updateSql,valueS,whereS];

    [self execSql:hh];

}


- (void)deleteSmiLogBeforeTimeDate:(NSDate *)mytimeDate{

    UInt64 timeInt = [self dateToIntWithDate:mytimeDate];
    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where %@ < '%llu'",
                            SMITABLENAME, timeDate, timeInt];
    [self execSql:sdeleteSql];
}

- (void)deleteLogDataWithSmiLog:(Log *)log{

    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where %@ < '%llu'",
                            SMITABLENAME, timeDate, log.log_timeDate];
    [self execSql:sdeleteSql];

}

- (void)deleteLogDataWithSmiLogS:(NSArray *)logs{

    NSString *sdeleteSql = [NSString stringWithFormat:@" delete from %@ where ",SMITABLENAME];

    for (Log *log in logs) {
        NSString *desc  = [NSString stringWithFormat:@" %@ = %llu or",timeDate, log.log_timeDate];
        sdeleteSql = [sdeleteSql stringByAppendingString:desc];
    }

    sdeleteSql = [sdeleteSql substringToIndex:sdeleteSql.length -2];
    [self execSql:sdeleteSql];
    
}


- (void)deleteSmiLogBetweenFromeDate:(NSDate *)fromeDate toDate:(NSDate *)toDate{
    UInt64 timeIntFrom = [self dateToIntWithDate:fromeDate];
    UInt64 timeIntTo = [self dateToIntWithDate:toDate];

    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where ( %@ < '%llu' and %@ > '%llu' )",
                            SMITABLENAME, timeDate, timeIntTo,timeDate, timeIntFrom];
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
