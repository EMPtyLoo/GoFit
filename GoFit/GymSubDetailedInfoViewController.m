//
//  GymSubDetailedInfoViewController.m
//  GoFit
//
//  Created by EMPty on 3/5/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "GymSubDetailedInfoViewController.h"
#define side 5

@interface GymSubDetailedInfoViewController ()
{
    
        UIView* _headView;
        UIScrollView* _imageGallary;
    

}
@end

@implementation GymSubDetailedInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImagesData];
    [self initHeadView];
    self.tableView.tableHeaderView = _headView;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
