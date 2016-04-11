//
//  NextViewController.m
//  GoFit
//
//  Created by EMPty on 4/10/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()
{
    NSMutableArray* _cha;
    NSMutableArray* _service;
    NSMutableArray* _characteristicList;
    CBCharacteristic* _chosenCh;
    int _side;
    int _timeInAll;
    float _distanceInAll;
    NSTimer* _mainTimer;
    int _timesInSeconds;
    //    NSMutableArray* _singleData;
    
}
@end

@implementation NextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _side = 40;
    _timeInAll = 0;
    _distanceInAll = 0;
    _timesInSeconds = 0;
    self.view.backgroundColor  = [UIColor whiteColor];
    
    
    self.data = [[NSMutableArray alloc]init];
    self.labels = [[NSMutableArray alloc]init];
    
    
    for (int i=0; i < 2; i++) {
        [self.data addObject:[NSNumber numberWithInteger:0]]; // Random values for the graph
        [self.labels addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:0]]]; // Dates for the X-Axis of the graph
    }
    
    
    _characteristicList = [[NSMutableArray alloc]initWithObjects:nil];
    
    _presentPeripheral.delegate = self;
    [_presentPeripheral  discoverServices:nil];
    
    _cha = [[NSMutableArray alloc]initWithObjects:nil];
    [self initTextFieldAndGraph];
    
    
}

#pragma mark - 初始化文本框、图表

- (void)initTextFieldAndGraph
{
    //    self.graph = [[GKLineGraph alloc]initWithFrame:CGRectMake(0, 160, 320, 278)];
    //    self.graph.backgroundColor = [UIColor clearColor];
    //    self.graph.dataSource = self;
    //    self.graph.animated = NO;
    //    self.graph=[MPPlot plotWithType:MPPlotTypeGraph frame:CGRectMake(0, 160, 320, 278)];
    
    self.graph = [[BEMSimpleLineGraphView alloc]initWithFrame:CGRectMake(10, 160, 300, 278)];
    
    self.graph.enableTouchReport = YES;
    
    self.graph.colorTop = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.graph.colorBottom = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.graph.colorLine = [UIColor whiteColor];
    self.graph.colorXaxisLabel = [UIColor whiteColor];
    self.graph.widthLine = 3.0;
    self.graph.delegate = self;
    
    [self.view addSubview:self.graph];
    
    
    self.labelValues = [[UILabel alloc]initWithFrame:CGRectMake(0, 446, 320, 38)];
    self.labelValues.textAlignment = NSTextAlignmentCenter;
    self.labelValues.text = @"";
    self.labelDates = [[UILabel alloc]initWithFrame:CGRectMake(0, 492, 320, 21)];
    self.labelDates.text = @"";
    self.labelDates.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.labelDates];
    [self.view addSubview:self.labelValues];
    
#warning textField没有加进去
//
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(65, 98, 191, 30)];
    self.textField.placeholder = @"测试用的边长  默认为40";
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.backgroundColor = [UIColor lightGrayColor];
    self.textField.layer.cornerRadius = 8.0;
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    //    [self.view addSubview:self.graph];
    
//    [self.view addSubview:self.textField];
//    self.start = [[UIButton alloc]initWithFrame:CGRectMake(120, 530, 80, 50)];
        self.start = [[UIButton alloc]initWithFrame:CGRectMake(65, 90, 191, 50)];

    self.start.backgroundColor = [UIColor clearColor];
    [self.start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.start setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:self.start];
    [self.start addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startRecord
{
    NSLog(@"%@",self.start.titleLabel.text);
    if ([self.start.titleLabel.text isEqualToString:@"开始"]) {
        _mainTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(cacuSpeed) userInfo:nil repeats:YES];
        //        self.graph.animationDelegate  = nil;
        self.graph.animationGraphEntranceSpeed = 0;
        [self.start setTitle:@"结束" forState:UIControlStateNormal];
    }
    else
    {
        [_mainTimer invalidate];
        _mainTimer = nil;
        [self.start setTitle:@"开始" forState:UIControlStateNormal];
        
    }
}


#pragma mark - 3秒一次速度检测
- (void)cacuSpeed
{
    _timeInAll += 3;
    int r = _side;
    //    NSLog(@"半径：%d",r);
    float round = 2 * r * 3.14 ;
    float distanceInSecond = _timesInSeconds * round  /  3;//cm为单位
    _distanceInAll += distanceInSecond;
    _timesInSeconds = 0;
    float speedInSecond = distanceInSecond / 100 ;//m为单位
    
    //    NSLog(@"速度：%f",speedInSecond);
    
    NSLog(@"速度%@",[NSString stringWithFormat:@"%.2f",speedInSecond]);
    
    [self.data addObject:[NSNumber numberWithFloat:[[NSString stringWithFormat:@"%.2f",speedInSecond] floatValue]]];
    
    [self.labels addObject:[NSString stringWithFormat:@"%d",_timeInAll]];
    
    //    self.graph.valueLabelCount = self.labels.count
    ;
    NSLog(@"数据源：value :%@, lable :%@",self.data,self.labels);
    //    [self.graph draw];
    [self.graph reloadGraph];//刷新视图
    
    
    
    
    
    
    
    self.labelValues.text = [NSString stringWithFormat:@"总路程 ： %.2f",_distanceInAll];
    self.labelDates.text = [NSString stringWithFormat:@"平均速度 ：%.2f",_distanceInAll / _timeInAll / 100];
    
    //    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.labelValues.alpha = 1.0;
    self.labelDates.alpha = 1.0;
    //    } completion:nil];
    
    
    
    
    
}



//- (void)draw
//{
//    [self.graph draw];
//}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error

{
    
    
    for (CBService* service in peripheral.services)
    {
        NSArray* includedservices = service.includedServices;
        NSLog(@"服务service：%@",includedservices);
        //查询服务的特征值
        [peripheral discoverCharacteristics:nil forService:service];
        
        
    }
    
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error

{
    
    for (CBCharacteristic * characteristic in service.characteristics)
    {
        //        if (characteristic.UUID == [CBUUID UUIDWithString:@"FFE1"]) {
        _chosenCh = characteristic;
        [_cha addObject:characteristic];
        
        NSLog(@"%@",[_chosenCh.UUID UUIDString]);
        NSLog(@"%@",_chosenCh);
        //        }
        [_characteristicList addObject:characteristic];
        
        NSLog(@"特征值：%@",characteristic);
    }
#pragma mark-很重要
    //很重要  打开广播
    [_presentPeripheral setNotifyValue:YES forCharacteristic:_chosenCh];
    
    //    [_tableView reloadData];
}


#pragma mark - 每次串口有数据发送过来
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    
    
    //    NSLog(@"%@",[characteristic.UUID UUIDString]);
    
    
    const unsigned char *hexBytesLight = [characteristic.value bytes];
    
    int a = hexBytesLight[0] ;
    
    //    NSLog(@"%d",a);
    
    _timesInSeconds++;
    
    
    
}


#pragma mark - SimpleLineGraph Data Source

- (int)numberOfPointsInGraph {
    NSLog(@"%d",[self.data count]);
    NSLog(@"%@",self.data);
    return (int)[self.data count];
}

- (float)valueForIndex:(NSInteger)index {
    NSLog(@"index:%d",index);
    NSLog(@"%@",[self.data objectAtIndex:index]);
    return [[self.data objectAtIndex:index] floatValue];
}



#pragma mark - SimpleLineGraph Delegate

- (int)numberOfGapsBetweenLabels {
    return self.data.count / 5;
}

- (NSString *)labelOnXAxisForIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}

- (void)didTouchGraphWithClosestIndex:(int)index {
    self.labelValues.text = [NSString stringWithFormat:@"速度 %@", [self.data objectAtIndex:index]];
    
    self.labelDates.text = [NSString stringWithFormat:@"时间 %@", [self.labels objectAtIndex:index]];
}

- (void)didReleaseGraphWithClosestIndex:(float)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.labelValues.alpha = 0.0;
        self.labelDates.alpha = 0.0;
    } completion:^(BOOL finished){
        
        self.labelValues.text = [NSString stringWithFormat:@"总时间 ：%i S 总路程 ： %.2f", _timeInAll,_distanceInAll];
        self.labelDates.text = [NSString stringWithFormat:@"平均速度 ：%.2f",_distanceInAll / _timeInAll];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.labelValues.alpha = 1.0;
            self.labelDates.alpha = 1.0;
        } completion:nil];
    }];
    
}



#pragma mark - textFeild代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    if (![self.textField.text isEqualToString:@""]) {
        _side = [self.textField.text intValue];
    }
    else _side = 40;
    NSLog(@"%d",_side);
    
    return YES;
}



@end
