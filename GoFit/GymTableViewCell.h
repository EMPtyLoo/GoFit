//
//  GymTableViewCell.h
//  GoFit
//
//  Created by EMPty on 12/11/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GymModel.h"
@interface GymTableViewCell : UITableViewCell
@property (nonatomic)  UIImageView *icon;
@property (nonatomic) IBOutlet UILabel *name;
@property (nonatomic) IBOutlet UILabel *phone;
@property (nonatomic) IBOutlet UILabel *address;
@property (nonatomic) IBOutlet UILabel *count;
@property (nonatomic) IBOutlet UILabel *distance;
@property (nonatomic) IBOutlet UIImageView *mapPin;
@property (nonatomic,strong) GymModel* gymModel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+ (NSString*)ID;
+ (float)GymCellHeight;

@end
