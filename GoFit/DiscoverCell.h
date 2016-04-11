//
//  DiscoverCell.h
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NotificationCenter/NotificationCenter.h>
#import "DiscoverModel.h"
@interface DiscoverCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic)UIImageView* icon;
@property (nonatomic)UIImageView* mainImage;
@property (nonatomic)UILabel* name;
@property (nonatomic)UILabel* sign;

@property (nonatomic)UIButton* like;
@property (nonatomic)UILabel* numberOfLike;
@property (nonatomic)UIButton* comment;
@property (nonatomic)UILabel* numberOfComment;
@property (nonatomic)UIButton* forward;

@property (nonatomic)UITextView* mainText;
@property (nonatomic)UIScrollView* peopleWhoLike;
@property (nonatomic)UITableView* comments;
@property (nonatomic,strong) DiscoverModel* discoverModel;
+ (NSString*)ID;
@end
