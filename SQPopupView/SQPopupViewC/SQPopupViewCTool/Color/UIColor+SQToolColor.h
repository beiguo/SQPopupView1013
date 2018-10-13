//
//  UIColor+SQToolColor.h
//  Test
//
//  Created by DOFAR on 2018/10/11.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SQToolColor)
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
//获取16进制颜色的方法
+ (UIColor *)colorWithHex:(NSString *)hexColor;
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
@end
