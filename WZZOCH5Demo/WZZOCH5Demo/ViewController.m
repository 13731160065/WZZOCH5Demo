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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

//下载
- (IBAction)downloadClick:(id)sender {
    NSLog(@"%@", NSHomeDirectory());
//    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/13731160065/tmp/raw/master/%@.zip", [_tf.text isEqualToString:@""]?@"index":_tf.text]]];
//    [WZZOCH5Manager unzipToBundleWithData:data];
    NSString * str = [NSString stringWithFormat:@"https://github.com/13731160065/tmp/raw/master/%@.zip", [_tf.text isEqualToString:@""]?@"index":_tf.text];
    str = @"http://m5.pc6.com/cjh5/BlueStacks.dmg";
    [[WZZOCH5Manager shareInstance] downloadWithUrl:str progress:^(double progress) {
        
    } successBlock:^(NSURL *filePath) {
        [WZZOCH5Manager unzipToBundleWithFileUrl:filePath];
    } failedBlock:^(NSError *error) {
        
    }];
    NSLog(@"ok");
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
