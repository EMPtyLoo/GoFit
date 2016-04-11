//
//  EMPUtils.h
//  GoFit
//
//  Created by EMPty on 3/3/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EMPUtils : NSObject
+ (float) EMPOSVertion;//返回设备的系统版本
+ (BOOL) EMPIsKeyboardVisable;//检测键盘是否弹出
+ (CGRect) EMPAppicationBounds;//屏幕尺寸
+ (void) logFrameTest:(CGRect*) frame;//调试尺寸
+ (void) changeNavigationBarColor:(UIColor*) color;//改变导航栏颜色
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color;//快速创建图片视图
+ (UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder;//快速创建文本框
+ (UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action;//快速创建按钮
+ (void)dealWithFirstInfo:(NSString* )filenameWithPlist;//写入沙盒
+ (NSArray*)readFile:(NSString* )filenameWithPlist;//从沙盒读出文件

+ (NSString*) string2UTF8String:(NSString*)str;//string转UTF8格式
+ (NSString* ) string2EncodingURL:(NSString* ) str;//string转encodeURL格式
@end
