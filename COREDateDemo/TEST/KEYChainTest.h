//
//  KEYChainTest.h
//  COREDateDemo
//
//  Created by leo on 16/7/27.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEYChainTest : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
