//
//  HttpTool.h
//  YXT1
//
//  Created by xxzx on 15/3/6.
//  Copyright (c) 2015年 mac-yanghua. All rights reserved.
//网络请求处理

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

/**
 *  参数体头
 */





////华哥自己封装POST的网络请求

+(void)POSTWithURL:(NSString *)url params:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

////华哥自己封装GET的网络请求
+(void)GETWithURL:(NSString *)url params:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


//华哥封装的POST请求，上传文件数据
+(void)POSTWithURL:(NSString *)url params:(NSDictionary*)params fromDataArray:(NSArray*)fromDataArray success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



/******************************************************************
 名   称：netStatus: Error:
 功   能：网络是否可用
 入口参数：response:网络响应数据  error:网络错误数据
 出口参数：无
 修   改：杨华
 ******************************************************************/
+(void)netStatus:(NSHTTPURLResponse*)response Error:(NSError *)error;

@end
