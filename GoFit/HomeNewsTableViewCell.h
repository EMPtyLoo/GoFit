//
//  HomeNewsTableViewCell.h
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNewsModel.h"
@interface HomeNewsTableViewCell : UITableViewCell
@property (nonatomic)  UIScrollView *imagesGalary;
@property (nonatomic) UIButton* title;
@property (nonatomic) NSArray *images;
@property (nonatomic,strong) HomeNewsModel* homeNewsModel;

+ (NSString*)ID;
+ (float)homeNewsCellHeight;

@end
