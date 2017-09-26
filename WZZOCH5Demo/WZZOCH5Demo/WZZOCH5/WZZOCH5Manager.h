//
//  WZZOCH5Manager.h
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WZZOCH5Manager_unzipDir @"Documents/unzipDir"
#define WZZOCH5Manager_unzipName @"www"
#define WZZOCH5Manager_useZipArchive 1

@interface WZZOCH5Manager : NSObject

/**
 单例
 */
+ (instancetype)shareInstance;

/**
 解压数据
 */
+ (void)unzipToBundleWithData:(NSData *)data;

@end
