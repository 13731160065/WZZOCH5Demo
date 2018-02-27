//
//  WZZOCH5Manager.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import "WZZOCH5Manager.h"
#import "ZipArchive.h"
#import "WZZOCH5Commander.h"

#define WZZOCH5Manager_unzipDir @"Documents/unzipDir"
#define WZZOCH5Manager_unzipName @"www"

static WZZOCH5Manager * wzzOCH5Manager;

@interface WZZOCH5Manager ()
{
    NSURLSession * m_downloadSession;//下载会话
    NSURLSessionDownloadTask * m_downloadTask;//下载任务
}

@end

@implementation WZZOCH5Manager

//根地址
+ (NSString *)wwwDir {
    //返回正确的地址
    if ([[NSFileManager defaultManager] isExecutableFileAtPath:[NSString stringWithFormat:@"%@/%@/%@_2", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName]]) {
        return [NSString stringWithFormat:@"%@/%@/%@_2", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName];
    } else if ([[NSFileManager defaultManager] isExecutableFileAtPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName]]) {
        return [NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName];
    }
    return nil;
}

//单例
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wzzOCH5Manager = [[WZZOCH5Manager alloc] init];
    });
    return wzzOCH5Manager;
}

//获取版本信息
+ (NSString *)getVersion {
    NSString * homeStr = [self wwwDir];
    if (homeStr) {
        NSFileHandle * handle = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/version", homeStr]];
        NSString * str = [[NSString alloc] initWithData:[handle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
        return str;
    } else {
        return @"0.0.0";
    }
}

+ (void)unzipToBundleWithFileUrl:(NSURL *)fileUrl {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //如果没有这个文件夹就创建
    if (![fileManager isExecutableFileAtPath:[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir]]) {
        [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir] withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    //用下载文件创建zip
    NSURL * targetUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@/%@.zip", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName]];
    [fileManager moveItemAtURL:fileUrl toURL:targetUrl error:nil];
    
    //解压缩成文件夹_2
    BOOL unzipOK = [SSZipArchive unzipFileAtPath:[NSString stringWithFormat:@"%@/%@/%@.zip", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] toDestination:[NSString stringWithFormat:@"%@/%@/%@_3", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName]];
    
    //这里会分化成两个文件夹，为了避免webview的缓存
    if (unzipOK) {
        //解压缩成功
        if ([fileManager isExecutableFileAtPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName]]) {
            //删除旧的文件夹1
            [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
            //将解压的文件夹_3换成文件夹_2
            [fileManager moveItemAtPath:[NSString stringWithFormat:@"%@/%@/%@_3", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] toPath:[NSString stringWithFormat:@"%@/%@/%@_2", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
        } else if ([fileManager isExecutableFileAtPath:[NSString stringWithFormat:@"%@/%@/%@_2", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName]]) {
            //删除旧的文件夹1
            [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@/%@_2", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
            //将解压的文件夹_3换成文件夹1
            [fileManager moveItemAtPath:[NSString stringWithFormat:@"%@/%@/%@_3", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] toPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
        } else {
            //没有旧的文件夹
            //将解压的文件夹_3换成文件夹1
            [fileManager moveItemAtPath:[NSString stringWithFormat:@"%@/%@/%@_3", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] toPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
        }
    }
    
    //移除zip包
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@/%@.zip", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
    
    NSLog(@"刷新包");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[WZZOCH5Commander shareInstance] refresh];
    });
}

//解压
+ (void)unzipToBundleWithData:(NSData *)data {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //用下载文件创建zip
    NSString * fileUrl = [NSString stringWithFormat:@"%@/%@/%@.zip", NSHomeDirectory(), @"tmp", WZZOCH5Manager_unzipName];
    [fileManager removeItemAtPath:fileUrl error:nil];
    [fileManager createFileAtPath:fileUrl contents:data attributes:nil];
    [self unzipToBundleWithFileUrl:[NSURL fileURLWithPath:fileUrl]];
}

@end

