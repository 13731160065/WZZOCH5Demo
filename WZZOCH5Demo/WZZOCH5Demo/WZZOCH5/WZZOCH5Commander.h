//
//  WZZOCH5Commander.h
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2018/1/11.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol WZZOCH5CommanderDelegate <JSExport>

- (void)makeLog:(id)log;

#pragma mark - 类与变量
//创建类
- (id)allocWithClass:(NSString *)className;

//调用类方法
- (id)runFuncWithClass:(Class)aClass FuncName:(NSString *)funcName;
- (id)runFuncWithClass:(Class)aClass FuncName:(NSString *)funcName Arg1:(id)arg1;
- (id)runFuncWithClass:(Class)aClass FuncName:(NSString *)funcName Arg1:(id)arg1 Arg2:(id)arg2;
//返回空的方法
- (void)voidrunFuncWithClass:(Class)aClass FuncName:(NSString *)funcName;
- (void)voidrunFuncWithClass:(Class)aClass FuncName:(NSString *)funcName Arg1:(id)arg1;
- (void)voidrunFuncWithClass:(Class)aClass FuncName:(NSString *)funcName Arg1:(id)arg1 Arg2:(id)arg2;

//调用对象方法
- (id)runFuncWithObj:(id)obj FuncName:(NSString *)funcName;
- (id)runFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1;
- (id)runFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1 Arg2:(id)arg2;
//调用对象方法
- (void)voidrunFuncWithObj:(id)obj FuncName:(NSString *)funcName;
- (void)voidrunFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1;
- (void)voidrunFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1 Arg2:(id)arg2;

//获取变量
- (id)getObjWithKeyPath:(NSString *)keyPath Obj:(id)obj;

//变量赋值
- (void)setObjWithKeyPath:(NSString *)keyPath Value:(id)value Obj:(id)obj;

/**
 设置替换方法数组

 @param array 方法数组
 每个元素:@{
 @"classname":@"WZZOCH5VC",
 @"objmethod":@"getObjWithKeyPath:Obj:",
 @"objmethodblock":block
 }
 */
- (void)setReplaceMethodArray:(NSArray *)array;

#pragma mark - 回调函数
//js回调oc接口，可以返回json字符串给oc，视情况而定
- (void)returnJsonStr:(id)jsonStr;

@end

@interface WZZOCH5Commander : NSObject<WZZOCH5CommanderDelegate>

@property (nonatomic, weak) UIViewController * currentController;

/**
 原生参数
 原生参数在js中以och5_xxx的形式调用
 */
@property (nonatomic, strong) NSDictionary <NSString *, id>* args;

/**
 初始化

 @return 实例
 */
+ (instancetype)shareInstance;

/**
 刷新页面
 */
- (void)refresh;

/**
 获取替换方法数组

 @return 替换方法数组
 */
- (NSArray *)replaceMethodArray;

/**
 调用js方法
 
 @param jsfunc js方法名
 */
- (void)runJSFunc:(NSString *)jsfunc;

@end

@interface WZZOCH5CommanderReplaceMethonModel: NSObject

/**
 类名
 */
@property (nonatomic, strong) NSString * classname;

/**
 对象方法名
 */
@property (nonatomic, strong) NSString * objmethod;

/**
 对象方法替换实现
 */
@property (nonatomic, strong) NSString * objchangemethod;

@end
