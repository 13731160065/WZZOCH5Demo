//
//  WZZOCH5VC.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import "WZZOCH5VC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WZZOCH5VC ()<UIWebViewDelegate>
{
    UIWebView * mainWebView;
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
    
    mainWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mainWebView];
    [mainWebView setDelegate:self];
    [mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

#pragma mark - webview代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext * jsCon = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    jsCon[@"selfVC"] = self;
    //需要创建的变量
    for (int i = 0; i < _needAllocObjClassArr.count; i++) {
        Class aClass = NSClassFromString(_needAllocObjClassArr[i]);
        id obj = [[aClass alloc] init];
        jsCon[_needAllocObjClassArr] = obj;
    }
    
    //直接用的变量
    NSArray * allKeysArr = _justUseObjDic.allKeys;
    for (int i = 0; i < allKeysArr.count; i++) {
        NSString * key = allKeysArr[i];
        id value = _justUseObjDic[key];
        jsCon[key] = value;
    }
}

@end
