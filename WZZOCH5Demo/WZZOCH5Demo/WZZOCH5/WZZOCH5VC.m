//
//  WZZOCH5VC.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import "WZZOCH5VC.h"
#import "WZZOCH5Manager.h"

@interface WZZOCH5VC ()<UIWebViewDelegate>
{
    UIWebView * mainWebView;
    void(^_handleJSBlock)(id);
}

@end

@implementation WZZOCH5VC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    mainWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mainWebView];
    [mainWebView.scrollView setBounces:NO];
    [mainWebView.scrollView setShowsVerticalScrollIndicator:NO];
    [mainWebView.scrollView setShowsHorizontalScrollIndicator:NO];
    [mainWebView setScalesPageToFit:YES];
    [mainWebView setDelegate:self];
    if ([_url hasPrefix:@"wzzoch5://"]) {
        _url = [[_url componentsSeparatedByString:@"wzzoch5://"] componentsJoinedByString:@""];
        _url = [[WZZOCH5Manager wwwDir] stringByAppendingFormat:@"/%@", _url];
    }
    [mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0f]];
}

//js回调oc block
- (void)handleJSCallBack:(void (^)(id))aBlock {
    _handleJSBlock = aBlock;
}

#pragma mark - js代理
//创建对象
- (id)allocWithClass:(NSString *)className {
    Class aClass = NSClassFromString(className);
    return [[aClass alloc] init];
}

//调用方法
- (BOOL)runFuncWithObj:(id)obj FuncName:(NSString *)funcName {
    __block BOOL isOK = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        SEL func = NSSelectorFromString(funcName);
        if ([obj respondsToSelector:func]) {
            [obj performSelector:func];//这个警告不用管
            isOK = YES;
        }
    });
    return isOK;
}

//调用方法1个参数
- (BOOL)runFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1 {
    __block BOOL isOK = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        SEL func = NSSelectorFromString(funcName);
        if ([obj respondsToSelector:func]) {
            [obj performSelector:func withObject:arg1];//这个警告不用管
            isOK = YES;
        }
    });
    return isOK;
}

//调用方法2个参数
- (BOOL)runFuncWithObj:(id)obj FuncName:(NSString *)funcName Arg1:(id)arg1 Arg2:(id)arg2 {
    __block BOOL isOK = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        SEL func = NSSelectorFromString(funcName);
        if ([obj respondsToSelector:func]) {
            [obj performSelector:func withObject:arg1 withObject:arg2];//这个警告不用管
        }
        isOK = YES;
    });
    return isOK;
}

//js获取变量
- (id)getObjWithKeyPath:(NSString *)keyPath Obj:(id)obj {
    return [obj valueForKeyPath:keyPath];
}

//js给变量赋值
- (void)setObjWithKeyPath:(NSString *)keyPath Value:(id)value Obj:(id)obj {
    return [obj setValue:value forKey:keyPath];
}

//pop界面
- (void)popVC {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

//push界面
- (void)pushVC:(id)vc {
    dispatch_async(dispatch_get_main_queue(), ^{
//        [vc handleJSCallBack:^(id resp) {
//            [mainWebView stringByEvaluatingJavaScriptFromString:@""];
//        }];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

//present界面
- (void)presentVC:(id)vc {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:vc animated:YES completion:nil];
    });
}

//dismiss界面
- (void)dismissVC {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

//js回调oc
- (void)returnJsonStr:(id)jsonStr {
    if (_handleJSBlock) {
        _handleJSBlock(jsonStr);
    }
}

//js回调js
- (void)callBackFunc:(NSString *)funcName ArgsDic:(id)dic {
    if ([dic isKindOfClass:[NSDictionary class]]) {
        JSContext * jsCon = [mainWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        NSDictionary * aDic = dic;
        NSArray * keysArr = aDic.allKeys;
        for (int i = 0; i < keysArr.count; i++) {
            NSString * key = keysArr[i];
            NSString * value = aDic[key];
            key = [@"och5CallBack_" stringByAppendingString:key];
            jsCon[key] = value;
        }
    }
    
    [mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@()", funcName]];
}

#pragma mark - webview代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext * jsCon = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    jsCon[@"och5_jsContext"] = self;
    
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
}

@end
