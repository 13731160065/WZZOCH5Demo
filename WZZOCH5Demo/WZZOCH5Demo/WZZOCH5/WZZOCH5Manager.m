//
//  WZZOCH5Manager.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import "WZZOCH5Manager.h"
#import "ZipArchive.h"
#import "zlib.h"

static WZZOCH5Manager * wzzOCH5Manager;

@implementation WZZOCH5Manager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wzzOCH5Manager = [[WZZOCH5Manager alloc] init];
    });
    return wzzOCH5Manager;
}

+ (void)unzipToBundleWithData:(NSData *)data {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //如果没有这个文件夹就创建
    if (![fileManager isExecutableFileAtPath:[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir]]) {
        [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir] withIntermediateDirectories:NO attributes:nil error:nil];
    }
#if WZZOCH5Manager_useZipArchive
    //用下载文件创建zip
    [fileManager createFileAtPath:[NSString stringWithFormat:@"%@/%@/%@.zip", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] contents:data attributes:nil];
    
    //解压缩成文件夹_2
    BOOL unzipOK = [SSZipArchive unzipFileAtPath:[NSString stringWithFormat:@"%@/%@/%@.zip", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] toDestination:[NSString stringWithFormat:@"%@/%@/%@_2", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName]];
    
    if (unzipOK) {
        //解压缩成功
        //删除旧的文件夹
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
        //将解压的文件夹_2换成正式文件夹
        [fileManager moveItemAtPath:[NSString stringWithFormat:@"%@/%@/%@_2", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] toPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
        [self cleanWebCache];
    }
    
    //移除zip包
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@/%@.zip", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
#else
    NSData * unzipData = [self unzipWithData:data];
    if (unzipData) {
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] error:nil];
        [fileManager createFileAtPath:[NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), WZZOCH5Manager_unzipDir, WZZOCH5Manager_unzipName] contents:unzipData attributes:nil];
    }
#endif
    
}

//清除web缓存
+ (void)cleanWebCache {
#warning 这里有web缓存问题，实在不行就弄不同的路径
}

+ (NSData *)unzipWithData:(NSData *)data {
    //数据长度为空返回空
    if ([data length] == 0) {
        return nil;
    }
    
    NSUInteger full_length = [data length];//长度
    NSUInteger half_length = [data length]/2;//一半长度
    BOOL done = NO;//是否结束
    int status;//状态
    
    //创建一个空数据，长度为1.5倍原数据长
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length+half_length];
    
    //解压缩数据流
    z_stream strm;
    strm.next_in = (Bytef *)[data bytes];//下一个输入字节
    strm.avail_in = (uInt)[data length];//可以next_in的字节数
    strm.total_out = 0;//总输出长度
    strm.zalloc = Z_NULL;//用于创建内部状态
    strm.zfree = Z_NULL;//用于释放内部状态
    
    //解压初始化，失败返回空
    int initState = inflateInit2(&strm, -MAX_WBITS);
    if (initState != Z_OK) {
        return nil;
    }
    
    //循环写入输出数据
    while (!done) {
        //确定我们有足够的空间并且重设长度
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy:strm.total_out-[decompressed length]];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        //解压另一块数据
        status = inflate(&strm, Z_NO_FLUSH);
        
        //解压流是否走到了最后
        if (status == Z_STREAM_END) {
            //是，成功
            done = YES;
        } else if (status != Z_OK) {
            //状态不成功，失败
            break;
        }
        
    }
    //检测是否解压成功
    if (inflateEnd (&strm) != Z_OK) {
        return nil;
    }
    //设置真实长度
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    } else {
        return nil;
    }
}

@end
