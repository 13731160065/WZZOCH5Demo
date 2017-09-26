//
//  ViewController.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2017/9/26.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import "ViewController.h"
#import "WZZOCH5Manager.h"

@interface ViewController ()

@end

@implementation ViewController

//下载
- (IBAction)downloadClick:(id)sender {
    NSLog(@"%@", NSHomeDirectory());
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://github.com/13731160065/tmp/raw/master/testZip.zip"]];
    [WZZOCH5Manager unzipToBundleWithData:data];
    NSLog(@"ok");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
