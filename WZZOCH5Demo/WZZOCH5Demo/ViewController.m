//
//  ViewController.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import "ViewController.h"
#import "WZZOCH5Manager.h"
#import "WZZOCH5VC.h"

@interface ViewController ()

@end

@implementation ViewController

//下载
- (IBAction)downloadClick:(id)sender {
    NSLog(@"%@", NSHomeDirectory());
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://github.com/13731160065/tmp/raw/master/test1.zip"]];
    [WZZOCH5Manager unzipToBundleWithData:data];
    NSLog(@"ok");
}

- (IBAction)gotoVC:(id)sender {
    WZZOCH5VC * vc = [[WZZOCH5VC alloc] init];
    vc.url = @"wzzoch5://test1/test.html";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
