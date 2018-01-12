//
//  UIViewController+WZZH5ViewDidLoad.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2018/1/11.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "UIViewController+WZZH5ViewDidLoad.h"
#import <objc/runtime.h>
#import "WZZOCH5Commander.h"

@implementation UIViewController (WZZH5ViewDidLoad)

+ (void)load {
    Method orgMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method tarMethod = class_getInstanceMethod(self, @selector(ex_viewDidLoad));
    method_exchangeImplementations(orgMethod, tarMethod);
}

- (void)ex_viewDidLoad {
    [WZZOCH5Commander shareInstance].currentController = self;
    NSArray * arr = [[WZZOCH5Commander shareInstance] replaceMethodArray];
    for (int i = 0; i < arr.count; i++) {
        @try {
            WZZOCH5CommanderReplaceMethonModel * model = arr[i];
            NSString * classStr = model.classname;
            NSString * orgFunc = model.objmethod;
            id aBlock = model.objmethodblock;
            
            if ([classStr isEqualToString:NSStringFromClass([self class])]) {
                IMP m = imp_implementationWithBlock(aBlock);
                SEL selll = NSSelectorFromString(orgFunc);
                class_replaceMethod([self class], selll, m, orgFunc.UTF8String);
            }
        } @catch (NSException *exception) {
            NSLog(@"换方法异常:%@", exception);
        }
    }
}

@end
