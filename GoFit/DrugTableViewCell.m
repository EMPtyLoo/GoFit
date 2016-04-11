//
//  DrugTableViewCell.m
//  GoFit
//
//  Created by EMPty on 12/12/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "DrugTableViewCell.h"

@implementation DrugTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageSide, imageSide)];
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(_image.frame.origin.x + _image.frame.size.width + side, side, [UIScreen mainScreen].bounds.size.width - side - imageSide, 0.5 * cellHeight)];
        self.title.numberOfLines = 0;
        self.from = [[UILabel alloc]initWithFrame:CGRectMake(_title.frame.origin.x, _title.frame.origin.y + _title.frame.size.height/2, _title.frame.size.width, _title.frame.size.height)];
        self.from.textColor = [UIColor lightGrayColor];
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(_title.frame.origin.x, cellHeight - 0.25 * cellHeight, _title.frame.size.width / 3, 0.25 * cellHeight)];
        self.price.textColor = [UIColor orangeColor];
        self.countOfBuyers = [[UILabel alloc]initWithFrame:CGRectMake(_price.frame.origin.x + _price.frame.size.width + side , _price.frame.origin.y, [UIScreen mainScreen].bounds.size.width - imageSide - side * 2, _price.frame.size.height)];
        self.countOfBuyers.textColor = [UIColor lightGrayColor];
        self.countOfBuyers.font = [UIFont systemFontOfSize:10];
        [self addSubview:_image];
        [self addSubview:_title];
        [self addSubview:_from];
        [self addSubview:_price];
        [self addSubview:_countOfBuyers];
        _from.textAlignment = NSTextAlignmentLeft;
        _price.textAlignment = NSTextAlignmentLeft;
        _countOfBuyers.textAlignment = NSTextAlignmentLeft;
    }
    
    return self;
    
    
}


- (void)setDrugModel:(DrugModel *)drugModel
{
//    NSLog(@"刷过");

    _drugModel = drugModel;
    self.image.image = [UIImage imageNamed:drugModel.image];
    self.title.text = drugModel.title;
    self.price.text = [NSString stringWithFormat:@"¥%@",drugModel.price];
    self.from.text = drugModel.from;
    self.countOfBuyers.text = [NSString stringWithFormat:@"%@人付款",drugModel.countOfBuyer];
    
}

+ (NSString*)ID
{
    return @"drugId";
    
}


+ (float)DrugCellHeight
{
    return imageSide;
}



@end
