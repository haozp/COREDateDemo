//
//  Entity+CoreDataProperties.h
//  COREDateDemo
//
//  Created by leo on 16/7/7.
//  Copyright © 2016年 haozp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *logString;
@property (nullable, nonatomic, retain) NSDate *timeString;

@end

NS_ASSUME_NONNULL_END
