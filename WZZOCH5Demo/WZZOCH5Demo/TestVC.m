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
    [self abc];
}

- (void)abc {
    [self.view setBackgroundColor:[UIColor orangeColor]];
}

@end
