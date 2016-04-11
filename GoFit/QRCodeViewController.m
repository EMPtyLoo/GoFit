//
//  QRCodeViewController.m
//  GoFit
//
//  Created by EMPty on 2/23/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    
    UIImageView * QRCode = [[UIImageView alloc]initWithFrame:CGRectMake(30,100, 320-60, 320)];
    self.view.backgroundColor = [UIColor blackColor];
    
    QRCode.backgroundColor = [UIColor whiteColor];
//    QRCode.alpha = 0.7;
    QRCode.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:QRCode];
    QRCode.image = [QRCodeGenerator qrImageForString:@"hello world" imageSize:100];
    UIButton* back = [[UIButton alloc]initWithFrame:QRCode.bounds];
    back.backgroundColor = [UIColor clearColor];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
     
     */
    // Do any additional setup after loading the view.
}

- (void)backButton
{
    NSLog(@"返回");
    [self dismissViewControllerAnimated:YES completion:nil];
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
