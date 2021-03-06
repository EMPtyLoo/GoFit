//
//  WBPopMenuView.m
//  QQ_PopMenu_Demo
//
//  Created by Transuner on 16/3/17.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import "WBPopMenuView.h"
#import "WBTableViewDataSource.h"
#import "WBTableViewDelegate.h"
#import "WBTableViewCell.h"
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"

#import "QRCodeGenerator.h"



#define WBNUMBER 6

@interface WBPopMenuView ()
@property (nonatomic, strong) WBTableViewDataSource * tableViewDataSource;
@property (nonatomic, strong) WBTableViewDelegate   * tableViewDelegate;
@end

@implementation WBPopMenuView

- (instancetype) init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action {
    if (self = [super initWithFrame:frame]) {
        self.menuWidth = menuWidth;
        self.menuItem = items;
        self.action = [action copy];

        self.tableViewDataSource = [[WBTableViewDataSource alloc]initWithItems:items cellClass:[WBTableViewCell class] configureCellBlock:^(WBTableViewCell *cell, WBPopMenuModel *model) {
            WBTableViewCell * tableViewCell = (WBTableViewCell *)cell;
            tableViewCell.textLabel.text = model.title;
            tableViewCell.imageView.image = [UIImage imageNamed:model.image];
        }];
        self.tableViewDelegate = [[WBTableViewDelegate alloc]initWithDidSelectRowAtIndexPath:^(NSInteger indexRow) {
            if (self.action) {
                self.action(indexRow);
            }
        }];
        UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 180)];
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:headView.bounds];
        
        imageView.backgroundColor = [UIColor whiteColor];
        //    QRCode.alpha = 0.7;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.view addSubview:QRCode];
        imageView.image = [QRCodeGenerator qrImageForString:@"hello world" imageSize:200];
        
        
        [headView addSubview:imageView];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView = [[UITableView alloc]initWithFrame:[self menuFrame] style:UITableViewStylePlain];
        self.tableView.dataSource = self.tableViewDataSource;
        self.tableView.delegate   = self.tableViewDelegate;
        self.tableView.layer.cornerRadius = 10.0f;
        self.tableView.layer.anchorPoint = CGPointMake(1.0, 0);
        self.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.tableView.rowHeight = 40;
        self.tableView.tableHeaderView = headView;
        
        [self addSubview:self.tableView];
        
//        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//        }
//        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//        }
        
    }
    return self;
}

- (CGRect)menuFrame {
//    CGFloat menuX = [UIScreen mainScreen].bounds.size.width - 130;
//    CGFloat menuY = 180 - 20 * WBNUMBER;
    CGFloat menuX = 100;
    CGFloat menuY = -30;
    CGFloat width = self.menuWidth;
    CGFloat heigh = 180;
    return (CGRect){menuX,menuY,width,heigh};
}

#pragma mark 绘制三角形
//- (void)drawRect:(CGRect)rect
//
//{
//    // 设置背景色
//    [[UIColor whiteColor] set];
//    //拿到当前视图准备好的画板
//    
//    CGContextRef  context = UIGraphicsGetCurrentContext();
//    
//    //利用path进行绘制三角形
//    
//    CGContextBeginPath(context);//标记
//    CGFloat location = [UIScreen mainScreen].bounds.size.width-55;
//    CGContextMoveToPoint(context,
//                         location -  10 - 10, 180);//设置起点
//    
//    CGContextAddLineToPoint(context,
//                            location - 2*10 - 10 ,  170);
//    
//    CGContextAddLineToPoint(context,
//                            location - 10 * 3 - 10, 180);
//    
//    CGContextClosePath(context);//路径结束标志，不写默认封闭
//    
//    [[UIColor whiteColor] setFill];  //设置填充色
//    
//    [[UIColor whiteColor] setStroke]; //设置边框颜色
//    
//    CGContextDrawPath(context,
//                      kCGPathFillStroke);//绘制路径path
//    
//}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[WBPopMenuSingleton shareManager]hideMenu];
}

@end
