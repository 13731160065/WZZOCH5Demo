//
//  WZZOCH5Commander.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2018/1/11.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZOCH5Commander.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "WZZOCH5Manager.h"

static WZZOCH5Commander * wzzOCH5Commander;

@interface WZZOCH5Commander ()<UIWebViewDelegate>
{
    UIWebView * mainWebView;
    void(^_handleJSBlock)(id);
    NSMutableArray * replaceArr;
}

@end

@implementation WZZOCH5Commander

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wzzOCH5Commander = [[WZZOCH5Commander alloc] init];
        wzzOCH5Commander->replaceArr = [NSMutableArray array];
    });
    return wzzOCH5Commander;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [mainWebView.scrollView setBounces:NO];
        [mainWebView.scrollView setShowsVerticalScrollIndicator:NO];
        [mainWebView.scrollView setShowsHorizontalScrollIndicator:NO];
        [mainWebView setScalesPageToFit:YES];
        [mainWebView setDelegate:self];
        NSString * _url = @"wzzoch5://control/control.html";
        if ([_url hasPrefix:@"wzzoch5://"]) {
            _url = [[_url componentsSeparatedByString:@"wzzoch5://"] componentsJoinedByString:@""];
            _url = [[WZZOCH5Manager wwwDir] stringByAppendingFormat:@"/%@", _url];
        }
        
        NSURL * urlObj = [NSURL URLWithString:_url];
        if (!urlObj) {
            urlObj = [NSURL URLWithString:[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        [mainWebView loadRequest:[NSURLRequest requestWithURL:urlObj cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0f]];
    }
    return self;
}

- (NSArray *)replaceMethodArray {
    return replaceArr;
}

#pragma mark - js代理
- (void)makeLog:(id)log {
    NSLog(@"%@", log);
}

//MARK:创建对象
- (id)allocWithClass:(NSString *)className {
    Class aClass = NSClassFromString(className);
    return [[aClass alloc] init];
}

//MARK:调用类方法
- (id)runFuncWithClass:(Class)aClass FuncName:(NSString *)funcName {
    id returnObj = nil;
    SEL func = NSSelectorFromString(funcName);
    if ([aClass respondsToSelector:func]) {
        returnObj = [aClass performSelector:func];//这个警告不用管
    }
    return returnObj;
}

//MARK:调用类方法1参数
- (id)runFuncWithClass:(Class)aClass FuncName:(NSString *)funcName Arg1:(id)arg1 {
    id returnObj = nil;
    SEL func = NSSelectorFromString(funcName);
    if ([aClass respondsToSelector:func]) {
        returnObj = [aClass performSelector:func withObject:arg1];//这个警告不用管
    }
    return returnObj;
}

//MARK:调用类方法2参数
- (id)runFuncWithClass:(Class)aClass FuncName:(NSString *)funcName Arg1:(id)arg1 Arg2:(id)arg2 {
    id returnObj = nil;
    SEL func = NSSelectorFromString(funcName);
    if ([aClass respondsToSelector:func]) {
        returnObj = [aClass performSelector:func withObject:arg1 withObject:arg2];//这个警告不用管
    }
    return returnObj;
}

//MARK:调用方法
- (id)runFuncWithObj:(id)obj FuncName:(NSString *)funcName {
    __block id returnObj = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        SEL func = NSSelectorFromString(funcName);
        if ([obj respondsToSelector:func]) {
            returnObj = [obj performSelector:func];//这个警告不用管
        }
    });
    return returnObj;
}

//MARK:调用方法1个参数
- (id)runFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1 {
    __block id returnObj = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        SEL func = NSSelectorFromString(funcName);
        if ([obj respondsToSelector:func]) {
            returnObj = [obj performSelector:func withObject:arg1];//这个警告不用管
        }
    });
    return returnObj;
}

//MARK:调用方法2个参数
- (id)runFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1 Arg2:(id)arg2 {
    __block id returnObj = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        SEL func = NSSelectorFromString(funcName);
        if ([obj respondsToSelector:func]) {
            returnObj = [obj performSelector:func withObject:arg1 withObject:arg2];//这个警告不用管
        }
    });
    return returnObj;
}

//MARK:js获取变量
- (id)getObjWithKeyPath:(NSString *)keyPath Obj:(id)obj {
    return [obj valueForKeyPath:keyPath];
}

//MARK:js给变量赋值
- (void)setObjWithKeyPath:(NSString *)keyPath Value:(id)value Obj:(id)obj {
    return [obj setValue:value forKey:keyPath];
}

//MARK:设置替换方法数组
- (void)setReplaceMethodArray:(NSArray *)array {
    [replaceArr addObjectsFromArray:array];
}

//MARK:js回调oc
- (void)returnJsonStr:(id)jsonStr {
    if (_handleJSBlock) {
        _handleJSBlock(jsonStr);
    }
}

//MARK:创建block
- (id)createBlockWith {
    id aBlock = ^() {
        [mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@
                                                             "try {"
                                                             "if (typeof viewDidLoad == \"function\") {"
                                                             "}"
                                                             "} catch(exp) {"
                                                             "}"
                                                             ]];
    };
    return aBlock;
}

#pragma mark - webview代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    JSContext * jsCon = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    jsCon[@"och5_JSContext"] = self;
    jsCon[@"och5_HomeDir"] = [WZZOCH5Manager wwwDir];
    jsCon[@"och5_viewDidLoad"] = ^{
        NSLog(@"nono");
    };
    
    NSArray * keysArr = _args.allKeys;
    for (int i = 0; i < keysArr.count; i++) {
        NSString * key = keysArr[i];
        NSString * value = _args[key];
        key = [@"och5_" stringByAppendingString:key];
        jsCon[key] = value;
    }
    
    jsCon.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:
      @"var pchElement = document.createElement(\"script\");"
      "pchElement.setAttribute(\"type\",\"text/javascript\");"
      "pchElement.setAttribute(\"src\",\"%@/WZZOCH5Manager.js\");"
      "document.head.insertBefore(pchElement, document.head.firstElementChild);", [WZZOCH5Manager wwwDir]
      ]
     ];
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@
                                                     "try {"
                                                     "if (typeof viewDidLoad == \"function\") {"
                                                     "setTimeout('viewDidLoad()', 100);"//这里必须用延时来处理
                                                     "}"
                                                     "} catch(exp) {"
                                                     "}"
                                                     ]];
}

@end

@implementation WZZOCH5CommanderReplaceMethonModel

@end
