//
//  NextViewController.h
//  GoFit
//
//  Created by EMPty on 4/10/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BEMSimpleLineGraphView.h"

@interface NextViewController : UIViewController<CBPeripheralDelegate,UITextFieldDelegate,BEMSimpleLineGraphDelegate>
@property (strong, nonatomic) CBPeripheral *presentPeripheral;

@property (nonatomic)  BEMSimpleLineGraphView *graph;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *labels;

@property (strong, nonatomic) UILabel *labelValues;
@property (strong, nonatomic) UILabel *labelDates;

@property (nonatomic) UITextField* textField;
@property (nonatomic) UIButton* start;
@end
