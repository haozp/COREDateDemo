//
//  Message.h
//  COREDateDemo
//
//  Created by leo on 15/7/17.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * fromCustId;
@property (nonatomic, retain) NSString * toCustId;
@property (nonatomic, retain) NSString * userCustId;
@property (nonatomic, retain) NSDate   * date;
@property (nonatomic, retain) NSNumber * locationType;
@property (nonatomic, retain) NSNumber * type;

@end
