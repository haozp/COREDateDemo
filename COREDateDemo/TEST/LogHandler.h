//
//  LogHandler.h
//  COREDateDemo
//
//  Created by leo on 16/7/7.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LogHandler : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//------------数据处理---------
//入库
-(BOOL)saveLogDataToCoreData:(NSDictionary *)dict;

//查询某条日志数据
-(NSArray *)predictLogDataWithTime:(NSDate *)timeString;
//分页查询  小于某个时间点timeNumber
-(NSArray *)predictLogDataWithTime:(NSDate *)timeString WithPage:(int )page pageNumber:(int)pageNumber;


//删除某条日志
-(void)deleteLogDataWithTimeNumber:(NSDate *)timeString;
-(void)deleteLogDataBeforeTheDateWithTimeNumber:(NSDate *)timeString;

//删除 两个时间点之间的日志
-(void)deleteLogDataWithTimeNumberFrome:(NSDate *)timeStringFrome timeNumberTo:(NSDate *)timeStringTo;

@end
