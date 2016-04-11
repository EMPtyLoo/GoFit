//
//  LoginViewController.m
//  GoFit
//
//  Created by EMPty on 3/3/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "MoreViewController.h"
#import "ForgetPasswordViewController.h"
#define STATE_BAR_HEIGHT 20
@interface LoginViewController ()
{
    UITextField *pwd;
    UITextField *user;

    UIButton *QQBtn;
    UIButton *weixinBtn;
    UIButton *xinlangBtn;
}
@property (nonatomic)UIImageView* backgroundImage;

@end

@implementation LoginViewController



- (void)viewWillAppear:(BOOL)animated
{
    //导航栏隐藏
    self.navigationController.navigationBarHidden = YES;
//        self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
//    self.navigationController.t
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackgroundImage];
    [self initButtons];
    [self otherWayLogin];
    // Do any additional setup after loading the view.
}

- (void)initBackgroundImage
{
    _backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, STATE_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - STATE_BAR_HEIGHT)];
    _backgroundImage.image = [UIImage imageNamed:@"loginBackgroundImage.jpg"];
    _backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_backgroundImage];
}

//返回键
- (void)initButtons
{
    //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *back =[[UIButton alloc]initWithFrame:CGRectMake(5, 27, 35, 35)];
    [back setImage:[UIImage imageNamed:@"goBackImage.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UIButton *regist =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 30, 50, 30)];
    [regist setTitle:@"注册" forState:UIControlStateNormal];
    [regist setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    regist.titleLabel.font=[UIFont systemFontOfSize:17];
    [regist addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regist];
    
    
    UILabel *login=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-40)/2, 30, 50, 30)];
    login.text=@"登录";
    login.textColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    [self.view addSubview:login];

}


- (void)backAction
{
//    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    
    self.tabBarController.tabBar.hidden = NO;
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    }

- (void)registAction
{
    NSLog(@"右上角注册");
    [self registration];
}


- (void)otherWayLogin
{
    UIButton *landBtn=[self createButtonFrame:CGRectMake(10, 190, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(landClick)];
    landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    landBtn.layer.cornerRadius=5.0f;
    
    UIButton *newUserBtn=[self createButtonFrame:CGRectMake(5, 235, 70, 30) backImageName:nil title:@"快速注册" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(registration)];
    //newUserBtn.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(fogetPwd)];
    //fogotPwdBtn.backgroundColor=[UIColor lightGrayColor];
    
    
#define Start_X 60.0f           // 第一个按钮的X坐标
#define Start_Y 440.0f           // 第一个按钮的Y坐标
#define Width_Space 50.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 50.0f    // 高
#define Button_Width 50.0f      // 宽
    
    
    
    //微信
    weixinBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 440, 50, 50)];
    //weixinBtn.tag = UMSocialSnsTypeWechatSession;
    weixinBtn.layer.cornerRadius=25;
    weixinBtn=[self createButtonFrame:weixinBtn.frame backImageName:@"wechat" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX)];
    //qq
    QQBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2-100, 440, 50, 50)];
    //QQBtn.tag = UMSocialSnsTypeMobileQQ;
    QQBtn.layer.cornerRadius=25;
    QQBtn=[self createButtonFrame:QQBtn.frame backImageName:@"qq" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ)];
    
    //新浪微博
    xinlangBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2+100, 440, 50, 50)];
    //xinlangBtn.tag = UMSocialSnsTypeSina;
    xinlangBtn.layer.cornerRadius=25;
    xinlangBtn=[self createButtonFrame:xinlangBtn.frame backImageName:@"microblog" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina)];
    
    [self.view addSubview:weixinBtn];
    [self.view addSubview:QQBtn];
    [self.view addSubview:xinlangBtn];
    [self.view addSubview:landBtn];
    [self.view addSubview:newUserBtn];
    [self.view addSubview:forgotPwdBtn];
    
    UIImageView *line3=[self createImageViewFrame:CGRectMake(2, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
    UIImageView *line4=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
    [self.view addSubview:line3];
    [self.view addSubview:line4];

    
    
    CGRect frame=[UIScreen mainScreen].bounds;
    UIView* bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 75, frame.size.width-20, 100)];
    bgView.layer.cornerRadius=3.0;
    bgView.alpha=0.7;
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    user=[self createTextFielfFrame:CGRectMake(60, 10, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
    //user.text=@"13419693608";
    user.keyboardType=UIKeyboardTypeNumberPad;
    user.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    pwd=[self createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    //pwd.text=@"123456";
    //密文样式
    pwd.secureTextEntry=YES;
    //pwd.keyboardType=UIKeyboardTypeNumberPad;
    
    
    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"username" color:nil];
    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"password" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, self.view.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [bgView addSubview:user];
    [bgView addSubview:pwd];
    
    [bgView addSubview:userImageView];
    [bgView addSubview:pwdImageView];
    [bgView addSubview:line1];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, 390, 140, 21)];
    label.text=@"第三方账号快速登录";
    label.textColor=[UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];

    
}

#pragma mark - 按钮响应函数
- (void)landClick
{
    NSLog(@"登陆");
}

- (void)registration
{
    NSLog(@"快速注册");
    RegistViewController* regist = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
    
    
}

- (void)fogetPwd
{
    NSLog(@"忘记密码");
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];

   ForgetPasswordViewController* forget = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}

- (void)onClickWX
{
    NSLog(@"微信登陆");
}

- (void)onClickQQ
{
    NSLog(@"qq登陆");
}

- (void)onClickSina
{
    NSLog(@"新浪登陆");
}


-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
