//
//  WZZOCH5Manager.h
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZZOCH5Manager : NSObject

/**
 www根目录，不带/
 */
+ (NSString *)wwwDir;

/**
 单例
 */
+ (instancetype)shareInstance;

/**
 检测包版本
 */
+ (NSString *)getVersion;

/**
 下载

 @param url 下载地址
 @param progress 进度
 @param successBlock 成功
 @param failedBlock 失败
 */
- (void)downloadWithUrl:(NSString *)url
               progress:(void(^)(double progress))progress
           successBlock:(void(^)(NSURL * filePath))successBlock
            failedBlock:(void(^)(NSError * error))failedBlock;

/**
 解压数据

 @param data 数据
 */
+ (void)unzipToBundleWithData:(NSData *)data;

/**
 解压数据

 @param fileUrl 文件url
 */
+ (void)unzipToBundleWithFileUrl:(NSURL *)fileUrl;

@end

