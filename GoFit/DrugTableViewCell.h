//
//  DrugTableViewCell.h
//  GoFit
//
//  Created by EMPty on 12/12/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugModel.h"
#define imageSide 120
#define side 5
#define cellHeight 120
@interface DrugTableViewCell : UITableViewCell
@property(nonatomic) UIImageView* image;
@property(nonatomic) UILabel* title;
@property(nonatomic) UILabel* from;
@property(nonatomic) UILabel* price;
@property(nonatomic) UILabel* countOfBuyers;
@property(nonatomic) DrugModel* drugModel;
+ (NSString*)ID;
+ (float)DrugCellHeight;
@end
