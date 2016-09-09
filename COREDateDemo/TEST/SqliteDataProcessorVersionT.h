//
//  SqliteDataProcessorVersionT.h
//  COREDateDemo
//
//  Created by leo on 16/7/21.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SqliteManagerDelegate <NSObject>

@required

@property (nonatomic, copy) NSString *uniId;

@end


@class Log;
@interface SqliteDataProcessorVersionT : NSObject

+ (instancetype)shareSqliteDataProfessor;
//增
- (void) insertData:(NSDictionary *)dict;
//查 isBefore yes 查询多有  no 差一条对应的mytimeDate
- (void)selectSmilogWithTimeDate:(NSDate *)mytimeDate before:(BOOL)isBefore result:(void(^)(NSArray *dataArry)) result;
//改
- (void)changeSmilog:(Log *)log;
//删
- (void)deleteSmiLogBeforeTimeDate:(NSDate *)mytimeDate;
- (void)deleteLogDataWithSmiLog:(Log *)log;
- (void)deleteSmiLogBetweenFromeDate:(NSDate *)fromeDate toDate:(NSDate *)toDate;


//---------runtime-------
- (void)updateWithModel:(id)model;


@end
