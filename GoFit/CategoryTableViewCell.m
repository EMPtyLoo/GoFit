//
//  CategoryTableViewCell.m
//  GoFit
//
//  Created by EMPty on 3/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "CategoryTableViewCell.h"
#define CELL_HEIGHT 150
@implementation CategoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width - 10, CELL_HEIGHT)];
        [self addSubview:_image];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
