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
#import "TestVC.h"
#import "WZZHttpTool.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

//下载
- (IBAction)downloadClick:(id)sender {
    NSLog(@"%@", NSHomeDirectory());
    NSString * str = [NSString stringWithFormat:@"https://github.com/13731160065/tmp/raw/master/%@.zip", [_tf.text isEqualToString:@""]?@"index":_tf.text];
    if ([_tf.text isEqualToString:@""]) {
        str = @"https://github.com/13731160065/WZZOCH5Demo/raw/master/index.zip";
    }
    __weak WZZDownloadTaskModel * model = [WZZHttpTool downloadWithUrl:str];
    [model setProgressBlock:^(NSNumber *progress) {
        NSLog(@"%.2lf", progress.doubleValue*100);
    }];
    [model setDownloadCompleteBlock:^(NSURL *location, NSError *error) {
        NSLog(@"下载成功");
        NSString * str2 = [NSString stringWithFormat:@"%@/Documents/%@.zip", NSHomeDirectory(), model.taskId];
        NSURL * fileUrl = [NSURL fileURLWithPath:str2];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:fileUrl error:nil];
        [WZZOCH5Manager unzipToBundleWithFileUrl:fileUrl];
    }];
}

- (IBAction)gotoVC:(id)sender {
#if 0
    WZZOCH5VC * vc = [[WZZOCH5VC alloc] init];
    vc.url = @"wzzoch5://test1/test.html";
    [self.navigationController pushViewController:vc animated:YES];
#endif
    TestVC * vc = [[TestVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"home:%@", NSHomeDirectory());
}

@end
