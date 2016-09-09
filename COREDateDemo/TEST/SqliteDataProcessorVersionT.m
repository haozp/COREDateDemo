//
//  SqliteDataProcessorVersionT.m
//  COREDateDemo
//
//  Created by leo on 16/7/21.
//  Copyright © 2016年 haozp. All rights reserved.
//  利用runtime 实现动态数据读取

#import "SqliteDataProcessorVersionT.h"
#import "Log.h"
#import <sqlite3.h>
#import <objc/runtime.h>


NSString *const SMIDBNAME_T    = @"LOG_DataProfessor_T.sqlite";
NSString *const SMITABLENAME_T = @"LOGINFO_T";
NSString *const timeDate_T     = @"timeDate";
NSString *const logString_T    = @"logString";
NSString *const tryCount_T     = @"tryCount";
NSString *const someString_T   = @"someString";

static char *dispatch = "mySqliteDispatch_T";

@implementation SqliteDataProcessorVersionT
{
    sqlite3 *db;
    dispatch_queue_t my_dispatch_queue;
}
static  SqliteDataProcessorVersionT *professorShareT;

+ (instancetype)shareSqliteDataProfessor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        professorShareT=[[SqliteDataProcessorVersionT alloc]init];
    });

    return professorShareT;
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
                                 SMITABLENAME_T,
                                 timeDate_T,
                                 logString_T,
                                 tryCount_T,
                                 someString_T];

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


-(BOOL)openDB{
    //获取数据库路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:SMIDBNAME_T];

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

    UInt64 dateTimeInter = [self dateToIntWithDate:dict[timeDate_T]];

    NSString *insertSql1= [NSString stringWithFormat:
                           @"INSERT INTO '%@' ('%@', '%@', '%@', '%@')\
                           VALUES ('%llu', '%@', '%@', '%@')",
                           SMITABLENAME_T, timeDate_T, logString_T, tryCount_T,someString_T,
                           dateTimeInter, dict[logString_T],dict[tryCount_T],dict[someString_T]];

    [self execSql:insertSql1];

}

- (void)selectSmilogWithTimeDate:(NSDate *)mytimeDate before:(BOOL)isBefore result:(void(^)(NSArray *dataArry)) result{

    UInt64 dateTimeInterval = [self dateToIntWithDate:mytimeDate];
    NSString *sqlQuery;

    if (isBefore) {
        sqlQuery = [NSString stringWithFormat:
                    @"SELECT * FROM %@ where %@ < %llu",SMITABLENAME_T,timeDate_T,dateTimeInterval];
    }else{
        sqlQuery = [NSString stringWithFormat:
                    @"SELECT * FROM %@ where %@ = %llu",SMITABLENAME_T,timeDate_T,dateTimeInterval];
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
            dispatch_sync(dispatch_get_main_queue(), ^{
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
                           SMITABLENAME_T,   tryCount_T,  tryCoun ,timeDate_T,  log.log_timeDate];
    [self execSql:updateSql];

}

- (void)deleteSmiLogBeforeTimeDate:(NSDate *)mytimeDate{

    UInt64 timeInt = [self dateToIntWithDate:mytimeDate];
    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where %@ < '%llu'",
                            SMITABLENAME_T, timeDate_T, timeInt];
    [self execSql:sdeleteSql];
}

- (void)deleteLogDataWithSmiLog:(Log *)log{

    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where %@ < '%llu'",
                            SMITABLENAME_T, timeDate_T, log.log_timeDate];
    [self execSql:sdeleteSql];

}

- (void)deleteSmiLogBetweenFromeDate:(NSDate *)fromeDate toDate:(NSDate *)toDate{
    UInt64 timeIntFrom = [self dateToIntWithDate:fromeDate];
    UInt64 timeIntTo = [self dateToIntWithDate:toDate];

    NSString *sdeleteSql = [NSString stringWithFormat:
                            @"delete from %@ where ( %@ < '%llu' and %@ > '%llu' )",
                            SMITABLENAME_T, timeDate_T, timeIntTo,timeDate_T, timeIntFrom];
    [self execSql:sdeleteSql];

}

#pragma mark-runtime--
//---------runtime-------
- (void)updateWithModel:(id)model{
    NSArray *properties = [self getIvarsOfClass:[model class]];
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    for (NSString *property in properties) {
        [info setObject:[model valueForKey:property] forKey:property];
    }
    [self updateWithModel:model info:info];
}

- (void)updateWithModel:(id)model info:(NSDictionary *)info
{
    NSString *tbName = NSStringFromClass([model class]);
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET ",tbName];
    for (NSString *key in info.allKeys) {
        NSString *desc = [NSString stringWithFormat:@"%@= '%@' ,",key,[info objectForKey:key]];
        sql = [sql stringByAppendingString:desc];
    }

    sql = [sql substringToIndex:sql.length-1];
    sql = [NSString stringWithFormat:@"%@ where _uniId = '%@'",sql,[model uniId]];
    [self execSql:sql];

}

//获取成员变量列表
- (NSArray *)getIvarsOfClass:(Class)cls{
    unsigned int outCount = 0;//指定类实例变量的数目
    NSMutableArray *data = [NSMutableArray array];
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (const Ivar *p=ivars; p < ivars+outCount; p++) {
        Ivar const ivar = *p;
        const char *name = ivar_getName(ivar);
        [data addObject:[NSString stringWithUTF8String:name]];
    }
    free(ivars);
    return data;
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
