//
//  MoreViewController.m
//  GoFit
//
//  Created by EMPty on 11/29/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "MoreViewController.h"
#import "LoginViewController.h"
#define STATE_HEIGHT 20
#define BANNER_HEIGHT 150
#define BUTTONVIVW_HEIGHT 45
@interface MoreViewController ()
{
    UIView* _banner;
    UIView* _buttonView;
    UITableView* _tableView;
    NSArray* _tableViewDataSource;
}
@end

@implementation MoreViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"更多");

    [self initBanner];
    [self initTableView];
        

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 初始化banner
- (void)initBanner
{
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationItem setTitle:@"我的"];
//    self.navigationController.navigationBarHidden = YES;
    _banner = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, STATE_HEIGHT + self.navigationController.navigationBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, BANNER_HEIGHT)];
    _banner.backgroundColor = [UIColor redColor];
    
//    _banner.backgroundColor = [UIColor yellowColor];
    UIImageView* bannerBackgroundImage = [[UIImageView alloc]initWithFrame:_banner.bounds];
    NSString* backgroundImagePath = [[NSBundle mainBundle]pathForResource:@"bannerBackground" ofType:@"jpg"];
    UIImage* backgroundImage = [UIImage imageWithContentsOfFile:backgroundImagePath];
    bannerBackgroundImage.image = backgroundImage;
    
    
    [_banner addSubview:bannerBackgroundImage];
    
    [self.view addSubview:_banner];
//    UIViewController* a = [[UIViewController alloc]init];
//    [self.navigationController pushViewController:a animated:YES];
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, _banner.bounds.size.height - BUTTONVIVW_HEIGHT, _banner.bounds.size.width, BUTTONVIVW_HEIGHT)];
    _buttonView.backgroundColor = [UIColor colorWithRed:106.0/255.0 green:106.0/255.0 blue:106.0/255.0 alpha:0.5];
    
    NSMutableArray *imageDataArray = [[NSMutableArray alloc]init];
    NSString* buttonImagesPath = [[NSBundle mainBundle]pathForResource:@"MyButtonImages" ofType:@"plist"];
    NSArray* buttonImages = [NSArray arrayWithContentsOfFile:buttonImagesPath];
    
    
    //取出图片
    for (int i =0 ; i < buttonImages.count; ++i) {
        NSString* imagePath =   [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",buttonImages[i]]   ofType:nil];
        UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
        [imageDataArray addObject:image];
        
    }
    NSLog(@"%@",imageDataArray);
    NSArray* buttonText = @[@"我的动态",@"我的照片",@"我的记录",@"我的故事"];
    
    for (int i = 0; i < imageDataArray.count ; ++i) {
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(_buttonView.frame.size.width / imageDataArray.count * i,_buttonView.bounds.origin.y + 3, _buttonView.frame.size.width / imageDataArray.count, _buttonView.frame.size.height / 3 * 2)];
        [button setImage:imageDataArray[i] forState:UIControlStateNormal];
        button.tag = i;
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonView addSubview:button];
        UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(_buttonView.frame.size.width / imageDataArray.count * i,_buttonView.bounds.origin.y + 2 + button.frame.size.height, _buttonView.frame.size.width / imageDataArray.count, _buttonView.frame.size.height / 3 )];
        lable.text = buttonText[i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont systemFontOfSize:10.0];
        [_buttonView addSubview:lable];

    }
    
    [_banner addSubview:_buttonView];
    

    UIButton* icon = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 60, 60)];
    [icon addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UIImage* iconImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon" ofType:@"png"]];
    [icon setImage:iconImage forState:UIControlStateNormal];
    [_banner addSubview:icon];
    UILabel* name = [[UILabel alloc]initWithFrame:CGRectMake(icon.frame.origin.x + icon.bounds.size.width + 5, icon.frame.origin.y, 70, 30)];
    name.text = @"方虎";
    name.textColor = [UIColor whiteColor];
    [_banner addSubview:name];
}

#pragma mark 响应按钮动作
- (void)buttonAction:(UIButton*) button
{
    NSLog(@"按下了%d号按钮",button.tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    LoginViewController* log = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:log animated:YES];
}

- (void)initTableView
{
    float tableViewX = self.view.bounds.origin.x;
    float tableViewY = STATE_HEIGHT + self.navigationController.navigationBar.bounds.size.height + _banner.bounds.size.height;
    float tableViewWidth = [UIScreen mainScreen].bounds.size.width;
    float tableViewHeight = [UIScreen mainScreen].bounds.size.height - STATE_HEIGHT - self.navigationController.navigationBar.bounds.size.height - _banner.bounds.size.height - self.tabBarController.tabBar.bounds.size.height;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.bounces = NO;
    _tableView.bouncesZoom = NO;
    NSString* tableViewDataSource = [[NSBundle mainBundle] pathForResource:@"MyTableViewData" ofType:@"plist"];
    _tableViewDataSource = [NSArray arrayWithContentsOfFile:tableViewDataSource];
    
//    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
//    _tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    _tableView.sectionIndexBackgroundColor = [UIColor blueColor];
    _tableView.sectionIndexTrackingBackgroundColor = [UIColor greenColor];
    [self.view addSubview:_tableView];
//    UIViewController* a = [[UIViewController alloc]init];
//    [self.navigationController pushViewController:a animated:YES];
    
}



#pragma  mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* inSection = _tableViewDataSource[section];
    return inSection.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableViewDataSource.count;
}

- (float) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
    
}

- (float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    NSArray* sectionData = _tableViewDataSource[indexPath.section];
    NSDictionary* rowData = sectionData[indexPath.row];
    UIImage* cellImage = [UIImage imageNamed:[rowData objectForKey:@"image"]];
    //隐藏系统的imageView 添加紫的imageView
    cell.imageView.hidden = YES;
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [cell addSubview:cellImageView];
    cellImageView.image = cellImage;
    //隐藏textlable 添加自己的
    cell.textLabel.hidden = YES;
    UILabel* textLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, cell.frame.size.width - 10, cell.frame.size.height)];
    textLable.text = [rowData objectForKey:@"text"];
    [cell addSubview:textLable];
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [cell.imageView setFrame:CGRectMake(0, 0, 10, 10)];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
    
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
