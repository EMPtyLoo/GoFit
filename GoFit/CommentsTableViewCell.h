//
//  CommentsTableViewCell.h
//  GoFit
//
//  Created by EMPty on 2/26/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsModel.h"

@interface CommentsTableViewCell : UITableViewCell
@property (nonatomic) UIButton* people;
@property (nonatomic) UILabel* comment;
@property (nonatomic) CommentsModel* commentModel;
+ (NSString*)ID;
//+ (float) cellHeght;
@end
