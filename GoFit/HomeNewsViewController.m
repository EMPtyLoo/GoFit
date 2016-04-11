//
//  HomeNewsViewController.m
//  GoFit
//
//  Created by EMPty on 3/8/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "HomeNewsViewController.h"
#import "HomeTipsCell.h"
#import "WebViewController.h"
#import "MJRefresh.h"
//#import <SVProgressHUD.h>
#import "SVProgressHUD.h"
@interface HomeNewsViewController ()
{
    UITableView* _tableView;
    NSMutableArray* _homeTipsData;
    NSMutableArray* _tipsURLs;
    int _page;
}
@end

@implementation HomeNewsViewController

- (void)viewWillAppear:(BOOL)animated
{
//    self.hidesBottomBarWhenPushed = NO;
//    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    _homeTipsData = [[NSMutableArray alloc]init];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView
{
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20 + self.navigationController.navigationBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.scrollsToTop = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //上拉刷新
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView.headerRefreshingText = @"正在刷新中";
    
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView.footerRefreshingText = @"正在加载中";
    
    //加载刷新
    [_tableView headerBeginRefreshing];


}

#pragma mark - 上拉刷新 下拉刷新
- (void)headerRereshing
{
//    [self loadHomeTipsData];
    _page ++;
    [NSThread detachNewThreadSelector:@selector(loadHomeTipsData:) toTarget:self withObject:[NSNumber numberWithInt:_page]];
    

}

- (void)footerRereshing
{
    _page++;
    
    [NSThread detachNewThreadSelector:@selector(loadHomeTipsData:) toTarget:self withObject:[NSNumber numberWithInt:_page]];


}

- (void)footerEndRefreshing
{
    [_tableView footerEndRefreshing];

}

- (void)headerEndRefreshing
{
    [_tableView headerEndRefreshing];
}

#pragma mark 读取api数据
- (void)loadHomeTipsData:(NSNumber*) page
{
//    NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"HomeTipsData" ofType:@"plist"];
//    _homeTipsData = [NSMutableArray arrayWithArray:[[NSArray alloc] initWithContentsOfFile:dataPath]];
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
    
    NSString *data = _kind;
    
    //encodeURL格式
    NSString* dataEncodeURL = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)data, nil, nil, kCFStringEncodingUTF8));
    
    
    NSLog(@"UTF8 %@",dataEncodeURL);
    NSString* httpArg = [NSString stringWithFormat:@"title=%@&page=%d",dataEncodeURL,[page intValue]];
    NSLog(@"%@",httpArg);
    [self request: httpUrl withHttpArg: httpArg];
    
    
}

#pragma mark - 获取api数据

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"c0670da16e87cdcec1793511521f3c60" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                                   
//                                #warning 出错
                                   [SVProgressHUD showErrorWithStatus:@"网络出错啦" duration:2];
                                   [self performSelectorOnMainThread:@selector(headerEndRefreshing) withObject:nil waitUntilDone:YES];
                                   
                               } else {
                                   //                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   
                                   NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:&error];
                                   //                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   //                                   NSLog(@"HttpResponseCode:%ld", (long)responseCode);
                                   
                                   //                                   NSLog(@"HttpResponseBody %@",responseString);
//                                   NSLog(@"HttpResponseBody %@",responseData);
                                   
                                   NSDictionary* showapi_res_body = [NSDictionary dictionaryWithDictionary:[responseData objectForKey:@"showapi_res_body"]];
//                                   NSLog(@"showapi_res_body:%@",showapi_res_body);
                                   
                                   
                                   NSDictionary* pageBean = [NSDictionary dictionaryWithDictionary:[showapi_res_body objectForKey:@"pagebean"]];
                                   
                                   NSArray* contentlist = [NSArray arrayWithArray:[pageBean objectForKey:@"contentlist"]];
//                                   [contentlist removeLastObject];

                                   NSLog(@"contentlist:%@",contentlist);
                                   if (contentlist.count == 0) {
                                       _page -- ;
                                       [SVProgressHUD showErrorWithStatus:@"没有更多了" duration:2.0];
                                   }
                                   
                                   [_homeTipsData addObjectsFromArray:contentlist];
                                   [_tableView reloadData];
                                   
                                   
                                   [self performSelectorOnMainThread:@selector(headerEndRefreshing) withObject:nil waitUntilDone:YES];
                                   [self performSelectorOnMainThread:@selector(footerEndRefreshing) withObject:nil waitUntilDone:YES];


                               }
                           }];
    
    

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)_homeTipsData.count);
    return _homeTipsData.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTipsCell* cell = [tableView dequeueReusableCellWithIdentifier:[HomeTipsCell ID]];
    if (cell == nil) {
        cell = [[HomeTipsCell alloc]init];
        
    }
    NSDictionary* data = _homeTipsData[indexPath.row];
    NSDictionary* temp = @{@"title":[data objectForKey:@"title"],@"image":[data objectForKey:@"imageurls"],@"from":[data objectForKey:@"source"],@"time":[data objectForKey:@"pubDate"]};
    NSLog(@"%@",temp);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.homeTipsModel = [[HomeTipsModel alloc]initWithDic:temp];
    
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HomeTipsCell cellHeight];
}

//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* data = _homeTipsData[indexPath.row];
    NSString * url = [data objectForKey:@"link"];
    NSLog(@"url:%@",url);
    WebViewController* webViewController = [[WebViewController alloc]init];
    webViewController.link = url;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
    
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
