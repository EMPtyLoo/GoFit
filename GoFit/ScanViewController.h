//
//  ScanViewController.h
//  GoFit
//
//  Created by EMPty on 4/10/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "NextViewController.h"
@interface ScanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CBPeripheralDelegate,CBCentralManagerDelegate>


@end
