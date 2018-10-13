//
//  NSString+SQPopupString.m
//  SQPopupView
//
//  Created by DOFAR on 2018/10/12.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import "NSString+SQPopupString.h"

@implementation NSString (SQPopupString)
-(CGSize)getStringSizeWithRectSize:(CGSize)rectSize andFontSize:(CGFloat)fontSize{
    return  [self boundingRectWithSize:rectSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}
@end
