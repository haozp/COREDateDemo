//
//  SMIServerRequst.m
//  smi
//
//  Created by leo on 15/6/13.
//
//

#import "SMIServerRequst.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#define kBaseURLStr     @"http://192.168.68.2:9527/api"

//#define apiRootUrl @"http://192.168.68.23:8081/smiweb/"//开发环境

//#define apiRootUrl @"http://testmall.xingmeihui.com/smiweb/"//测试环境
#define apiRootUrl @"http://xmlife.smi170.com:8080/"//生产环境


@implementation SMIServerRequst

/** 服务器接口返回字段 errorCode 说明
 * 结果码 0：成功  1：服务器内部错误  2：用户未登陆 3：用户资料未补全 4：请求错误
 */


/**
codeString说明:
使用接口URL 末段  作为codeString值，作为区分不同请求
例如：请求获取城市列表Api  URL= ..../common/cities
codeString=@"/common/cities";
添加评论Api  URL =.../comment/add
codeString=@"/comment/add";
*/
-(void )getDataFromServerWithServerPath:(NSString *)serverPath dataDict:(NSDictionary *)dict codeString:(NSString *)code
{
/*
    //cas restful接口地址
    String server = "http://192.168.22.169:8080/cas/v1/tickets";
    //用户名
    String username = "13925219243";
    //密码
    String password = "cs6562348";
    //要访问的接口地址
    String service ="http://192.168.22.169:8081/smilife_web/app/activity_index.htm";

    //生成TGT
    String tgt = getTicketGrantingTicket(server,username,password);
    System.out.println("tgt="+tgt);

    //生成ticket
    String ticket=getServiceTicket(server,tgt,service);

    //发送post请求
    System.out.println("返回报文："+HttpClientPost.postTest(service,ticket,null));
*/

    //http://yun.baidu.com/share/home?uk=296043451&view=share#category/type=9"
   // NSString *url = @"http://yun.baidu.com/share/home?uk=296043451&view=share#category/type=9";
   // NSString *url = @"http://yun.baidu.com";
    NSString *url = @"http://www.baidu.com";


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *ss = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];




//        NSArray *arry = [ss componentsSeparatedByString:@"/"];
//        NSString *tgt = arry[15];
//        NSString *sss = [tgt componentsSeparatedByString:@"cas"][0];
//        NSString *TGT = [sss stringByAppendingString:@"cas"];
//        [self getTciket:TGT];
//
        if ([self.delegate respondsToSelector:@selector(serverRequstSuccess:codeString:)]) {
//            NSString* ss= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

            NSDictionary *dictSS = @{
                                     @"ss":ss
                                     };
            [self.delegate serverRequstSuccess:dictSS codeString:nil];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"ERROR===%@",error);
        if ([self.delegate respondsToSelector:@selector(serverRequstFail:codeString:)]) {
            [self.delegate serverRequstFail:error codeString:code];
        }

    }];
    
}

-(void)upLoadDataToServerWithServerPath:(NSString *)serverPath dataDict:(NSDictionary *)dict codeString:(NSString *)code
{
    // NSString *url = [kBaseURLStr stringByAppendingString:serverPath];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    NSString* url = @"http://shenjingstudio.com/ucard/CSNews.php";
    NSDictionary* postDict = @{@"type":@"dnews",@"page":@"1"};
    
    [manager POST:url parameters:postDict success:^(AFHTTPRequestOperation* operation,id response){
        
        if ([self.delegate respondsToSelector:@selector(serverRequstSuccess:codeString:)]) {
            [self.delegate serverRequstSuccess:response codeString:code];
        }

    
    } failure:^(AFHTTPRequestOperation* operation,NSError* error){
        NSLog(@"%@",error);
       
        if ([self.delegate respondsToSelector:@selector(serverRequstFail:codeString:)]) {
            [self.delegate serverRequstFail:error codeString:code];
        }

    }];

}

+(void)requestPOSTWithChildUrlStr:(NSString*)childUrl andParameters:(NSDictionary *)parameters response:(void (^)(NSError *error, NSDictionary *result))response
{

    NSString* postUrl=[NSString stringWithFormat:@"%@%@",apiRootUrl,childUrl];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.requestSerializer
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:postUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary* dic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//转换成NSdictionary
        NSLog(@"POST----parameters:\n%@\nresult:\n%@---------------%@",parameters,operation.responseString,dic);
        response(nil,dic);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"request error %@",[error localizedDescription]);
        response(error,nil);
    }];
}

#define AppVersionString [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]    // @"1.2.0"

#define SC			[NSString stringWithFormat:@"iphone_xingmei_%@", AppVersionString]//@"iphone_pl_1.2.0"												// 客户端类型
#define XMSECRET @"59bb0e89e6576aa95f7e8efc03f81b80"								// 接口secret
#define XMKEY	@"12131423"
#define JsonAddress @"http://api.ixingmei.com/Api/Page/index/format_type/json/"

+ (void)requestWithParameters:(NSDictionary *)parameters response:(void (^)(NSError *error, NSDictionary *result))response
{
    [self afn];
    NSMutableDictionary *p = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [p setObject:XMKEY forKey:@"xm_key"];
    [p setObject:XMSECRET forKey:@"xm_secret"];
    [p setObject:SC forKey:@"sc"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:JsonAddress parameters:p success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"parameters:\n%@\nresult:\n%@---------------%@",parameters,operation.responseString,p);
        response(nil,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"request error %@",[error localizedDescription]);
        response(error,nil);
    }];

}

+(void)afn
{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];

    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            default:
                break;
        }
    }];

    [manger startMonitoring];
    
}



/*
-(void)upLoadDataToServerWithServerPath:(NSString *)serverPath dataDict:(NSDictionary *)dict image:(UIImage *) fileImage codeString:(NSString *)code
{

    NSString *url = [kBaseURLStr stringByAppendingString:serverPath];//[NSString stringWithFormat:@"http://192.168.22.91:8080/api/%@",serverPath];////
    
    NSDictionary *param = dict;

    UIImage *image = fileImage;
    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    Byte pngHead[] = {0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a};//文件头数据
    int cmpResult = memcmp(imgData.bytes, pngHead, 8);//判断是否为png格式
    
    NSString *imageType,*mimeType;
    if (cmpResult == 0) {
        imageType = @".png";
        mimeType = @"image/png";
    }else {
        imageType = @".jpg";
        mimeType = @"image/jpg";
    }
    
    NSLog(@"%@",url);
    
    NSString *fileName = [NSString stringWithFormat:@"%@%@", str,imageType];//保存的文件名
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
   [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
     
       [formData appendPartWithFileData:imgData name:@"pic" fileName:fileName mimeType:mimeType];

    } success:^(AFHTTPRequestOperation *operation, id response) {
        if ([self.delegate respondsToSelector:@selector(serverRequstFail:codeString:)]) {
            [self.delegate serverRequstSuccess:response codeString:code];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(serverRequstFail:codeString:)]) {
            [self.delegate serverRequstFail:error codeString:code];
        }
    }];

}
 
 */


//生成ticket
-(void)getTciket:(NSString *)tgt
{

    NSString *url = @"http://192.168.22.169:8080/cas/v1/tickets";

    NSDictionary *dict = @{
             @"tgt":tgt,
             @"service":@"http://192.168.22.169:8081/smilife_web/app/activity_index.htm"
             };

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"ticket==%@",responseObject);
        if ([self.delegate respondsToSelector:@selector(serverRequstSuccess:codeString:)]) {
            NSDictionary* dict= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

            NSString *Str = [dict objectForKey:@"errorCode"];

            NSString *Strs = [dict objectForKey:@"errorMsg"];

        }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"ERROR===%@",error);

    }];



}






@end
