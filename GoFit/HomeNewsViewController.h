//
//  HomeNewsViewController.h
//  GoFit
//
//  Created by EMPty on 3/8/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic) NSString* kind;
@end
