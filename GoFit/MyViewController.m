//
//  MyViewController.m
//  GoFit
//
//  Created by EMPty on 11/29/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "MyViewController.h"
#import "DiscoverCell.h"
#import "DiscoverModel.h"
#define STATE_HEIGHT 20
#define side 5
#define iconSide 50
#define nameY 13
#define nameHeight 25
#define commentSide 45
#import "EMPUtils.h"
#define DiscoverData @"DiscoverData.plist"
@interface MyViewController ()
{
    UITableView* _tableView;
    NSMutableArray* _discoverData;
    NSNotificationCenter* _nc;
    
}
@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDiscoverData];
    self.navigationItem.title = @"发现";
    _nc = [NSNotificationCenter defaultCenter];
    [_nc addObserver:self selector:@selector(reloadComments:) name:@"reloadComments" object:nil];
    [self initWithTableView];
//    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view from its nib.
}

- (void)loadDiscoverData
{
//    _discoverData = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DiscoverData" ofType:@"plist" ]]];
    _discoverData =[NSMutableArray arrayWithArray:[EMPUtils readFile:DiscoverData]];
    NSLog(@"%@",_discoverData);
}

- (void)reloadComments:(NSNotification*) notify
{
    NSDictionary* dict = [notify userInfo];
    NSString* rowOfAll = [dict objectForKey:@"rowOfAll"];
    NSString* rowOfComments = [dict objectForKey:@"rowOfComments"];
    NSString* content = [dict objectForKey:@"content"];
    NSLog(@"%@   %@   %@",rowOfAll,rowOfComments,content);
    int roa = [rowOfAll intValue];
//    int roc = [rowOfComments intValue];
    NSDictionary* temp = _discoverData[roa];
    NSMutableArray* com = [NSMutableArray arrayWithArray:[temp objectForKey:@"comments"]];
    NSDictionary* add = [[NSDictionary alloc]initWithObjects:@[@"add",@"icon.png",content] forKeys:@[@"ID",@"icon",@"text"]];
    [com addObject:add];
    [temp setValue:com forKey:@"comments"];
    _discoverData[roa] = temp;
    
    NSLog(@"%@",_discoverData);
        [EMPUtils dealWithFirstInfo:DiscoverData];
        //获取应用程序沙盒的Document目录
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString* plistPath = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString* fileName = [plistPath stringByAppendingString:DiscoverData];
    [_discoverData writeToFile:fileName atomically:YES ];
    
    [_nc postNotificationName:@"reloadNext" object:self userInfo:nil];
//    [self loadDiscoverData];
//    NSLog(@"%@",_discoverData);
    [_tableView reloadData];
}

- (void)initWithTableView
{
    
    
    //iOS7里面会自动向下偏移64点，要把这个自动偏移关闭 lol
    self.automaticallyAdjustsScrollViewInsets = NO;

    float tarBarHeight = self.tabBarController.tabBar.frame.size.height;
    float stateHeight = STATE_HEIGHT;
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    float tableViewX = 0;
    float tableViewY = navigationBarHeight + stateHeight ;
    NSLog(@"gaodu:%f",tableViewY);

    float tableViewWidth = [UIScreen mainScreen].bounds.size.width;
    float tableViewHeight = [UIScreen mainScreen].bounds.size.height - stateHeight - navigationBarHeight - tarBarHeight;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight)];
    
    
//    UIScrollView* _scrollView = [[UIScrollView alloc]initWithFrame:_tableView.frame];
//    _scrollView.contentSize = CGSizeMake(_tableView.frame.size.width * 3, _tableView.frame.size.height) ;
    
//    [_scrollView addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _scrollView.delegate = self;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _discoverData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverCell* cell = [tableView dequeueReusableCellWithIdentifier:[DiscoverCell ID]];
    if (cell == nil) {
        cell = [[DiscoverCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DiscoverCell ID]];
        
    }
    NSDictionary* temp = _discoverData[indexPath.row];
    cell.discoverModel = [[DiscoverModel alloc]initWithDic:temp];
    cell.discoverModel.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = [NSString stringWithFormat:@"第%d行-",indexPath.row];
    return cell;
    
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = side + iconSide + side + [UIScreen mainScreen].bounds.size.width - 2*side + commentSide;
    NSDictionary* temp = _discoverData[indexPath.row];
    NSArray* tempComments = [temp objectForKey:@"comments"];
    NSString* mainText = [temp objectForKey:@"mainText"];
    height += (tempComments.count + 1) * 44;
    UITextView* temp2 = [[UITextView alloc]init];
    temp2.text = mainText;
    //具体加多少算法不确定
    if (![mainText  isEqual: @""]) {
        height += [self heightForString:temp2 andWidth:[UIScreen mainScreen].bounds.size.width - 2 * side];
    }
    
    return height + 20;
}

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%d",indexPath.row);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
