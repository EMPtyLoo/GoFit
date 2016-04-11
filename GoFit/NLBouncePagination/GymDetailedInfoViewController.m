//
//  GymDetailedInfoViewController.m
//  GoFit
//
//  Created by EMPty on 3/5/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "GymDetailedInfoViewController.h"
#import "GymSubDetailedInfoViewController.h"
#import "MyAnnotation.h"
#define side 10

@interface GymDetailedInfoViewController ()
{
     UIView* _headView;
    MKMapView* _images;
    CLLocationCoordinate2D _currentLocation;
    CLLocationCoordinate2D _targetLocation;

}
@end

@implementation GymDetailedInfoViewController


- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden = YES;

        //导航栏隐藏
        self.navigationController.navigationBarHidden = YES;
        //        self.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden = YES;
        //    self.navigationController.t
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getCurrentLocationInfo];
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    //    [self initDock];
    self.tableView.scrollsToTop = YES;

    [self initHeadView];
    //    self.tableView.backgroundColor = [UIColor grayColor];
    
    self.subTableViewController = [[GymSubDetailedInfoViewController alloc] init];
    
    
}


- (void)getCurrentLocationInfo
{
    //获取当前位置
    MKMapItem *mylocation = [MKMapItem mapItemForCurrentLocation];
    
    //当前经维度
    float currentLatitude=mylocation.placemark.location.coordinate.latitude;
    float currentLongitude=mylocation.placemark.location.coordinate.longitude;
    
    _currentLocation = CLLocationCoordinate2DMake(currentLatitude,currentLongitude);
}
//- (void)initDock
//{
//    _dock = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40 - 20, [UIScreen mainScreen].bounds.size.width, 48)];
//    _dock.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_dock];
//}

- (void)initHeadView
{
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400)];
   
    
#pragma mark - 地图 还不是很清楚
    _images = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400)];
    _images.delegate = self;
    _images.showsUserLocation = YES;
    _images.mapType = MKMapTypeHybrid;
    
    //经纬度  先维度 在经度
    CLLocationCoordinate2D coor2d = {30.26,120.19};
    _targetLocation = coor2d;
    //显示精度范围
    MKCoordinateSpan span = {0.01,0.01};
    //结构体 第一个坐标 第二个显示范围  越小精度越高
    //地图初始化时显示的区域
    MKCoordinateRegion region = {coor2d,span};
    //给地图设置显示区域
    [_images setRegion:region animated:YES];
    
    MyAnnotation* annotation1 = [[MyAnnotation alloc]initWithCoordinate2D:coor2d];
    annotation1.title = @"某不知名牛掰健身房";
    annotation1.subtitle = [NSString stringWithFormat:@"坐标：%f  ,%f",coor2d.latitude,coor2d.longitude];

    
                                        
    [_images addAnnotation:annotation1];

    [_images selectAnnotation:annotation1 animated:YES];
    [_headView addSubview:_images];
    
    
    UIButton* backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    [backButton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
#warning 返回键没有做好

    [self.tableView addSubview:backButton];
    
    UILabel* des = [[UILabel alloc]initWithFrame:CGRectMake(side, _images.frame.size.height + side, [UIScreen mainScreen].bounds.size.width - 2 * side, 35)];
    des.text = @"最牛掰的健身房";
    des.font = [UIFont systemFontOfSize:14];
    des.numberOfLines = 0;
    des.frame = CGRectMake(side, _images.frame.size.height + side, [UIScreen mainScreen].bounds.size.width - 2 * side, [self heightForString:des.text fontSize:14 andWidth:[UIScreen mainScreen].bounds.size.width - 2 * side]);
    [_headView addSubview:des];
    
    UILabel* price = [[UILabel alloc]initWithFrame:CGRectMake(des.frame.origin.x, des.frame.origin.y + des.frame.size.height + 5, des.frame.size.width / 5, des.frame.size.height)];
    price.font = [UIFont systemFontOfSize:18];
    price.textColor = [UIColor orangeColor];
    price.text = @"¥998";
    price.frame = CGRectMake(des.frame.origin.x,  des.frame.origin.y + des.frame.size.height + 5, [UIScreen mainScreen].bounds.size.width - 2 * side, [self heightForString:price.text fontSize:18 andWidth:[UIScreen mainScreen].bounds.size.width - 2 * side]);
    //    price.backgroundColor = [UIColor orangeColor];
    [_headView addSubview:price];
    
    UIButton* buy = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - side - 70 , price.frame.origin.y, 70 , price.frame.size.height)];
    [buy setTitle:@"立即购买" forState:UIControlStateNormal];
    buy.titleLabel.font = [UIFont systemFontOfSize:13];
    buy.backgroundColor = [UIColor redColor];
    buy.titleLabel.textColor = [UIColor whiteColor];
    [buy addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:buy];
    
    UIButton* cart = [[UIButton alloc]initWithFrame:CGRectMake(buy.frame.origin.x - buy.frame.size.width , buy.frame.origin.y, buy.frame.size.width, buy.frame.size.height)];
    [cart setTitle:@"加入购物车" forState:UIControlStateNormal];
    cart.titleLabel.font = [UIFont systemFontOfSize:13];
    
    cart.backgroundColor = [UIColor orangeColor];
    cart.titleLabel.textColor = [UIColor whiteColor];
    [cart addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:cart];
    
    
    
    
    
    
    
    UILabel* send = [[UILabel alloc]initWithFrame:CGRectMake(price.frame.origin.x, price.frame.origin.y + price.frame.size.height, des.frame.size.width / 3, 40)];
    send.textColor = [UIColor lightGrayColor];
    send.text = @"快递：免运费";
    send.font = [UIFont systemFontOfSize:13];
    
    [_headView addSubview:send];
    
    UILabel* count = [[UILabel alloc]initWithFrame:CGRectMake(send.frame.origin.x + send.frame.size.width , send.frame.origin.y, send.frame.size.width, send.frame.size.height)];
    count.textColor = [UIColor lightGrayColor];
    count.text = @"月销1000币";
    count.font = [UIFont systemFontOfSize:13];
    count.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:count];
    
    UILabel* from = [[UILabel alloc]initWithFrame:CGRectMake(count.frame.origin.x + send.frame.size.width , count.frame.origin.y, count.frame.size.width, count.frame.size.height)];
    from.textColor = [UIColor lightGrayColor];
    from.text = @"浙江杭州";
    from.font = [UIFont systemFontOfSize:13];
    from.textAlignment = NSTextAlignmentRight;
    [_headView addSubview:from];
    
    _headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, send.frame.origin.y + send.frame.size.height + 5) ;
    self.tableView.tableHeaderView = _headView;
    
    
}

- (void)cartAction
{
    NSLog(@"购物车");
    
}

- (void)buyAction
{
    NSLog(@"立即购买");
    
}

- (void)backAction
{
//    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//获取字符串的宽度
-(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}
//获得字符串的高度
-(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
        {
            
            return 2;
            break;
        }
            
        case 1:
        {
            
            return 1;
            break;
        }
            
        case 2:
        {
            
            return 1;
            break;
        }
            
        case 3:
        {
            
            return 1;
            break;
        }
            
        default:
            return 0;
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 30;
            break;
        }
        case 1:
        {
            return 30;
            break;
        }
        case 2:
        {
            return 50;
            break;
        }
        case 3:
        {
            return 50;
            break;
        }
        default:
            break;
    }
    return 0;
}


- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cellname";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    //    [cell setBackgroundColor:[UIColor lightGrayColor]];
    
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0 ) {
                
                cell.textLabel.text = @"卖家承诺24小时内发货    7天无理由";
                cell.textLabel.font = [UIFont systemFontOfSize:10];
                cell.selectionStyle = NO;
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
            }
            else
            {
                cell.textLabel.text = @"领取优惠券";
                cell.textLabel.font = [UIFont systemFontOfSize:10];
                cell.selectionStyle = NO;
                cell.textLabel.textColor = [UIColor lightGrayColor];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 1:
        {
            cell.selectionStyle = NO;
            cell.textLabel.text = @"已选：白色现货";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        }
        case 2:
        {
            cell.selectionStyle = NO;
            cell.textLabel.text = @"宝贝评价（255）";
            
            break;
        }
        case 3:
        {
            cell.selectionStyle = NO;
            cell.textLabel.text = @"店家信息";
            
            break;
        }
        default:
            break;
    }
    
    
    return cell;
}


#pragma mark - mapKit委托方法
//返回标注视图（大头针视图）
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //判断是否为当前位置的Annotation 不是变成pin
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //强转到大头针视图类
    MKPinAnnotationView* pin = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:[MyAnnotation reusedID]];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[MyAnnotation reusedID]];
        
    }
    //设置大头针的颜色
    pin.pinColor = MKPinAnnotationColorGreen;
    //设置从天尔降的动画
    pin.animatesDrop= YES;
    //显示设置的标题
    pin.canShowCallout = YES;
    
    //右边加上一个按钮 也可以加在左边
    UIButton* go = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [go addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    pin.rightCalloutAccessoryView = go;
    
    return pin;

}

- (void)goAction
{
    UIActionSheet* go = [[UIActionSheet alloc]initWithTitle:@"导航" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"出发去这里", nil];
    [go showInView:self.view];
    
    
}

#pragma mark - ActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"出发去目的地");
            [self goToTheGym];
            
            break;
        }
        default:
            break;
    }
}

- (void)goToTheGym
{
//    // ios6以下，调用google map
//    if (SYSTEM_VERSION_LESS_THAN(@"6.0"))
//    {
//        NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d", coords1.latitude,coords1.longitude,coords2.latitude,coords2.longitude];
//        NSURL *aURL = [NSURL URLWithString:urlString];
//        //打开网页google地图
//        [[UIApplication sharedApplication] openURL:aURL];
//    }
//    else
        // 直接调用ios自己带的apple map
//    {
        //当前的位置
        MKMapItem *currentLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:_currentLocation addressDictionary:nil]];
        //起点
        //MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
        //目的地的位置
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_targetLocation addressDictionary:nil]];
        
        toLocation.name = @"目的地";
    
        
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];
//    }
}

@end

