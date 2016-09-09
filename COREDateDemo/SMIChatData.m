//
//  SMIChatData.m
//  smi
//
//  Created by leo on 15/6/15.
//
//

#import "SMIChatData.h"


@implementation SMIChatData
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;




//数据 入库
-(BOOL)saveChatDataToCoreData:(NSDictionary *)dict
{

    NSManagedObjectContext *context =
    [self managedObjectContext];
    
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Message"
                  inManagedObjectContext:context];
    
    [newContact setValue:[dict objectForKey:@"fromCustId"] forKey:@"fromCustId"];
    [newContact setValue:[dict objectForKey:@"toCustId"] forKey:@"toCustId"];
    [newContact setValue:[dict objectForKey:@"type"] forKey:@"type"];
    [newContact setValue:[dict objectForKey:@"message"] forKey:@"message"];
    [newContact setValue:[dict objectForKey:@"userCustId"] forKey:@"userCustId"];
    [newContact setValue:[dict objectForKey:@"date"] forKey:@"date"];
    [newContact setValue:[dict objectForKey:@"locationType"] forKey:@"locationType"];

    
    
    
    
    NSError *error;
    BOOL isSuccess =[context save:&error];

    return isSuccess;
}

//查询数据
-(NSArray *)predictChatDataFromUser:(NSString *)from to:(NSString *)to
{
    
    NSManagedObjectContext *context =
    [self managedObjectContext];

    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Message"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fromCustId = %@ and toCustId = %@ and userCustId = %@) or (fromCustId = %@ and toCustId = %@ and userCustId = %@) ",from,to,from,to,from,from];

    
    [request setPredicate:predicate];
    
   // NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    for (int i = 0; i<objects.count; i++) {
//        Message *message = objects[i];
//        NSLog(@"%@==%@==%@==%@",message.from,message.to,message.time,message.message);
        
    }

    
    
    if ([objects count] == 0) {

    } else {
       
    }

    return objects;
}

//删除   与某个人的聊天的数据
-(void)deleteChatDataFrom:(NSString *)from to:(NSString *)to
{

    
    NSManagedObjectContext *context =
    [self managedObjectContext];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fromCustId = %@ and toCustId = %@ and userCustId = %@ )or(fromCustId = %@ and toCustId = %@ and userCustId = %@) ",from,to,from,to,from,from];
    
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


//删除  “登陆用户” 的聊天数据
-(void)deleteAllChatDataUser:(NSString *)user
{

    NSManagedObjectContext *context =
    [self managedObjectContext];

    NSEntityDescription *description = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userCustId = %@ ",user];
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

-(NSArray *)predictChatDataFromUser:(NSString *)from to:(NSString *)to WithPage:(int )page onePageNumber:(int)onePageNumber
{
    
    int oneNumber = onePageNumber;
    int pageNumber = page;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:[self managedObjectContext]];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fromCustId = %@ and toCustId = %@ and userCustId = %@ )or(fromCustId = %@ and toCustId = %@ and userCustId = %@) ",from,to,from,to,from,from];
    
    [request setPredicate:predicate];

    [request setFetchLimit:oneNumber];
    
    [request setFetchOffset:oneNumber * pageNumber];
    NSError *error = nil;
    NSArray *rssTemp = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    return rssTemp;

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
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyCoreData.sqlite"];
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
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
