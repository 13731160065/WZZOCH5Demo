//
//  TestVC.m
//  WZZOCH5Demo
//
//  Created by 王泽众 on 2018/1/12.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)testClick:(id)sender {
    NSInteger aa = 100000000000;
    [self abc:aa b:@(10) c:@"2" d:7 e:@(0) f:self];
}
- (void)abc {
    [self.view setBackgroundColor:[UIColor cyanColor]];
}

- (void)abc:(NSInteger)a b:(id)bb c:(NSString *)str d:(int)d e:(id)e f:(id)r {
    [self.view setBackgroundColor:[UIColor orangeColor]];
    NSLog(@"%zd", a);
}

@end
