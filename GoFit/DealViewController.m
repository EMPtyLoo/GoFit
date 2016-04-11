//
//  DealViewController.m
//  GoFit
//
//  Created by EMPty on 11/29/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "DealViewController.h"
#import "GymTableViewCell.h"
#import "DrugTableViewCell.h"
#import "DetailedInfoViewController.h"
#import "GymDetailedInfoViewController.h"

#import "EMPUtils.h"
#define DrugTableViewData @"DrugTableViewData.plist"
#define ToolTableViewData @"ToolTableViewData.plist"
#define GymTableViewData @"GymTableViewData.plist"
//#define HomeBannerImages @"HomeBannerImages.plist"
//#define HomeNewsData @"HomeNewsData.plist"
//#define DiscoverData @"DiscoverData.plist"



//#import "MJRefresh.h"
#define STATE_HEIGHT 20
#define SEGEMENGT_CONTROL_HEIGHT 40
@interface DealViewController ()
{
    UITableView* _tableView;
    UITableView* _toolTableView;
    UITableView* _drogTableView;
    UIView* _segementControl;
    
    UISegmentedControl* _sgControl;
    
    UIScrollView* _scrollView;
    NSArray* _tableViewArray;
    UIButton* _lastChosenSegementButton;
    NSArray* _gymTableViewData;
    NSArray* _drugTableViewData;
    NSArray* _toolTableViewData;
    int tagg ;

}
@end

@implementation DealViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    tagg = 0;
    [self initGymTableViewData];
    [self initDrugTableViewData];
    [self initToolTableViewData];
    [self initSegementControl];
    [self initScrollView];
    [self initCartButton];
    
    NSLog(@"商家");
    
//    UITableView* t = [[UITableView alloc]initWithFrame:self.view.bounds];
//    [t addHeaderWithTarget:self action:@selector(aaaa)];
//    [_scrollView addSubview:t];
}


- (void)initCartButton
{
    UIButton* cartButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cartButton];//为导航栏左侧添加系统自定义按钮
    
    UIButton* searchButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [searchButton setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];

    
}


- (void)cartAction
{
    NSLog(@"购物车");
}

- (void)searchAction
{
    NSLog(@"搜索");
}

- (void)initGymTableViewData
{
//    _gymTableViewData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"GymTableViewData" ofType:@"plist"]];
    _gymTableViewData = [EMPUtils readFile:GymTableViewData];
    NSLog(@"%@",_gymTableViewData[0]);
    
}


- (void)initDrugTableViewData
{
//    _drugTableViewData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DrugTableViewData" ofType:@"plist"]];
//    NSLog(@"%@",_drugTableViewData);
    _drugTableViewData = [EMPUtils readFile:DrugTableViewData];
    NSLog(@"%@",_drugTableViewData);
}

- (void)initToolTableViewData
{
//    _toolTableViewData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ToolTableViewData" ofType:@"plist"]];
    
    _toolTableViewData = [EMPUtils readFile:ToolTableViewData];
    NSLog(@"%@",_toolTableViewData);
}

- (void)initScrollView
{
    float scrollViewX = 0;
    float scrollViewY = self.navigationController.navigationBar.frame.size.height + STATE_HEIGHT;
    NSLog(@"%f",scrollViewY);
    float scrollViewWidth = [UIScreen mainScreen].bounds.size.width;
    float scrollViewHeight = [UIScreen mainScreen].bounds.size.height - STATE_HEIGHT - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    NSLog(@"%f",scrollViewHeight);
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(scrollViewX, scrollViewY, scrollViewWidth, scrollViewHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(scrollViewWidth * 3, scrollViewHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    [self initWithTableView];

}

- (void)initSegementControl
{
    NSArray* sgTitle = [NSArray arrayWithObjects:@"健身房",@"器械",@"补剂", nil];
    _sgControl = [[UISegmentedControl alloc]initWithItems:sgTitle];
    _sgControl.frame = CGRectMake(60, 10,  self.navigationController.navigationBar.frame.size.width - 120, self.navigationController.navigationBar.frame.size.height/2);
    [_sgControl setSelectedSegmentIndex:0];
    _sgControl.tintColor = [UIColor whiteColor];
    [_sgControl addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventValueChanged];
//    _sgControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.navigationController.navigationBar addSubview:_sgControl];
    
    
    
    
    
    
    /*
    
    
    _segementControl = [[UIView alloc]initWithFrame:CGRectMake(0, STATE_HEIGHT + self.navigationController.navigationBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, SEGEMENGT_CONTROL_HEIGHT)];
    [self.view addSubview:_segementControl];
    _segementControl.backgroundColor = [UIColor whiteColor];
    NSArray* segementButton = @[@"健身房",@"器械",@"补剂"];
    for (int i = 0; i < 3; ++i) {
        float buttonWidth = _segementControl.frame.size.width / segementButton.count;
        UIButton* segement = [[UIButton alloc]initWithFrame:CGRectMake(i * buttonWidth, 0 , buttonWidth, _segementControl.frame.size.height)];
        [segement setTitle:segementButton[i] forState:UIControlStateNormal];
        [segement setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [segement setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        segement.tag = i + 1;
        //在iphone中,0是作为唯一的保留标记出现的，这是所有新建视图的默认属性。所以当tag值设定为0时，系统无法识别是你自己创建的View还是系统的默认View，所以就引起XCODE的崩溃现象了
        if (i == 0) {
            segement.selected =  YES;
            _lastChosenSegementButton = segement;
        }
        [segement addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventTouchUpInside];
        [_segementControl addSubview:segement];
        NSLog(@"%@",segement);
        
    }
    
//    _segementControl.hidden = YES;
     */
}

- (void)segementAction:(UIButton*)button
{
    if (button != _lastChosenSegementButton) {
        button.selected = YES;
        _lastChosenSegementButton.selected = NO;
        _lastChosenSegementButton = button;
        [_scrollView setContentOffset:CGPointMake((button.tag - 1) * _scrollView.frame.size.width, 0) animated:YES];

    }
    NSLog(@"%d号按钮按下",button.tag);
}

- (void)sgAction:(UISegmentedControl*) seg
{
    NSInteger Index = seg.selectedSegmentIndex;
    

  
        [_scrollView setContentOffset:CGPointMake(Index * _scrollView.frame.size.width, 0) animated:YES];
        
    
    NSLog(@"%d号按钮按下",Index);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(![scrollView isKindOfClass:[UITableView class]])
        {
//            NSLog(@"scrollView动了");
        }
     else
        {
//            NSLog(@"tableView动了");
        }
}



#pragma mark - 初始化TableView
- (void)initWithTableView
{
    //iOS7里面会自动向下偏移64点，要把这个自动偏移关闭 lol
    self.automaticallyAdjustsScrollViewInsets = NO;
    //不初始化默认为nil 去你妈的
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(_scrollView.bounds.size.width * 0, _scrollView.bounds.origin.y, _scrollView.frame.size.width , _scrollView.frame.size.height)];
    
//    _tableView.backgroundColor = [UIColor clearColor];

    
#pragma mark 这里有个问题 想用循环 发现有问题
    _toolTableView = [[UITableView alloc]initWithFrame:CGRectMake(_scrollView.bounds.size.width * 1, _scrollView.bounds.origin.y, _scrollView.frame.size.width , _scrollView.frame.size.height)];
    _drogTableView = [[UITableView alloc]initWithFrame:CGRectMake(_scrollView.bounds.size.width * 2, _scrollView.bounds.origin.y, _scrollView.frame.size.width , _scrollView.frame.size.height)];
    _toolTableView.dataSource = self;
    _tableView.dataSource = self;
    _drogTableView.dataSource = self;
    
    
    _tableView.scrollsToTop = YES;
    _toolTableView.scrollsToTop = YES;
    _drogTableView.scrollsToTop = YES;
    
    _tableView.tag = 1;
    _toolTableView.tag = 2;
    _drogTableView.tag = 3;
    
    
    
    
    _tableView.delegate = self;
    _toolTableView.delegate = self;
    _drogTableView.delegate = self;

    [_scrollView addSubview:_tableView];
    [_scrollView addSubview:_toolTableView];
    [_scrollView addSubview:_drogTableView];
    
    [self setupRefresh];

    
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(gymHeaderRereshing)];
    [_toolTableView addHeaderWithTarget:self action:@selector(toolHeaderRereshing)];
    [_drogTableView addHeaderWithTarget:self action:@selector(drugHeaderRereshing)];
    
    
//#warning 自动刷新(一进入程序就下拉刷新)
    [_tableView headerBeginRefreshing];

    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(gymFooterRereshing)];
    [_toolTableView addFooterWithTarget:self action:@selector(toolFooterRereshing)];
    [_drogTableView addFooterWithTarget:self action:@selector(drugFooterRereshing)];

    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView.headerRefreshingText = @"正在刷新中";
    
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView.footerRefreshingText = @"正在加载中";
    
    _toolTableView.headerPullToRefreshText = @"下拉可以刷新了";
    _toolTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _toolTableView.headerRefreshingText = @"正在刷新中";
    
    _toolTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _toolTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _toolTableView.footerRefreshingText = @"正在加载中";
    
    _drogTableView.headerPullToRefreshText = @"下拉可以刷新了";
    _drogTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _drogTableView.headerRefreshingText = @"正在刷新中";
    
    _drogTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _drogTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _drogTableView.footerRefreshingText = @"正在加载中";
}



#pragma mark 开始进入刷新状态
- (void)gymHeaderRereshing
{
            // 2.2秒后刷新表格UI
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
//                _tableView.hidden = NO;
//                _toolTableView.hidden = NO;
//                _drogTableView.hidden = NO;
              
                [_tableView reloadData];
              
                NSLog(@"头刷新");
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_tableView headerEndRefreshing];
            });
}

- (void)toolHeaderRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_toolTableView reloadData];
        NSLog(@"头刷新");
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_toolTableView headerEndRefreshing];
    });
}

- (void)drugHeaderRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_drogTableView reloadData];
        NSLog(@"头刷新");
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_drogTableView headerEndRefreshing];
    });
}
- (void)gymFooterRereshing
    {
//    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData addObject:MJRandomData];
//    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        NSLog(@"刷新表格");
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView footerEndRefreshing];
    });
}

- (void)toolFooterRereshing
{
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.fakeData addObject:MJRandomData];
    //    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_toolTableView reloadData];
        NSLog(@"刷新表格");
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_toolTableView footerEndRefreshing];
    });
}

- (void)drugFooterRereshing
{
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.fakeData addObject:MJRandomData];
    //    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_drogTableView reloadData];
        NSLog(@"刷新表格");
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_drogTableView footerEndRefreshing];
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        NSLog(@"tableView");
        
    }
    else{
        //回到0 出问题
    //停止后的偏移量
//    NSInteger offset  = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width + 1;
       NSInteger offset  = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width ;
        
//    _lastChosenSegementButton.selected = NO;
//    _lastChosenSegementButton = (UIButton*)[_segementControl viewWithTag:offset];
//        NSLog(@"%@",_lastChosenSegementButton);
//    NSLog(@"%d",_lastChosenSegementButton.tag);
//    _lastChosenSegementButton.selected = YES;
        
        [_sgControl setSelectedSegmentIndex:offset];
        
        
        
    }
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 1:
        {
            return _gymTableViewData.count;
            break;
        }
            case 2:
        {
            return _toolTableViewData.count;
            break;
        }
            case 3:
        {
            return _drugTableViewData.count;
            break;
        }
        default:
            break;
    }
    return 15;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 1://健身房
        {
            
            return [GymTableViewCell GymCellHeight];
            break;
        }
        case 2:
        {
            return [DrugTableViewCell DrugCellHeight];
            break;
        }
        case 3://补剂
        {
            return [DrugTableViewCell DrugCellHeight];
            break;
        }
        default:
            return 40;
            break;
    }
    return 40;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


#pragma mark - 数据源 tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 1:
        {
            
            GymTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[GymTableViewCell ID]];
            if (cell == nil) {
               cell = [[GymTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GymTableViewCell ID]];

            }
            NSDictionary * tempGymData = _gymTableViewData[indexPath.row];
            cell.gymModel = [[GymModel alloc]initWithDic:tempGymData];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
//#pragma mark - ...
//            
//            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[GymTableViewCell ID]];
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GymTableViewCell ID]];
//                
//            }
////            NSDictionary * tempGymData = _gymTableViewData[indexPath.row];
////            cell.gymModel = [[GymModel alloc]initWithDic:tempGymData];
//            cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
//            return cell;
            
            
            break;
        }
        case 2:
        {
            DrugTableViewCell* acell = [tableView dequeueReusableCellWithIdentifier:[DrugTableViewCell ID]];
                                        
            if(acell == nil)
                {
                    acell = [[DrugTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DrugTableViewCell ID]];
                }
            NSDictionary * tempDrugData = _toolTableViewData[indexPath.row];
            acell.drugModel = [[DrugModel alloc]initWithDic:tempDrugData];
            acell.selectionStyle = UITableViewCellSelectionStyleNone;

            return acell;
            break;
        }

        case 3:
        {
            DrugTableViewCell* acell = [tableView dequeueReusableCellWithIdentifier:[DrugTableViewCell ID]];
            
            if(acell == nil)
            {
                acell = [[DrugTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DrugTableViewCell ID]];
            }
            NSDictionary * tempDrugData = _drugTableViewData[indexPath.row];
            acell.drugModel = [[DrugModel alloc]initWithDic:tempDrugData];
            acell.selectionStyle = UITableViewCellSelectionStyleNone;

            return acell;
            break;
        }

            

        default:
            break;
    }
    return nil;
}


#pragma mark - 跳转到二级界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 1://健身房
        {
            GymDetailedInfoViewController* deta = [[GymDetailedInfoViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:deta animated:YES];
                       break;
        }
        case 2://器材
        {
            DetailedInfoViewController* deta = [[DetailedInfoViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:deta animated:YES];
            break;
        }
        case 3://补剂
        {
            DetailedInfoViewController* deta = [[DetailedInfoViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:deta animated:YES];
            break;
        }
            
        default:
            break;
    }
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
