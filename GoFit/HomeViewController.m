//
//  HomeViewController.m
//  GoFit
//
//  Created by EMPty on 11/29/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNewsModel.h"
#import "HomeNewsTableViewCell.h"
#import "QRCodeViewController.h"
#import "MJRefresh.h"
#import "EMPUtils.h"
//#define DrugTableViewData @"DrugTableViewData.plist"
//#define ToolTableViewData @"ToolTableViewData.plist"
//#define GymTableViewData @"GymTableViewData.plist"
#define HomeBannerImages @"HomeBannerImages.plist"
#define HomeNewsData @"HomeNewsData.plist"
#import <HYBLoopScrollView.h>
//#import "LoginViewController.h"
#import "DetailedInfoViewController.h"
#import "CategoryTableViewCell.h"
#import "HomeNewsViewController.h"
#define STATE_HEIGHT 20


#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"
#import "ScanViewController.h"

@interface HomeViewController ()
{
    UITableView* _tableView;
    UIView* _banner;
    UIPageControl* _page;
    UIScrollView* _scrollImage;
    NSArray* _homeNewsData;
    NSArray* _kind;
    NSArray* _title;
    
    HYBLoopScrollView*  _loob;
}
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];

//    self.hidesBottomBarWhenPushed = YES;
//    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _kind = @[@"食品",@"健康",@"肌肉",@"瑜伽",@"马云"];
    _title = @[@"健康饮食",@"全方位热身",@"腹肌工厂",@"延展体态",@"健身误区"];
    
//    UILabel * l = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 50, 32)];
//    
//    [self.view addSubview:l];
    
    
//    self.hidesBottomBarWhenPushed = YES;
    

//    DetailedInfoViewController* login = [[DetailedInfoViewController alloc]init];
//    [self.navigationController pushViewController:login animated:YES];
    
    [self initWithBanner];
    [self initWithTableView];
    self.navigationItem.title = @"GoFit";
  
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self initCodeButton];
    [self initHomeNewsData];
    
    NSLog(@"首页");
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initCodeButton
{
    UIButton* codebutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [codebutton setImage:[UIImage imageNamed:@"code.png"] forState:UIControlStateNormal];
    [codebutton addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:codebutton];//为导航栏左侧添加系统自定义按钮

    UIButton* chartbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [chartbutton setImage:[UIImage imageNamed:@"chart.png"] forState:UIControlStateNormal];
    [chartbutton addTarget:self action:@selector(chartAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chartbutton];//为导航栏左侧添加系统自定义按钮

}

#pragma mark 二维码按钮
- (void)codeAction
{
    NSLog(@"显示二维码");
//    QRCodeViewController* temp = [[QRCodeViewController alloc]init];
//
//    [self presentViewController:temp animated:YES completion:nil];
    
    
    
//    NSMutableArray *obj = [NSMutableArray array];
    
//    for (NSInteger i = 0; i < [self titles].count; i++) {
//        
//        WBPopMenuModel * info = [WBPopMenuModel new];
//        info.image = [self images][i];
//        info.title = [self titles][i];
//        [obj addObject:info];
//    }
    
    [[WBPopMenuSingleton shareManager]showPopMenuSelecteWithFrame:180
                                                             item:nil
                                                           action:nil];

    
    
}

#pragma mark - 记录视图
- (void)chartAction
{
    NSLog(@"go");
    ScanViewController* scan = [[ScanViewController alloc]init];
    [self.navigationController pushViewController:scan animated:YES];
    
    
}

- (void)initHomeNewsData
{
//    _homeNewsData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeNewsData" ofType:@"plist"]];
    _homeNewsData = [EMPUtils readFile:HomeNewsData];
                     
}

- (void)initWithBanner
{
    
    NSMutableArray* imageUrls = [NSMutableArray array];
    
    float bannerHeight = 160;
    //为了适配设备
   _banner = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, bannerHeight)];
    _scrollImage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, bannerHeight)];
    _banner.backgroundColor = [UIColor whiteColor];


    [_banner addSubview:_scrollImage];

    _scrollImage.showsHorizontalScrollIndicator = NO;
    _scrollImage.showsVerticalScrollIndicator = NO;
    _scrollImage.delegate = self;
    _scrollImage.pagingEnabled = YES;
    _scrollImage.bouncesZoom = NO;
    
    
    
    NSMutableArray *imageDataArray = [[NSMutableArray alloc]init];
//    NSString* bannerImagesPath = [[NSBundle mainBundle]pathForResource:@"HomeBannerImages" ofType:@"plist"];
//    NSArray* bannerImages = [NSArray arrayWithContentsOfFile:bannerImagesPath];
    NSArray* bannerImages = [EMPUtils readFile:HomeBannerImages];
    
    _scrollImage.contentSize = CGSizeMake(_banner.frame.size.width * bannerImages.count, _banner.frame.size.height);
    
    //取出图片
    for (int i =0 ; i < bannerImages.count; ++i) {
        NSString* imagePath =   [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",bannerImages[i]]   ofType:nil];
        UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
        [imageDataArray addObject:image];
//        NSURL* imageUrl = [[NSURL alloc]initFileURLWithPath:imagePath];
//        NSString* a = imageUrl.absoluteString;
//        NSLog(@"URL:%@   String：%@",imageUrl,a);
        [imageUrls addObject:image];
//        NSLog(@"%@",imageUrl);
        
    }
    
    for (int i = 0; i < bannerImages.count; ++i) {
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _banner.frame.size.width, 0, _banner.frame.size.width, _banner.frame.size.height)];
        NSLog(@"x=%f   y=%f   w=%f   h=%f",imageView.frame.origin.x,imageView.frame.origin.y,imageView.frame.size.width,imageView.frame.size.height);
        imageView.image = imageDataArray[i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_scrollImage addSubview:imageView];
        
    }
   

    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(0,_banner.frame.size.height - 20,[UIScreen mainScreen].bounds.size.width,20)];
    NSLog(@"%f",_banner.bounds.size.width);
    _page.numberOfPages = imageDataArray.count;
    _page.currentPage = 0;
    _page.backgroundColor = [UIColor clearColor];
    [_banner addSubview:_page];
    //切换banner
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImage)
                                   userInfo:nil repeats:YES];

    
    
    
   _loob = [HYBLoopScrollView loopScrollViewWithFrame:_banner.frame imageUrls:[NSArray arrayWithArray:imageUrls]];
    _loob.timeInterval = 3;
    _loob.alignment = kPageControlAlignCenter;

//    [self.view addSubview:_loob];

}

- (void)changeImage
{
    
    //当前偏移点
    CGPoint currentOffset = _scrollImage.contentOffset;
    //下一屏的偏移点
    CGPoint newOffset = CGPointMake(currentOffset.x + self.view.bounds.size.width, 0);
    _page.currentPage ++;
    //判断是不是最后一屏
    if (currentOffset .x + self.view.bounds.size.width == _scrollImage.contentSize.width) {
        //是最后一屏
        newOffset = CGPointZero;
        _page.currentPage = 0;
    }
    [_scrollImage setContentOffset: newOffset animated:YES];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:NSClassFromString(@"UIScrollView")]) {
        NSInteger currentPage = (NSInteger)scrollView.contentOffset.x / _page.frame.size.width;
        _page.currentPage = currentPage;
        [_page updateCurrentPageDisplay];
    }
}

- (void)initWithTableView
{
    //iOS7里面会自动向下偏移64点，要把这个自动偏移关闭 lol
    self.automaticallyAdjustsScrollViewInsets = NO;

    float tarBarHeight = self.tabBarController.tabBar.frame.size.height;
    float stateHeight = STATE_HEIGHT;
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    float tableViewX = 0;
    float tableViewY = navigationBarHeight + stateHeight;
    //适配设备啊
    float tableViewWidth = [UIScreen mainScreen].bounds.size.width;
    float tableViewHeight = [UIScreen mainScreen].bounds.size.height - stateHeight - navigationBarHeight - tarBarHeight;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bouncesZoom = NO;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.tableHeaderView = _banner;
        _tableView.tableHeaderView = _loob;

    
   
    

}

#pragma maek - tableView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _homeNewsData.count;
    return 5;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [HomeNewsTableViewCell homeNewsCellHeight];
    return 150 + 10;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#pragma mark - 之前的cell类型
    /*
    HomeNewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[HomeNewsTableViewCell ID]];
    if (cell == nil) {
        cell = [[HomeNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HomeNewsTableViewCell ID]];
        
    }
    NSArray* temp = _homeNewsData[indexPath.row];
    cell.homeNewsModel = [[HomeNewsModel alloc]initWithDic:temp];
    cell.title.tag = indexPath.row + 1;
    
    NSLog(@"tag:%d",cell.title.tag);
    return cell;
    */
    
#pragma mark - 改成大类
    CategoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[HomeNewsTableViewCell ID]];
    if (cell == nil) {
        cell = [[CategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HomeNewsTableViewCell ID]];
//        NSLog(@"%d",indexPath.row);
    }
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"category%d.png",indexPath.row+1]];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeNewsViewController* homeViewController = [[HomeNewsViewController alloc]init];
    homeViewController.kind = _kind[indexPath.row];
//    self.hidesBottomBarWhenPushed = YES;
    homeViewController.title = _title[indexPath.row];
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeViewController animated:YES];
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
