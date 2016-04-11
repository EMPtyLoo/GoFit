//
//  WebViewController.m
//  GoFit
//
//  Created by EMPty on 3/17/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    self.hidesBottomBarWhenPushed = NO;
//    self.navigationController.navigationBarHidden = NO;
//
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
    [self.view addSubview:_web];
    [_web loadRequest:request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
