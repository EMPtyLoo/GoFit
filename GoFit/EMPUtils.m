//
//  EMPUtils.m
//  GoFit
//
//  Created by EMPty on 3/3/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "EMPUtils.h"

@implementation EMPUtils

+ (void)dealWithFirstInfo:(NSString* )filenameWithPlist//写入沙盒
{
    //读取plist
    NSString* path = [[NSBundle mainBundle] pathForResource:filenameWithPlist ofType:nil];
    NSArray*  Data = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"%@",Data);
    //获取应用程序沙盒程序的Documents目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString* filename = [plistPath stringByAppendingPathComponent:filenameWithPlist];
    //输入写入
    [Data writeToFile:filename atomically:YES];
    
}

+ (NSArray*)readFile:(NSString* )filenameWithPlist//从沙盒读出文件
{
    //获取应用程序沙盒程序的Documents目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString* filename = [plistPath stringByAppendingPathComponent:filenameWithPlist];
    NSArray* data =[NSArray arrayWithContentsOfFile:filename];
    return data;
}

+ (float) EMPOSVertion//返回设备的系统版本
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];

}

+ (BOOL) EMPIsKeyboardVisable//检测键盘是否弹出
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return ![window isFirstResponder];
}

+ (CGRect) EMPAppicationBounds//屏幕尺寸
{
    return [UIScreen mainScreen].bounds;

}

+ (void) logFrameTest:(CGRect*) frame//调试尺寸
{
    NSLog(@"x = %f,y = %f,width = %f,height = %f",frame->origin.x,frame->origin.y,frame->size.width,frame->size.height);
}

+ (void) changeNavigationBarColor:(UIColor*) color//改变导航栏颜色
{
    [[UINavigationBar appearance] setBarTintColor:color];

}



+ (UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
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

+ (UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
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


+ (NSString*) string2UTF8String:(NSString*)str
{
    
    //转换成UTF-8
    
    NSString *dataUTF8 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return dataUTF8;

}

+ (NSString* ) string2EncodingURL:(NSString* ) str
{
    NSString* dataEncodeURL = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, nil, nil, kCFStringEncodingUTF8));
    return dataEncodeURL;
}


@end
