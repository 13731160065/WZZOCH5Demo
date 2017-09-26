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

#pragma mark - 类与变量
//创建类
- (id)allocWithClass:(NSString *)className;

//调用方法
- (BOOL)runFuncWithObj:(id)obj FuncName:(NSString *)funcName;
- (BOOL)runFuncWithObj:(id)obj FuncName:(NSString *)funcName arg1:(id)arg1;
- (BOOL)runFuncWithObj:(id)obj FuncName:(NSString *)funcName arg1:(id)arg1 arg2:(id)arg2;

//获取变量
- (id)getObjWithKeyPath:(NSString *)keyPath Obj:(id)obj;

//变量赋值
- (void)setObjWithKeyPath:(NSString *)keyPath Value:(id)value Obj:(id)obj;

#pragma mark - 界面跳转
//nav模式进入界面
- (void)pushVC:(id)vc;

//nav模式退出界面
- (void)popVC;

//present模式进入界面
- (void)presentVC:(id)vc;

//present模式退出界面
- (void)dismissVC;

#pragma mark - 回调函数
//js回调oc接口，可以返回json字符串给oc，视情况而定
- (void)returnJsonStr:(id)jsonStr;

/**
 js回调js接口，js可以实现一个方法，在该方法里写回调函数
 1.要求方法为无参方法
 2.参数将会以JSContext的形式传递，在方法内部用obh5CallBack_xxx形式调用，xxx为传入ArgsDic的参数的键
 */
- (void)callBackFunc:(NSString *)funcName ArgsDic:(id)dic;

@end

@interface WZZOCH5VC : UIViewController<WZZOCH5Delegate>

/**
 加载的url
 */
@property (nonatomic, strong) NSString * url;

/**
 原生参数
 原生参数在js中以och5_xxx的形式调用
 */
@property (nonatomic, strong) NSDictionary <NSString *, id>* args;

/**
 处理js回调
 */
- (void)handleJSCallBack:(void(^)(id resp))aBlock;

@end
