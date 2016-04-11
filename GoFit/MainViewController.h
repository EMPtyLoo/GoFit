//
//  ViewController.h
//  GoFit
//
//  Created by EMPty on 11/29/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealViewController.h"
#import "MyViewController.h"
#import "HomeViewController.h"
#import "MoreViewController.h"
#import "DCPathButton.h"
#import "DCPathItemButton.h"
@interface MainViewController : UITabBarController<DCPathButtonDelegate>
@property (nonatomic)     UIView* tarBar;
//@property (nonatomic) int selectedIndex;
//- (void)hideTarbar:(BOOL)a;
@end

