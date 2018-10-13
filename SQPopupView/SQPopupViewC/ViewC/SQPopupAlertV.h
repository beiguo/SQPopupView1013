//
//  SQPopupAlertV.h
//  SQPopupView
//
//  Created by DOFAR on 2018/10/12.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SQPopupAlertVDelegate<NSObject>
-(void)clickOtherOneBtn;
-(void)clickOtherTwoBtn;
-(void)cancle;
@end

@interface SQPopupAlertV : UIView

/**
 设置SQPopupAlertV参数
 
 @param title 标题
 @param imgName 消息提示图名字，可以为nil，nil或图错误是不会创建提示图
 @param message 消息内容
 @param delegate delegate
 @param cancleButtonTitle 取消btn的title，为nil时，不会创建cancleBtn
 @param otherButtonTitles 其他btn的title，最多可以为2个
 */
-(void)setTitle:(NSString*)title
   andImageName:(NSString*)imgName
     andMessage:(NSString*)message
    andDelegate:(id <SQPopupAlertVDelegate>)delegate
andCancleButtonTitle:(NSString*)cancleButtonTitle
andOtherButtonTitles:(NSString*)otherButtonTitles;

@end
