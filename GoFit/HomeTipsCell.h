//
//  HomeTipsCell.h
//  GoFit
//
//  Created by EMPty on 3/8/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTipsModel.h"
@interface HomeTipsCell : UITableViewCell
@property (nonatomic) UILabel* titile;
@property (nonatomic) UIImageView* image;
@property (nonatomic) UILabel* from;
@property (nonatomic) UILabel* time;
@property (nonatomic) HomeTipsModel* homeTipsModel;
+ (NSString*)ID;
+ (float)cellHeight;

@end
