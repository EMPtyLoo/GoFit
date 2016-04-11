//
//  HomeNewsTableViewCell.m
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "HomeNewsTableViewCell.h"
#define imageSide 93
#define titleHeight 25
@implementation HomeNewsTableViewCell

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
        self.title = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 320, titleHeight)];
//        self.title.titleLabel.textAlignment = NSTextAlignmentLeft;
        UIImageView* flag = [[UIImageView alloc]initWithFrame:CGRectMake(8, 7, 15, 15)];
        flag.image = [UIImage imageNamed:@"flag.png"];
        [self addSubview:flag];
        self.title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.title.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.title setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        self.title.titleLabel.font = [UIFont systemFontOfSize:15];
//        [self.title setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, 0, 0)];
//        self.title setTitle:<#(NSString *)#> forState:<#(UIControlState)#>
        [self addSubview:self.title];
        
        self.imagesGalary = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, 320, imageSide)];
        [self addSubview:self.imagesGalary];
        [self.title addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.imagesGalary.showsHorizontalScrollIndicator = NO;
        self.imagesGalary.showsVerticalScrollIndicator = NO;
        
    }
    
    return self;
}

- (void)buttonAction:(UIButton*) b
{
    NSLog(@"按下了第%d行的按钮  %@",b.tag,b.titleLabel);
}

- (void)setHomeNewsModel:(HomeNewsModel *)homeNewsModel
{
    _homeNewsModel = homeNewsModel;
    NSLog(@"title:%@   images:%@",homeNewsModel.title,homeNewsModel.images);
    int count = homeNewsModel.images.count;
    NSLog(@"统计：%d",count);
    _imagesGalary.contentSize = CGSizeMake(imageSide * count + (count + 1) * 5, imageSide);
    
    for (int i = 0; i < count; ++i) {
//        NSLog(@"count:%d",count);
        UIImage* temp = [UIImage imageNamed:homeNewsModel.images[i]];
        UIImageView* tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5 + i * (imageSide + 5), 0, imageSide, imageSide)];
        tempImageView.image = temp;
        [_imagesGalary addSubview:tempImageView];
    }
//    _title.titleLabel.text = homeNewsModel.title;
    [_title setTitle:homeNewsModel.title forState:UIControlStateNormal];
    
    
    
}


+ (NSString*)ID
{
    return @"HomeNewsCell";
}

+ (float)homeNewsCellHeight
{
    return 130;
}


@end
