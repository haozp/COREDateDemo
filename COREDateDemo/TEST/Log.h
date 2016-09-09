//
//  Log.h
//  COREDateDemo
//
//  Created by leo on 16/7/21.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteDataProcessorVersionT.h"

@interface Log : NSObject<SqliteManagerDelegate>

@property (nonatomic,assign) UInt64      log_timeDate;
@property (nonatomic,strong) NSString   *log_logString;
@property (nonatomic,assign) int         log_tryCount;
@property (nonatomic,strong) NSString   *log_someString;


@property (nonatomic, copy) NSString *uniId;

@end
