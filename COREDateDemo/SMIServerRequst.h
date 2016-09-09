//
//  SMIServerRequst.h
//  smi
//
//  Created by leo on 15/6/13.
//
//

#import <Foundation/Foundation.h>

@protocol SMIServerRequstDelegate <NSObject>
@optional
-(void)serverRequstSuccess:(NSDictionary *)dict codeString:(NSString *)code;
-(void)serverRequstFail:(NSError *)error codeString:(NSString *)code;
@end

@interface SMIServerRequst : NSObject
@property(nonatomic,retain)id<SMIServerRequstDelegate>delegate;

//从服务器请求数据
-(void )getDataFromServerWithServerPath:(NSString *)serverPath dataDict:(NSDictionary *)dict codeString:(NSString *)code;

//上传 数据-->服务器
-(void)upLoadDataToServerWithServerPath:(NSString *)serverPath dataDict:(NSDictionary *)dict codeString:(NSString *)code;

+(void)requestPOSTWithChildUrlStr:(NSString*)childUrl andParameters:(NSDictionary *)parameters response:(void (^)(NSError *error, NSDictionary *result))response;

+ (void)requestWithParameters:(NSDictionary *)parameters response:(void (^)(NSError *error, NSDictionary *result))response;


//上传 图片-->服务器
//-(void)upLoadDataToServerWithServerPath:(NSString *)serverPath dataDict:(NSDictionary *)dict image:(UIImage *) image codeString:(NSString *)code;


@end
