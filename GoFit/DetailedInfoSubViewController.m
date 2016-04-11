//
//  DetailedInfoSubViewController.m
//  GoFit
//
//  Created by EMPty on 3/4/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//


#import "DetailedInfoSubViewController.h"
#define side 5
@interface DetailedInfoSubViewController ()
{
    UIView* _headView;
    UIScrollView* _imageGallary;
}
@end

@implementation DetailedInfoSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImagesData];
    [self initHeadView];
    self.tableView.tableHeaderView = _headView;
}

- (void)initHeadView
{
    _headView = [[UIView alloc]initWithFrame:self.view.bounds];
    _imageGallary = [[UIScrollView alloc]initWithFrame:_headView.bounds];
    _imageGallary.contentSize = CGSizeMake(_imageGallary.frame.size.width, _images.count * ( ([UIScreen mainScreen].bounds.size.width - 2 * side ) / 3 * 2) );
    
    for (int i = 0; i < _images.count; ++i) {
        
        UIImageView* temp = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5 + i * (([UIScreen mainScreen].bounds.size.width - 2 * side ) / 3 * 2), [UIScreen mainScreen].bounds.size.width - 2 * side, ([UIScreen mainScreen].bounds.size.width - 2 * side ) / 3 * 2)];
        temp.image = [UIImage imageNamed:_images[i]];
        temp.contentMode = UIViewContentModeScaleToFill;
        [_imageGallary addSubview:temp];
        
        
    }
    
    [_headView addSubview:_imageGallary];
    
}

- (void)loadImagesData
{
    NSString* imagesDataPath = [[NSBundle mainBundle] pathForResource:@"DetailedImagesData" ofType:@"plist"];
    NSArray* imageData = [[NSArray alloc]initWithContentsOfFile:imagesDataPath];
    _images = imageData[0];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"subCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = @"Page Two Text";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

@end



