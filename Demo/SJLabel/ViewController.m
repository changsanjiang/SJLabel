//
//  ViewController.m
//  SJLabel
//
//  Created by BlueDancer on 2017/12/20.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "ViewController.h"
#import "SJLabel.h"
#import <Masonry.h>
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    testView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:testView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
