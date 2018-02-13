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
#import "TestVC.h"

const void * tmpArgKey = &tmpArgKey;

@implementation UIViewController (WZZH5ViewDidLoad)

+ (void)load {
    Method orgMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method tarMethod = class_getInstanceMethod(self, @selector(ex_viewDidLoad));
    method_exchangeImplementations(orgMethod, tarMethod);
}

- (void)setObjWithVoidPoint:(void *)aPoint type:(char)type argArr:(NSMutableArray *)argArr {
    switch (type) {
        case 'c':
        {
            [argArr addObject:@((char)aPoint)];
        }
            break;
        case 'C':
        {
            [argArr addObject:@((unsigned char)aPoint)];
        }
            break;
        case 's':
        {
            [argArr addObject:@((short)aPoint)];
        }
            break;
        case 'S':
        {
            [argArr addObject:@((unsigned short)aPoint)];
        }
            break;
        case 'i':
        {
            [argArr addObject:@((int)aPoint)];
        }
            break;
        case 'I':
        {
            [argArr addObject:@((unsigned int)aPoint)];
        }
            break;
        case 'l':
        {
            [argArr addObject:@((long)aPoint)];
        }
            break;
        case 'L':
        {
            [argArr addObject:@((unsigned long)aPoint)];
        }
            break;
        case 'q':
        {
            [argArr addObject:@((long long)aPoint)];
        }
            break;
        case 'Q':
        {
            [argArr addObject:@((unsigned long long)aPoint)];
        }
            break;
        case 'f':
        {
            [argArr addObject:@(0)];
        }
            break;
        case 'd':
        {
            [argArr addObject:@(0)];
        }
            break;
        case 'B':
        {
            [argArr addObject:@((BOOL)aPoint)];
        }
            break;
        case '@':
        {
            [argArr addObject:(__bridge id)aPoint];
        }
            break;
            
        default:
            break;
    }
}

- (void)ex_viewDidLoad {
    //获取需要覆盖的方法
    NSArray * arr = [[WZZOCH5Commander shareInstance] replaceMethodArray];
    
#if 0
    //测试数据
    WZZOCH5CommanderReplaceMethonModel * mo = [[WZZOCH5CommanderReplaceMethonModel alloc] init];
    mo.classname = @"TestVC";
//    mo.objmethod = @"abc:b:c:d:e:f:";
    mo.objmethod = @"abc";
    mo.objchangemethod = @"abc";
    arr = @[mo];
#endif
    
    //遍历覆盖数组
    for (int i = 0; i < arr.count; i++) {
        @try {
            //获取某一个
            WZZOCH5CommanderReplaceMethonModel * model = arr[i];
            //获取替换类名
            NSString * classStr = model.classname;
            //获取方法名
            NSString * orgFunc = model.objmethod;
            
            //判断类名是否要替换类
            if ([classStr isEqualToString:NSStringFromClass([self class])]) {
                //创建普适block
                void * (^aBlock)(id, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
                //实现普适block
                aBlock = ^void *(id obj, void * a1, void * a2, void * a3, void * a4, void * a5, void * a6, void * a7, void * a8, void * a9, void * a10) {
                    //获取方法对应SEL
                    SEL selll2 = NSSelectorFromString(orgFunc);
                    //获取方法
                    Method m1 = class_getInstanceMethod([self class], selll2);
                    //获取方法参数数量
                    unsigned int argNumber = method_getNumberOfArguments(m1);
                    NSMutableArray * argArr = [NSMutableArray array];
                    
                    //遍历参数
                    for (unsigned int i = 0; i < argNumber; i++) {
                        //获取一个参数变量类型
                        char * abc = method_copyArgumentType(m1, i+2);
                        NSString * typeStr = [NSString stringWithFormat:@"%s", abc];
                        char typeChar = [typeStr characterAtIndex:0];
                        
                        switch (i) {
                            case 0:
                            {
                                [self setObjWithVoidPoint:a1 type:typeChar argArr:argArr];
                            }
                                break;
                            case 1:
                            {
                                [self setObjWithVoidPoint:a2 type:typeChar argArr:argArr];
                            }
                                break;
                            case 2:
                            {
                                [self setObjWithVoidPoint:a3 type:typeChar argArr:argArr];
                            }
                                break;
                            case 3:
                            {
                                [self setObjWithVoidPoint:a4 type:typeChar argArr:argArr];
                            }
                                break;
                            case 4:
                            {
                                [self setObjWithVoidPoint:a5 type:typeChar argArr:argArr];
                            }
                                break;
                            case 5:
                            {
                                [self setObjWithVoidPoint:a6 type:typeChar argArr:argArr];
                            }
                                break;
                            case 6:
                            {
                                [self setObjWithVoidPoint:a7 type:typeChar argArr:argArr];
                            }
                                break;
                            case 7:
                            {
                                [self setObjWithVoidPoint:a8 type:typeChar argArr:argArr];
                            }
                                break;
                            case 8:
                            {
                                [self setObjWithVoidPoint:a9 type:typeChar argArr:argArr];
                            }
                                break;
                            case 9:
                            {
                                [self setObjWithVoidPoint:a10 type:typeChar argArr:argArr];
                            }
                                break;
                                
                            default:
                                break;
                        }
                    }
                    
                    NSLog(@"参数:%@", argArr);
                    objc_setAssociatedObject(self, tmpArgKey, argArr, OBJC_ASSOCIATION_RETAIN);
                    
                    //在此处调用js
                    [[WZZOCH5Commander shareInstance] runJSFunc:model.objchangemethod];
                    
                    return NULL;
                };
                IMP m = imp_implementationWithBlock(aBlock);
                SEL selll = NSSelectorFromString(orgFunc);
                class_replaceMethod([self class], selll, m, orgFunc.UTF8String);
            }
        } @catch (NSException *exception) {
            NSLog(@"换方法异常:%@", exception);
        }
    }
    
    [self ex_viewDidLoad];
}

- (NSArray *)tmpArgsArr {
    return objc_getAssociatedObject(self, tmpArgKey);
}

@end
