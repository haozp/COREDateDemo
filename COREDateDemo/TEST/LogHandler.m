//
//  LogHandler.m
//  COREDateDemo
//
//  Created by leo on 16/7/7.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "LogHandler.h"

@implementation LogHandler

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


//数据 入库
-(BOOL)saveLogDataToCoreData:(NSDictionary *)dict;
{

    NSManagedObjectContext *context =
    [self managedObjectContext];

    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Entity"
                  inManagedObjectContext:context];

    [newContact setValue:[dict objectForKey:@"timeString"] forKey:@"timeString"];
    [newContact setValue:[dict objectForKey:@"logString"] forKey:@"logString"];

    NSError *error;
    BOOL isSuccess =[context save:&error];

    return isSuccess;
}


-(NSArray *)preWithPredict:(NSPredicate *)predicate
{
    NSManagedObjectContext *context =
    [self managedObjectContext];

    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Entity"
                inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];



    [request setPredicate:predicate];

    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    return objects;

}

//查询数据
-(NSArray *)predictLogDataWithTime:(NSNumber *)timeNumber;
{

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeString=%@",timeNumber];

    return [self preWithPredict:predicate];
}

//分页查询
-(NSArray *)predictLogDataWithTime:(NSDate *)timeString WithPage:(int )page pageNumber:(int)pageNumber;
{

    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSManagedObjectContext *context =
    [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];
    [request setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeString < %@",timeString];

    [request setPredicate:predicate];

    int oneNumber = pageNumber;
    int pageNu = page;

    [request setFetchLimit:oneNumber];

    [request setFetchOffset:oneNumber * pageNu];
    NSError *error = nil;
    NSArray *rssTemp = [context executeFetchRequest:request error:&error];
    
    return rssTemp;
    
}


-(void)deleteLogDataWithTimeNumber:(NSDate *)timeNumber;
{

    NSManagedObjectContext *context =
    [self managedObjectContext];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeString = %@",timeNumber];

    [request setPredicate:predicate];

    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];

    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }

}


-(void)deleteLogDataBeforeTheDateWithTimeNumber:(NSDate *)timeString{

    NSManagedObjectContext *context =
    [self managedObjectContext];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeString < %@",timeString];

    [request setPredicate:predicate];

    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];

    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }


}


-(void)deleteLogDataWithTimeNumberFrome:(NSDate *)timeStringFrome timeNumberTo:(NSDate *)timeStringTo;
{

    NSManagedObjectContext *context =
    [self managedObjectContext];

    NSEntityDescription *description = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"( timeString > %@ ) and ( timeString < %@ )",timeStringFrome,timeStringTo];
    [request setPredicate:predicate];

    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];

    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }

}




//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LogModelData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self myDocumentsDirectory] URLByAppendingPathComponent:@"LogModelData.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Application's Documents directory
- (NSURL *)myDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
