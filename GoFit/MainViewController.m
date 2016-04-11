//
//  ViewController.m
//  GoFit
//
//  Created by EMPty on 11/29/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "MainViewController.h"
#import "EMPUtils.h"
#define NUMBER_OF_BUTTON_AT_TARBAR 4
#define DrugTableViewData @"DrugTableViewData.plist"
#define ToolTableViewData @"ToolTableViewData.plist"
#define GymTableViewData @"GymTableViewData.plist"
#define HomeBannerImages @"HomeBannerImages.plist"
#define HomeNewsData @"HomeNewsData.plist"
#define DiscoverData @"DiscoverData.plist"

#import "SDTimeLineTableViewController.h"

@interface MainViewController ()
{
//    UIView* _tarBar;
    HomeViewController* _homeVC;
    DealViewController* _dealVC;
    MyViewController* _myVC;
    MoreViewController* _moreVC;
    SDTimeLineTableViewController* _timelineVC;
    UIButton* _lastPick;
    DCPathButton *dcPathButton;
}
@end

@implementation MainViewController

//- (void)hideTarbar:(BOOL)a
//{
//    _tarBar.hidden = a;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([self firstLaunch]) {
    //plist文件写入沙盒
    [EMPUtils dealWithFirstInfo:DrugTableViewData];
    [EMPUtils dealWithFirstInfo:ToolTableViewData];
    [EMPUtils dealWithFirstInfo:GymTableViewData];
    [EMPUtils dealWithFirstInfo:HomeBannerImages];
    [EMPUtils dealWithFirstInfo:HomeNewsData];
    [EMPUtils dealWithFirstInfo:DiscoverData];
//    }
    
//    [self initDCPathButton];
    
//      self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(codeAction)];//为导航栏左侧添加系统自定义按钮

    [self initViewControllers];

    [self intTabBarView];
    
//    [self.view addSubview:dcPathButton];

}

//- (BOOL)firstLaunch
//{
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
//        return YES;
//    }else{
//        return NO;
//    }
//}

//- (void)dealWithFirstInfo
//{
//    //读取plist
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"DrugTableViewData.plist" ofType:nil];
//    NSArray*  DrugData = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"%@",DrugData);
//    //获取应用程序沙盒程序的Documents目录
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* plistPath = [paths objectAtIndex:0];
//    
//    //得到完整的文件名
//    NSString* filename = [plistPath stringByAppendingPathComponent:DrugTableViewData];
//    //输入写入
//    [DrugData writeToFile:filename atomically:YES];
//    
//}


- (void)initViewControllers
{
    
    _homeVC = [[HomeViewController alloc]init];
    _dealVC = [[DealViewController alloc]init];
    _myVC = [[MyViewController alloc]init];
    _moreVC = [[MoreViewController alloc]init];
    
    _timelineVC = [[SDTimeLineTableViewController alloc]init];
    
    UINavigationController* _homeNaVC = [[UINavigationController alloc]initWithRootViewController:_homeVC];
     UINavigationController* _dealNaVC = [[UINavigationController alloc]initWithRootViewController:_dealVC];
//     UINavigationController* _myNaVC = [[UINavigationController alloc]initWithRootViewController:_myVC];
    
    UINavigationController* _myNaVC = [[UINavigationController alloc]initWithRootViewController:_timelineVC];

    
    
     UINavigationController* _moreNaVC = [[UINavigationController alloc]initWithRootViewController:_moreVC];
    
    
    
//    
//    UIButton* code = [UIButton buttonWithType:UIButtonTypeCustom];
//    [code sizeToFit];
//    code.frame = CGRectMake(0, 0, 30, 30);
//    [code setTintColor:[UIColor blackColor]];
//    //    [code setImage:[UIImage imageNamed:@"code.png"] forState:UIControlStateNormal];
//    [code setTitle:@"二维码" forState:UIControlStateNormal];
//    [code addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem* codeItem = [[UIBarButtonItem alloc]initWithCustomView:code];
//
//    self.navigationItem.backBarButtonItem = codeItem;
    
    
    //设置导航栏颜色
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:253.0/255.0 green:148.0/255.0 blue:24.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    
   NSArray *navigationControllerArray = [NSArray arrayWithObjects:_homeNaVC,_dealNaVC,_myNaVC,_moreNaVC, nil];
    self.viewControllers = navigationControllerArray;
    
//    self.tabBar.hidden = YES;

}


//- (void)codeAction
//{
//    NSLog(@"显示二维码");
//}


- (void)intTabBarView
{
//    _tarBar = [[UIView alloc]initWithFrame:self.tabBar.frame];
    
    _tarBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];

    
//    _tarBar = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width, 80)];

    
    
//    self.tabBar = (UITabBar*)_tarBar;

//    _tarBar.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:148.0/255.0 blue:24.0/255.0 alpha:1.0];
    
    _tarBar.backgroundColor = [UIColor whiteColor];

    
    NSArray* imagesOfButtonWhenDidNotSelected = @[@"home_tarBar_Normal",@"deal_tarBar_Normal",@"discover_tarBar_Normal",@"my_tarBar_Normal"];

//    NSArray* textOfButtonWhenDidNotSelected = @[@"推荐",@"商家",@"发现",@"更多"];
//    NSArray* textOfButtonSelected = @[@"选中推荐",@"选中商家",@"选中发现",@"选中更多"];
    
    NSArray* imagesOfButtonWhenDidSelected = @[@"home_tarBar_Selected",@"deal_tarBar_Selected",@"discover_tarBar_Selected",@"my_tarBar_Selected"];

    
    
    
    float wirthOfButton = _tarBar.frame.size.width / NUMBER_OF_BUTTON_AT_TARBAR;
    float heightOfButton = _tarBar.frame.size.height;
    for (int i = 0; i < NUMBER_OF_BUTTON_AT_TARBAR; ++i) {
        UIButton* b = [[UIButton alloc]initWithFrame:CGRectMake(_tarBar.frame.origin.x + i * wirthOfButton, 0, wirthOfButton, heightOfButton)];
        
//        [b setTitle:textOfButtonWhenDidNotSelected[i] forState:UIControlStateNormal];
        
        NSString* imapath =[[NSBundle mainBundle]pathForResource:imagesOfButtonWhenDidNotSelected[i] ofType:@"png"];
        NSLog(@"%@",imapath);
        UIImage *ima = [[UIImage alloc]initWithContentsOfFile:imapath];
        NSLog(@"%@",ima);
        b.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
//        UIImage *ima = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imagesOfButtonWhenDidNotSelected[i] ofType:nil]];
        [b setImage:[UIImage imageNamed:imagesOfButtonWhenDidNotSelected[i]] forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:imagesOfButtonWhenDidSelected[i]] forState:UIControlStateSelected];
//        [b setTitle:textOfButtonSelected[i] forState:UIControlStateSelected];
//        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [b setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [b addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        b.tag = i;
        
        [_tarBar addSubview:b];
        if (i == 0) {
            _lastPick = b;
        }
    }
    
//    [self.view addSubview:_tarBar];
    
    
    //系统的tabbar上添加自定义的tarbar  这样可以用系统的方法将tabbar隐藏
    
    [self.tabBar addSubview:_tarBar];
    _lastPick.selected = YES;
    self.selectedIndex = 0;
    
}

- (void)tabBarButtonAction:(UIButton*) b
{
    NSLog(@"%d",b.tag);
    if (_lastPick != b) {
        //取消选中效果
        _lastPick.selected = NO;
    }
    _lastPick = b;
    //选中当前按钮
    b.selected = YES;
    
    self.selectedIndex =
    b.tag ;

}

#pragma mark - DCPathButton
- (void)initDCPathButton
{
    // Configure center button
    //
//    dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
//                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    
     dcPathButton = [[DCPathButton alloc]initWithButtonFrame:CGRectMake(0, 0, 20,_tarBar.frame.size.height) centerImage:[UIImage imageNamed:@"chooser-button-tab"] highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    dcPathButton.delegate = self;
    
    // Configure item buttons
    //
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 itemButton_5
                                 ]];
    
    // Change the bloom radius, default is 105.0f
    //
    dcPathButton.bloomRadius = 120.0f;
    
    // Change the DCButton's center
    //
    dcPathButton.dcButtonCenter = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 25.5f);
    
    // Setting the DCButton appearance
    //
//    dcPathButton.allowSounds = YES;
    dcPathButton.allowCenterButtonRotation = YES;
    
    dcPathButton.bottomViewColor = [UIColor grayColor];
    
    dcPathButton.bloomDirection = kDCPathButtonBloomDirectionTop;
    
//    [self.navigationBar addSubview:dcPathButton];

}


#pragma mark - DCPathButton Delegate

- (void)willPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton will present");
    
}

- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    NSLog(@"You tap %@ at index : %lu", dcPathButton, (unsigned long)itemButtonIndex);
}

- (void)didPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton did present");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
