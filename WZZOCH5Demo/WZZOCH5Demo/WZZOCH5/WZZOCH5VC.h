//
//  WZZOCH5VC.h
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WZZOCH5Delegate <JSExport>

- (id)getObjWithKeyPath:(NSString *)keyPath;
- (void)setObjWithKeyPath:(NSString *)keyPath value:(id)value;
- (void)callObj:(id)obj
           func:(NSString *)funcName
        funcArg:(NSString *)funcArg;

@end

@interface WZZOCH5VC : UIViewController<WZZOCH5Delegate>

/**
 加载的url
 */
@property (nonatomic, strong) NSString * url;

/**
 直接用的变量，由js调用名称（key）和变量（value）组成
 */
@property (nonatomic, strong) NSDictionary <NSString *, id>* justUseObjDic;

/**
 需要创建的变量的类
 */
@property (nonatomic, strong) NSArray <NSString *>* needAllocObjClassArr;

@end
