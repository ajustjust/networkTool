//
//  HttpTool.m
//  YXT1
//
//  Created by xxzx on 15/3/6.
//  Copyright (c) 2015年 mac-yanghua. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"


#define CONNECTIONSUCCEED 200
#define CONNECTIONFORBIDDEN 403
#define CONNECTIONFAILED 404
#define BADREQUEST 400


@implementation HttpTool


#pragma mark - MakeHttpData
/****************************************************************************
 名   称：POSTWithURL: params: success: failure:
 功   能：构造请求协议
 入口参数：url:网络请求地址  params:网络请求体  success:请求成功后回调的block方法体    failure:请求失败后回调的block方法体
 
 编   写：杨华
 
****************************************************************************/



//华哥自己封装的http---POST网络请求
+(void)POSTWithURL:(NSString *)url params:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    ////1.创建请求管理对象
    AFHTTPRequestOperationManager*mgr =[AFHTTPRequestOperationManager manager];
    
    //2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    
        if (success) {
            
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}




/****************************************************************************
 名   称：GETWithURL: params: success: failure:
 功   能：构造请求协议
 入口参数：url:网络请求地址  params:网络请求体  success:请求成功后返回的block方法体    failure:请求失败后返回的block方法体
 
 编   写：杨华
 
 ****************************************************************************/

//华哥自己封装的http---GET网络请求
+(void)GETWithURL:(NSString *)url params:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    ////1.创建请求管理对象
    AFHTTPRequestOperationManager*mgr =[AFHTTPRequestOperationManager manager];
    
    //2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}



/****************************************************************************
 名   称：POSTWithURL: params: fromDataArray:  success: failure:
 功   能：构造请求协议
 入口参数：url:网络请求地址  params:网络请求体  fromDataArray:上传的数据  success:请求成功后回调的block方法体    failure:请求失败后回调的block方法体
 
 编   写：杨华
 
 ****************************************************************************/

//华哥封装的POST请求，上传文件数据还没写完！！！！！！！！
+(void)POSTWithURL:(NSString *)url params:(NSDictionary*)params fromDataArray:(NSArray*)fromDataArray success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    ////1.创建请求管理对象
    AFHTTPRequestOperationManager*mgr =[AFHTTPRequestOperationManager manager];
    
    //2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}




#pragma mark - NSURLconnectionDelegate
/******************************************************************
 名   称：netStatus: Error:
 功   能：网络是否可用
 入口参数：response:网络响应数据  error:网络错误数据
 出口参数：无
 修   改：杨华
 ******************************************************************/
+ (void)netStatus:(NSHTTPURLResponse*)response
            Error:(NSError *)error
{
    if (error) {
        //NSLog(@"error localizedDescription%@",[error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络请求错误"    message:@""   delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        switch ([error code]) {
            case NSURLErrorTimedOut:
                [alert setMessage:@"网络请求超时"];
                break;
            case NSURLErrorNotConnectedToInternet:
                [alert setMessage:@"请检查网络连接"];
                break;
            default:
                [alert setMessage:@"连接不到网络服务"];
                break;
        }
        [alert show];
        
        return;
    }else {
        if ([response respondsToSelector:@selector(allHeaderFields)]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"http响应状态"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"ok"
                                                 otherButtonTitles:nil];
            switch ([response statusCode]) {
                case CONNECTIONSUCCEED:
                    return ;
                //    [alert setMessage:@"请求成功"];
                    break;
                case CONNECTIONFAILED:
                    [alert setMessage:@"请求失败"];
                    break;
                case CONNECTIONFORBIDDEN:
                    [alert setMessage:@"请求拒绝"];
                    break;
                case BADREQUEST:
                    [alert setMessage:@"参数或语义有误，当前请求无法被服务器理解"];
                    break;
                default:
                    [alert setMessage:@"其它状态"];
                    break;
            }
            [alert show];
        }
    }
}





@end
