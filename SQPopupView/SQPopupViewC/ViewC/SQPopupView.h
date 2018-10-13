//
//  SQPopupView.h
//  SQPopupView
//
//  Created by DOFAR on 2018/10/12.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SQPopupViewStyle) {
    SQPopupViewStyleDefaule,
    SQPopupViewStylePlainTextInput,
};

@class SQPopupView;
@protocol SQPopupViewDelegate<NSObject>
-(void)popupView:(SQPopupView*)popupView clickButtonAtInder:(NSInteger)buttonIndex;
@end

@interface SQPopupView : UIView



/**
 设置popupview参数

 @param title 标题
 @param imgName 消息提示图名字，可以为nil，nil或图错误是不会创建提示图
 @param message 消息内容
 @param popviewStyle 设置弹框类型
 @param placeholder 当是输入类型时，设置placeholder
 @param isCan 点击外面是否可以退出,如果SQPopupViewStylePlainTextInput，则不起作用
 @param cancleButtonTitle 取消btn的title，为nil时，不会创建cancleBtn
 @param otherButtonTitles 其他btn的title，最多可以为2个
 */
-(void)setTitle:(NSString*)title
   andImageName:(NSString*)imgName
     andMessage:(NSString*)message
andPopupViewStyle:(SQPopupViewStyle)popviewStyle
 andPlaceholder:(NSString*)placeholder
andTapOutsideExit:(BOOL)isCan
andCancleButtonTitle:(NSString*)cancleButtonTitle
andOtherButtonTitles:(NSString*)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION;


/**
 show
 */
-(void)show;


/**
 得到输入框的输入

 @return 输入框的输入字符串
 */
-(NSString*)getInputTextFieldString;


/**
 BLOCK

 @param aBlock aBlock description
 */
-(void)handlerClickButton:(void (^)(NSInteger btnIndex))aBlock;
@end
