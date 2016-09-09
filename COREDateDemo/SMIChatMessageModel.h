//
//  SMIChatMessageModel.h
//  smi
//
//  Created by leo on 15/6/16.
//
//

#import <Foundation/Foundation.h>

@interface SMIChatMessageModel : NSObject


//这个表存聊天记录  不存头像，昵称    头像 昵称存另一个地方
@property(nonatomic,strong)NSString  *fromCustId;
@property(nonatomic,strong)NSString  *toCustId;
@property(nonatomic,strong)NSString  *userCustId;

@property(nonatomic,strong)NSDate    *date;
@property(nonatomic,strong)NSString  *message;
@property(nonatomic,strong)NSNumber  *type;
@property(nonatomic,strong)NSNumber  *locationType;





@end
