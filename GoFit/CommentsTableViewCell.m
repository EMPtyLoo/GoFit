//
//  CommentsTableViewCell.m
//  GoFit
//
//  Created by EMPty on 2/26/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "CommentsTableViewCell.h"
#define side 5
@implementation CommentsTableViewCell
{
    float height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _people = [[UIButton alloc]init];
        [_people setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_people addTarget:self action:@selector(peopleAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_people];
        _comment = [[UILabel alloc]init];
        [self addSubview:_comment];
    }
    
    return self;
}

- (void)setCommentModel:(CommentsModel *)commentModel
{
    _commentModel = commentModel;
    [_people setTitle:[NSString stringWithFormat:@"%@:",commentModel.people] forState:UIControlStateNormal];
    _people.titleLabel.font = [UIFont systemFontOfSize:14];
    _people.frame = CGRectMake(side, side, [self width:_people.titleLabel.text], 30);
    _comment.text = commentModel.comments;
    _comment.font = [UIFont systemFontOfSize:14];
    _comment.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_comment.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
//    paragraphStyle.maximumLineHeight = 60;  //最大的行高
//    paragraphStyle.lineSpacing = 5;  //行自定义行高度
    [paragraphStyle setFirstLineHeadIndent:_people.frame.size.width + 5];//首行缩进 根据用户昵称宽度在加5个像素
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_comment.text length])];
    _comment.attributedText = attributedString;
    
    
#warning 评论高度问题
//    [_comment sizeToFit];
    UITextView* tepm = [[UITextView alloc]init];
    tepm.text = _comment.text;
    tepm.font = [UIFont systemFontOfSize:13];
    _comment.frame = CGRectMake(_people.frame.origin.x, _people.frame.origin.y, [UIScreen mainScreen].bounds.size.width - 2*_people.frame.origin.x - side, [self heightForString:tepm andWidth:[UIScreen mainScreen].bounds.size.width - 2*side - side]);
        height = _comment.frame.size.height;

}

- (float) cellHeght
{
    return height;
}


/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

////自适应计算间距
//- (void)resetContent{
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedStringalloc] initWithString:self.contentLabel.text];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStylealloc] init];
//    paragraphStyle.alignment = NSTextAlignmentLeft;
//    paragraphStyle.maximumLineHeight = 60;  //最大的行高
//    paragraphStyle.lineSpacing = 5;  //行自定义行高度
//    [paragraphStyle setFirstLineHeadIndent:self.usernameLabel.frame.size.width + 5];//首行缩进 根据用户昵称宽度在加5个像素
//    [attributedString addAttribute:NSParagraphStyleAttributeNamevalue:paragraphStyle range:NSMakeRange(0, [self.contentLabel.textlength])];
//    self.contentLabel.attributedText = attributedString;
//    [self.contentLabelsizeToFit];
//}

-(float) width:(NSString *)text{
    
    CGSize size=[text sizeWithFont:[UIFont systemFontOfSize:14]constrainedToSize:CGSizeMake(MAXFLOAT,36)];
    
    //text是想要计算的字符串，14是字体的大小，36是字符串的高度（根据需求自己改变）
    
    return size.width;
    
}

- (void)peopleAction
{
    NSLog(@"按下了%@",[_people titleForState:UIControlStateNormal]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (NSString*)ID
{
    return @"commmentsID";
}
@end
