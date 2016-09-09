//
//  SMIChatData.h
//  smi
//
//  Created by leo on 15/6/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SMIChatData : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



//消息 入库
-(BOOL)saveChatDataToCoreData:(NSDictionary *)dict;
//查询数据
-(NSArray *)predictChatDataFromUser:(NSString *)from to:(NSString *)to;
//查询数据 分页查询
-(NSArray *)predictChatDataFromUser:(NSString *)from to:(NSString *)to WithPage:(int )page onePageNumber:(int)onePageNumber;

//删除   与某个人的聊天的数据
-(void)deleteChatDataFrom:(NSString *)from to:(NSString *)to;
//删除  “登陆用户” 的聊天数据
-(void)deleteAllChatDataUser:(NSString *)user;


@end
