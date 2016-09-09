//
//  IPoneInformation.m
//  COREDateDemo
//
//  Created by leo on 16/7/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "IPoneInformation.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#include <arpa/inet.h>
#include <netdb.h>

#include <net/if.h>

#include <ifaddrs.h>
#import <dlfcn.h>
//#import "wwanconnect.h//frome apple 你可能没有哦

#import <SystemConfiguration/SystemConfiguration.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "CoreTelephony/CTCarrier.h"


//数据
#import "LogHandler.h"
#import "Entity.h"


@implementation IPoneInformation

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"去你妈的混蛋=====+++");
}

- (NSString *)GetNetWorkType
{
    NSString *strNetworkType = @"";

    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;

    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;

    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;

    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return strNetworkType;
    }


    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        // if target host is reachable and no connection is required
        // then we'll assume (for now) that your on Wi-Fi
        strNetworkType = @"WIFI";
    }

    if (
        ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0
        )
    {
        // ... and the connection is on-demand (or on-traffic) if the
        // calling application is using the CFSocketStream or higher APIs
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            // ... and no [user] intervention is needed
            strNetworkType = @"WIFI";
        }
    }

    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;

            if (currentRadioAccessTechnology)
            {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                {
                    strNetworkType =  @"4G";
                }
                else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                {
                    strNetworkType =  @"2G";
                }
                else
                {
                    strNetworkType =  @"3G";
                }
            }
        }
        else
        {
            if((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable)
            {
                if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection)
                {
                    if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired)
                    {
                        strNetworkType = @"2G";
                    }
                    else
                    {
                        strNetworkType = @"3G";
                    }
                }
            }
        }
    }


    if ([strNetworkType isEqualToString:@""]) {
        strNetworkType = @"WWAN";
    }


    return strNetworkType;
}



-(void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self performSelectorInBackground:@selector(getSomeThing) withObject:nil];

}

- (void)getSomeThing{
    NSString  *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",
                            [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],
                            [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],
                            [[UIDevice currentDevice] model],
                            [[UIDevice currentDevice] systemVersion],
                            [[UIScreen mainScreen] scale]];

    NSLog(@"%@",userAgent);

    NSString *strName = [[UIDevice currentDevice] name];
    NSLog(@"设备名称：%@", strName);//e.g. "My iPhone"

    //NSString *strId = [[UIDevice currentDevice] uniqueIdentifier];
    // NSLog(@"设备唯一标识：%@", strId);//UUID,5.0后不可用

    NSString *strSysName = [[UIDevice currentDevice] systemName];
    NSLog(@"系统名称：%@", strSysName);// e.g. @"iOS"

    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"系统版本号：%@", strSysVersion);// e.g. @"4.0"

    NSString *strModel = [[UIDevice currentDevice] model];
    NSLog(@"设备模式：%@", strModel);// e.g. @"iPhone", @"iPod touch"

    NSString *strLocModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"本地设备模式：%@", strLocModel);// localized version of model //地方型号  （国际化区域名称）

    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];

    NSString *appName = dicInfo[(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey];
    NSLog(@"App应用名称：%@", appName);   // 当前应用名称

    NSString *appVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"App应用版本：%@", appVersion);   // 当前应用软件版本


    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );   //手机型号

    NSString* loacalphoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"手机型号loacalphoneModel-: %@",loacalphoneModel );   //手机型号


    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    NSLog(@"语言：%@", language);//en

    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    NSLog(@"国家：%@", country); //en_US

    NSLog(@"devistring:%@",[self devistring]);

    //NSLog(@"%@",[self macaddress]);

    //    NSLog(@"localIPAddress=%@",[self localIPAddress]);
    //    NSLog(@"hostname=%@",[self hostname]);
    //
    //    NSLog(@"localWiFiIPAddress=%@",[self localWiFiIPAddress]);
    //    NSLog(@"whatismyipdotcom=%@",[self whatismyipdotcom]);

    //
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *ca = networkInfo.subscriberCellularProvider;
    NSLog(@"运营商:%@", ca.carrierName);

    //屏幕尺寸
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"print %f,%f",width,height);

    //分辨率 这个要处理下 大的放前面
    CGFloat scale_screen = [UIScreen mainScreen].scale;

    NSLog(@"分辨率=%f*%f",height*scale_screen,width*scale_screen);


    //
    CTTelephonyNetworkInfo *network = [[CTTelephonyNetworkInfo alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged) name:CTRadioAccessTechnologyDidChangeNotification object:nil];

    NSLog(@"网络情况:%@",network.currentRadioAccessTechnology);
    NSLog(@"网络状况2:%@",[self hhhnet]);

    NSLog(@"app_boundId:%@",[[NSBundle mainBundle]bundleIdentifier]);


//    for (int i=0; i<19; i++) {
//
//        //UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
//        NSDate *date = [NSDate date];
//
//        NSDictionary *dict = @{
//                               @"timeString":date,
//                               @"logString":[NSString stringWithFormat:@"去你麻痹的：%d",i],
//                               };
//        LogHandler *log = [[LogHandler alloc]init];
//        [log saveLogDataToCoreData:dict];
//    }
//
//    LogHandler *loggggg = [[LogHandler alloc]init];
//
//    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
//
//    NSDate *date = [NSDate date];
//    NSArray *ar = [loggggg predictLogDataWithTime:date WithPage:1 pageNumber:5];
//    for (Entity *en in ar) {
//
//        NSDate *dd = en.timeString;
//        
//        UInt64 recordTime = [dd timeIntervalSince1970]*1000;
//        
//        
//        NSLog(@"%@==%llu",en.logString,recordTime);
//        
//    }
//    
//    //删除
//    LogHandler *loggggggeedd = [[LogHandler alloc]init];
//    


}

- (NSString *)hhhnet
{
    NSString *strNetworkType = @"";

    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;

    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);

    zeroAddress.ss_family = AF_INET;

    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;

    //获得连接的标志
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        return strNetworkType;
    }


    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        strNetworkType = @"WIFI";
    }

    if (
        ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0
        )
    {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            strNetworkType = @"WIFI";
        }
    }

    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;

            if (currentRadioAccessTechnology)
            {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                {
                    strNetworkType =  @"4G";
                }
                else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                {
                    strNetworkType =  @"2G";
                }
                else
                {
                    strNetworkType =  @"3G";
                }
            }
        }
        else
        {
            if((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable)
            {
                if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection)
                {
                    if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired)
                    {
                        strNetworkType = @"2G";
                    }
                    else
                    {
                        strNetworkType = @"3G";
                    }
                }
            }
        }
    }


    if ([strNetworkType isEqualToString:@""]) {
        strNetworkType = @"WWAN";
    }


    return strNetworkType;
}

- (void)networkChanged{

    //网络改变，做相关的操作，注意非UI线程
    dispatch_async(dispatch_get_main_queue(), ^{
        //self.networkLabel.text = state;
    });

}

- (NSString *)devistring
{
    size_t size;

    sysctlbyname("hw.machine", NULL, &size, NULL, 0);

    char *machine = (char*)malloc(size);

    sysctlbyname("hw.machine", machine, &size, NULL, 0);

    NSString *deviceString = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    //未考虑iPhone3等较老设备，未考虑iPad设备（公司的应用不支持iPad）
    if ([deviceString hasPrefix:@"iPhone3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]||[deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"]||[deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString hasPrefix:@"iPhone6"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    //如果没有匹配直接返回系统提供的类似@iPhone5,3这种型号
    return deviceString;
}

- (NSString *) macaddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }

    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }

    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"x:x:x:x:x:x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%c%c%c%c%c%c", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];

}

- (NSString *) whatismyipdotcom
{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://www.whatismyip.com/automation/n09230945.asp"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:1 error:&error];
    return ip ? ip : [error localizedDescription];
}



//这是获取本地wifi的ip地址


// Matt Brown's get WiFi IP addy solution
// Author gave permission to use in Cookbook under cookbook license
// http://mattbsoftware.blogspot.com/2009/04/how-to-get-ip-address-of-iphone-os-v221.html
- (NSString *) localWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;

    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}



//NSString和Address的转换

+ (NSString *) stringFromAddress: (const struct sockaddr *) address
{
    if(address && address->sa_family == AF_INET) {
        const struct sockaddr_in* sin = (struct sockaddr_in*) address;
        return [NSString stringWithFormat:@"%@:%d", [NSString stringWithUTF8String:inet_ntoa(sin->sin_addr)], ntohs(sin->sin_port)];
    }

    return nil;
}

+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address
{
    if (!IPAddress || ![IPAddress length]) {
        return NO;
    }

    memset((char *) address, sizeof(struct sockaddr_in), 0);
    address->sin_family = AF_INET;
    address->sin_len = sizeof(struct sockaddr_in);

    int conversionResult = inet_aton([IPAddress UTF8String], &address->sin_addr);
    if (conversionResult == 0) {
        NSAssert1(conversionResult != 1, @"Failed to convert the IP address string into a sockaddr_in: %@", IPAddress);
        return NO;
    }

    return YES;
}
//获取host的名称
- (NSString *) hostname
{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '/0';

#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#endif
}
//从host获取地址
- (NSString *) getIPAddressForHost: (NSString *) theHost
{
    struct hostent *host = gethostbyname([theHost UTF8String]);
    if (!host) {herror("resolv"); return NULL; }
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
    return addressString;
}

//这是本地host的IP地址
- (NSString *) localIPAddress
{
    struct hostent *host = gethostbyname([[self hostname] UTF8String]);
    if (!host) {herror("resolv"); return nil;}
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
}

@end
