//
//  GymTableViewCell.m
//  GoFit
//
//  Created by EMPty on 12/11/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "GymTableViewCell.h"
#define cellSlot 8
#define iconHeight 97
#define iconWidth 76
#define nameWidth 138
#define nameHeight 20
#define phoneY 61
#define phoneWidth 156
#define phoneHeight 21
#define countWidth 78
#define countHeight 21
#define distanceWidth 35
#define mapPinWidth 11
#define mapPinHeight 14
@implementation GymTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(cellSlot, cellSlot, iconWidth, iconHeight)];
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x + _icon.frame.size.width + cellSlot, cellSlot, nameWidth, nameHeight)];
        self.phone = [[UILabel alloc]initWithFrame:CGRectMake(_name.frame.origin.x, phoneY, phoneWidth, phoneHeight)];
        self.address = [[UILabel alloc]initWithFrame:CGRectMake(_name.frame.origin.x, _phone.frame.origin.y + _phone.frame.size.height + cellSlot, phoneWidth, phoneHeight)];
        
        self.count = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - cellSlot - countWidth, nameHeight, countWidth, countHeight)];
        self.distance = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - cellSlot - distanceWidth, _address.frame.origin.y, distanceWidth, countHeight)];
        self.mapPin = [[UIImageView alloc]initWithFrame:CGRectMake(_distance.frame.origin.x - mapPinWidth, _distance.frame.origin.y, mapPinWidth, mapPinHeight)];
        _mapPin.image = [UIImage imageNamed:@"mapPin.png"];
        _phone.font = [UIFont systemFontOfSize:13];
        _address.font = [UIFont systemFontOfSize:13];
        _name.font = [UIFont systemFontOfSize:17];
        _count.font = [UIFont systemFontOfSize:11];
        _distance.font = [UIFont systemFontOfSize:11];
        _count.textAlignment = NSTextAlignmentRight;
        _distance.textAlignment = NSTextAlignmentRight;
        [self addSubview:_icon];
        [self addSubview:_name];
        [self addSubview:_phone];
        [self addSubview:_address];
        [self addSubview:_count];
        [self addSubview:_distance];
        [self addSubview:_mapPin];
        
    }
 
    return self;
}

- (void)setGymModel:(GymModel *)gymModel
{
    _gymModel = gymModel;
    NSLog(@"name:%@ phone:%@ address:%@ count:%@ distance:%@ icon:%@",gymModel.name,gymModel.phone,gymModel.address,gymModel.count,gymModel.distance,gymModel.icon);
    _name.text = gymModel.name;
    _icon.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:gymModel.icon ofType:nil]];
    _phone.text = gymModel.phone;
    _address.text = gymModel.address;
    _count.text = [NSString stringWithFormat:@"%@人已消费",gymModel.count];
    _distance.text = [NSString stringWithFormat:@"%@km",gymModel.distance];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString*)ID
{
    return @"GymCell";
}

+ (float)GymCellHeight
{
    return 8 * 2 + 97;
}

@end
