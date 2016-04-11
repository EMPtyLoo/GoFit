//
//  HomeTipsCell.m
//  GoFit
//
//  Created by EMPty on 3/8/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "HomeTipsCell.h"

#import <UIImageView+WebCache.h>


#define side 5
#define TITLE_WIDTH 230
#define TITLE_HEIGHT 70
#define FROM_HEIGHT 30
@implementation HomeTipsCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titile = [[UILabel alloc]initWithFrame:CGRectMake(side, side, TITLE_WIDTH, TITLE_HEIGHT)];
        
        _titile.numberOfLines = 0;
        [self addSubview:_titile];
        
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(_titile.frame.origin.x + _titile.frame.size.width + side , _titile.frame.origin.y, _titile.frame.size.height, _titile.frame.size.height)];
        [self addSubview:_image];
        
        self.from = [[UILabel alloc]initWithFrame:CGRectMake(_titile.frame.origin.x, _titile.frame.origin.y + _titile.frame.size.height + side, ([UIScreen mainScreen].bounds.size.width - 2*side ) / 2, FROM_HEIGHT )];
        _from.textColor = [UIColor lightGrayColor];
        _from.font = [UIFont systemFontOfSize:13];
        [self addSubview:_from];
        
        _time = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - side - _from.frame.size.width, _from.frame.origin.y, _from.frame.size.width, _from.frame.size.height)];
        _time.textAlignment = NSTextAlignmentRight;
        _time.textColor = [UIColor lightGrayColor];
        _time.font = [UIFont systemFontOfSize:13];
        [self addSubview:_time];
        
        
    }
    
    return self;
}

- (void)setHomeTipsModel:(HomeTipsModel *)homeTipsModel
{
    _homeTipsModel = homeTipsModel;
    _titile.text = homeTipsModel.titile;
_titile.frame = [_titile textRectForBounds:_titile.frame limitedToNumberOfLines:0];
    //    _image.image = [UIImage imageNamed:homeTipsModel.image];
    if (homeTipsModel.image != nil) {
        
     [_image sd_setImageWithURL:[NSURL URLWithString:homeTipsModel.image]];
    }
    else
    {
        self.titile.frame = CGRectMake(side, side, [UIScreen mainScreen].bounds.size.width - 2 * side, TITLE_HEIGHT);
        

    }
    
    
    _from.text =homeTipsModel.from;
    _time.text = homeTipsModel.time;
    
}

+ (float)cellHeight
{
    return TITLE_HEIGHT + FROM_HEIGHT + 2*side;
}

+ (NSString*)ID
{
    return @"homeTipsCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
