//
//  DiscoverCell.m
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "DiscoverCell.h"
#import "CommentsTableViewCell.h"
#import "KeyboardToolBar.h"
#import "EMPUtils.h"
#define DiscoverData @"DiscoverData.plist"

#define side 5
#define iconSide 50
#define nameY 7
#define nameHeight 25
#define commentSide 45
@implementation DiscoverCell
{
    UITextField* text;
    NSNotificationCenter* _nc;
}
//{
//    float cellHeight;
//}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(side, side, iconSide ,iconSide )];
        [self addSubview:_icon];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x + _icon.frame.size.width + side, nameY, [UIScreen mainScreen].bounds.size.width - _icon.bounds.size.width -  side, nameHeight)];
        [self addSubview:_name];
        
        _sign = [[UILabel alloc]initWithFrame:CGRectMake(_name.frame.origin.x, _icon.frame.origin.y + _icon.frame.size.height - _name.frame.size.height - side, _name.frame.size.width, _name.frame.size.height)];
        _sign.textColor = [UIColor lightGrayColor];
        [self addSubview:_sign];
        
        _mainText = [[UITextView alloc]init];
        _mainText.bounces = NO;
        _mainText.bouncesZoom = NO;
        [self addSubview:_mainText];
        
        _mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(side, _icon.frame.origin.y + _icon.frame.size.height + side, [UIScreen mainScreen].bounds.size.width - 2 * side, [UIScreen mainScreen].bounds.size.width - 2 * side)];
        [self addSubview:_mainImage];
        
        
        _comment = [[UIButton alloc]initWithFrame:CGRectMake(_mainImage.frame.origin.x + side, _mainImage.frame.origin.y + _mainImage.frame.size.height + side, 45, 45)];
        [_comment addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        [_comment setTitle:@"评论" forState:UIControlStateNormal];
        [_comment setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _comment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_comment];
        
        _numberOfComment = [[UILabel alloc]initWithFrame:CGRectMake(_comment.frame.origin.x
                                                                    + _comment.frame.size.width, _comment.frame.origin.y
                                                                    , _comment.frame.size.width, _comment.frame.size.height)];
        _numberOfComment.text = @"0";
        _numberOfComment.textColor = [UIColor lightGrayColor];
        _numberOfComment.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:_numberOfComment];
        
        _like = [[UIButton alloc]initWithFrame:CGRectMake(_numberOfComment.frame.origin.x + _numberOfComment.frame.size.width + side, _numberOfComment.frame.origin.y, _numberOfComment.frame.size.width, _numberOfComment.frame.size.height)];
        [_like setTitle:@"赞" forState:UIControlStateNormal];
        [_like addTarget:self action:@selector(likeAction) forControlEvents:UIControlEventTouchUpInside];
        [_like setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _like.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_like];
        
        _numberOfLike = [[UILabel alloc]initWithFrame:CGRectMake(_like.frame.origin.x + _like.frame.size.width, _like.frame.origin.y, _like.frame.size.width, _like.frame.size.height)];
        _numberOfLike.textColor = [UIColor lightGrayColor];
        _numberOfLike.text = @"0";
        _numberOfLike.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_numberOfLike];
        
        _forward = [[UIButton alloc]initWithFrame:CGRectMake(_mainImage.frame.origin.x + _mainImage.frame.size.width - _like.frame.size.width - side * 2, _like.frame.origin.y, _like.frame.size.width, _like.frame.size.height)];
        [_forward setTitle:@"转发" forState:UIControlStateNormal];
        [_forward setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _forward.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_forward addTarget:self action:@selector(forwardAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_forward];
        
        _comments = [[UITableView alloc]init];
        _comments.separatorStyle = UITableViewCellSeparatorStyleNone;
        _comments.delegate  = self ;
        _comments.dataSource = self;
        _comments.bounces = NO;
        _comments.bouncesZoom = NO;
        [self addSubview:_comments];
//        _peopleWhoLike = [UIScrollView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        
    }
    _nc = [NSNotificationCenter defaultCenter];
    [_nc addObserver:self selector:@selector(reloadNext) name:@"reloadNext" object:nil];
    
    return self;
}

- (void)reloadNext
{
    [_comments reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _discoverModel.comments.count + 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _discoverModel.comments.count) {
        
    CommentsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CommentsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    NSDictionary* temp = _discoverModel.comments[indexPath.row];
    cell.commentModel = [[CommentsModel alloc]initWithDic:temp];
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[temp objectForKey:@"icon"]]];
//    cell.textLabel.text = [temp objectForKey:@"text"];
//
        cell.commentModel.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
#pragma mark - 输入框
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textCell"];
            
        }
        UITextField* textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width - 20,30)];
        textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        textField.layer.borderWidth = 1.0f;
        textField.layer.cornerRadius = 8.0f;
//        textField.backgroundColor = [UIColor yellowColor];
        textField.placeholder = @" 请输入评论内容";
        textField.font = [UIFont systemFontOfSize:14];
        textField.delegate = self;
        textField.tag = indexPath.row;
        text = textField;
        [KeyboardToolBar registerKeyboardToolBarWithTextField:textField];
        [cell.contentView addSubview:textField];
//        cell.backgroundColor = [UIColor lightGrayColor];
//        cell.layer.borderColor = [[UIColor blackColor]CGColor];
//        cell.layer.cornerRadius = 8.0f;
        return cell;

    }
    
    return nil;
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑");
    NSString* content = [NSString stringWithFormat:@"%@",textField.text];
    NSLog(@"%@",content);
    if (![content isEqualToString:@""]) {
        
    
    NSMutableArray* commentsArray = [[NSMutableArray alloc]initWithArray:_discoverModel.comments copyItems:YES];
    NSDictionary* addComment = [[NSDictionary alloc]initWithObjects:@[@"add",@"icon.png",content] forKeys:@[@"ID",@"icon",@"text"]];
    [commentsArray addObject:addComment];
    NSLog(@"%@",_discoverModel.comments);
    _discoverModel.comments = [NSArray arrayWithArray:commentsArray];
//    [_comments reloadData];
    NSLog(@"%@",_discoverModel.comments);
    
        
    NSDictionary* dic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%D",_discoverModel.tag],[NSString stringWithFormat:@"%d",textField.tag],textField.text] forKeys:@[@"rowOfAll",@"rowOfComments",@"content"]];
    [_nc postNotificationName:@"reloadComments" object:self userInfo:dic];
    textField.text = @"";
        
        
        
    }

//    [_comments reloadSections:0 withRowAnimation:UITableViewRowAnimationLeft];
//     [_comments insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_discoverModel.comments.count  inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
}


#pragma mark - 3个按钮 评论 赞 转发
- (void)forwardAction
{
    NSLog(@"按下了转发按钮");
}

- (void)likeAction
{
    NSLog(@"按下了赞");
    _numberOfLike.text = [NSString stringWithFormat:@"%d",[_numberOfLike.text intValue] + 1];
    
}

- (void)commentAction
{
    NSLog(@"按下了评论按钮");
    [text becomeFirstResponder];
    
}

+ (NSString*)ID
{
    return @"DISCOVER_CELL";
}

- (void)setDiscoverModel:(DiscoverModel *)discoverModel
{
    _discoverModel = discoverModel;
    _icon.image = [UIImage imageNamed:discoverModel.icon];
    
    _name.text = discoverModel.name;
    _sign.text = discoverModel.sign;
    _mainImage.image = [UIImage imageNamed: discoverModel.mainImage];
    _mainText.text = discoverModel.mainText;
    NSLog(@"%@",discoverModel.mainText);
    if ([discoverModel.mainText isEqualToString:@""]) {
        NSLog(@"为空");
    }
    
    
    
    
    
    if ([discoverModel.mainText isEqualToString:@""]) {
        _mainText.frame = CGRectMake(side, _icon.frame.origin.y + _icon.frame.size.height + side, [UIScreen mainScreen].bounds.size.width - 2 * side, 0);
    }
    else
    {
        _mainText.text = discoverModel.mainText;
        _mainText.frame = CGRectMake(side, _icon.frame.origin.y + _icon.frame.size.height + side, [UIScreen mainScreen].bounds.size.width - 2 * side, [self heightForString:_mainText andWidth: [UIScreen mainScreen].bounds.size.width - 2 * side]);
    }
    
    
    
    _mainImage.frame = CGRectMake(side, _mainText.frame.origin.y + _mainText.frame.size.height + side, [UIScreen mainScreen].bounds.size.width - 2 * side, [UIScreen mainScreen].bounds.size.width - 2 * side);
    [self addSubview:_mainImage];
    
    
    _comment.frame = CGRectMake(_mainImage.frame.origin.x + side, _mainImage.frame.origin.y + _mainImage.frame.size.height + side, 45, 45);
    
    _numberOfComment.frame = CGRectMake(_comment.frame.origin.x
                                                                + _comment.frame.size.width, _comment.frame.origin.y
                                                                , _comment.frame.size.width, _comment.frame.size.height);
    _numberOfComment.text = [NSString stringWithFormat:@"%d",_discoverModel.comments.count];

    _like.frame = CGRectMake(_numberOfComment.frame.origin.x + _numberOfComment.frame.size.width + side, _numberOfComment.frame.origin.y, _numberOfComment.frame.size.width, _numberOfComment.frame.size.height);
   
    
    _numberOfLike.frame = CGRectMake(_like.frame.origin.x + _like.frame.size.width, _like.frame.origin.y, _like.frame.size.width, _like.frame.size.height);
 
    
    _forward.frame = CGRectMake(_mainImage.frame.origin.x + _mainImage.frame.size.width - _like.frame.size.width - side * 2, _like.frame.origin.y, _like.frame.size.width, _like.frame.size.height);
    
//    if (discoverModel.comments.count != 0) {
    
    _comments.frame = CGRectMake(_mainImage.frame.origin.x, _numberOfComment.frame.origin.y + _numberOfComment.frame.size.height + side, _mainImage.frame.size.width,(discoverModel.comments.count + 1) * 44);
//    }

    
       //评论区
//    _comments = discoverModel.comments;
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


///**
// @method 获取指定宽度情况ixa，字符串value的高度
// @param value 待计算的字符串
// @param fontSize 字体的大小
// @param andWidth 限制字符串显示区域的宽度
// @result float 返回的高度
// */
//- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
//{
//    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
//    return sizeToFit.height;
//}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
