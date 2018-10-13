//
//  SQPopupView.m
//  SQPopupView
//
//  Created by DOFAR on 2018/10/12.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import "SQPopupView.h"
#import "SQPopupAlertV.h"
#import "UIColor+SQToolColor.h"
#import "SQPopupTextInputV.h"
#import <objc/runtime.h>

static const NSInteger      kPopupViewRadius = 7;
static const NSTimeInterval kInAnimationDuration = 0.5;
static const NSTimeInterval kOutAnimationDuration = 0.4;
static const NSTimeInterval kStartEditingAnimationDuration = 0.4;
static const NSTimeInterval kEndEditingAnimationDuration = 0.2;

@interface SQPopupView()<SQPopupAlertVDelegate,SQPopupTextInputVDelegate,SQPopupViewDelegate>{
    SQPopupViewStyle _style;
    
    NSString*   _title;
    NSString*   _imgName;
    NSString*   _message;
    BOOL        _isCan;
    NSString*   _cancleButtonTitle;
    NSArray*    _otherButtonsTitles;
    id <SQPopupViewDelegate>    _delegate;
    NSString*   _placeholder;
}
@property(nonatomic,strong)UIView* popView;
@end

@implementation SQPopupView

-(void)setTitle:(NSString*)title
   andImageName:(NSString*)imgName
     andMessage:(NSString*)message
andPopupViewStyle:(SQPopupViewStyle)popviewStyle
 andPlaceholder:(NSString*)placeholder
andTapOutsideExit:(BOOL)isCan
andCancleButtonTitle:(NSString*)cancleButtonTitle
andOtherButtonTitles:(NSString*)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION{
    self.frame = [[UIScreen mainScreen] bounds];
    
    _title = title;
    _imgName = imgName;
    _message = message;
    _isCan = isCan;
    _cancleButtonTitle = cancleButtonTitle;
    _style = popviewStyle;
    _placeholder =placeholder;
    
    NSMutableArray* arr;
    if(otherButtonTitles){
        arr = [[NSMutableArray alloc]initWithObjects:otherButtonTitles, nil];
        va_list params;
        id argument;
        if (otherButtonTitles) {
            va_start(params, otherButtonTitles);
            while ((argument = va_arg(params, id))) {
                [arr addObject:argument];
            }
            va_end(params);
        }
    }
    
    
    _otherButtonsTitles = [NSArray arrayWithArray:arr];
    self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
    if(isCan){
        [self createTapGestureRecognizer];
    }
    
}


-(void)show{
    switch (_style) {
        case SQPopupViewStyleDefaule:
        {
            _popView = [[[NSBundle mainBundle]loadNibNamed:@"SQPopupAlertV" owner:self options:nil] firstObject];
            SQPopupAlertV* alertV = (SQPopupAlertV*)_popView;
            [alertV setTitle:_title
                andImageName:_imgName
                  andMessage:_message
                 andDelegate:self
        andCancleButtonTitle:_cancleButtonTitle
        andOtherButtonTitles:[_otherButtonsTitles componentsJoinedByString:@","]];
        }
            break;
        case SQPopupViewStylePlainTextInput:
        {
            _popView = [[[NSBundle mainBundle]loadNibNamed:@"SQPopupTextInputV" owner:self options:nil] firstObject];
            SQPopupTextInputV* inputV = (SQPopupTextInputV*)_popView;
            [inputV setTitle:_title
                andImageName:_imgName
                  andMessage:_message
                 andDelegate:self
              andPlaceholder:_placeholder
        andCancleButtonTitle:_cancleButtonTitle
        andOtherButtonTitles:[_otherButtonsTitles componentsJoinedByString:@","]];
        }
            break;
        default:
            break;
    }
    
    _popView.layer.masksToBounds = YES;
    _popView.layer.cornerRadius = kPopupViewRadius;
    _popView.center = CGPointMake(self.center.x, -_popView.frame.size.height/2);
    [self addSubview:_popView];
    [self addInAnimation];
}


-(NSString*)getInputTextFieldString{
    switch (_style) {
        case SQPopupViewStyleDefaule:
            return nil;
            break;
        case SQPopupViewStylePlainTextInput:
        {
            SQPopupTextInputV* inputV = (SQPopupTextInputV*)_popView;
            return inputV.getInputTextFieldString;
        }
            break;
        default:
            break;
    }
}

-(void)handlerClickButton:(void (^)(NSInteger btnIndex))aBlock{
    _delegate = self;
    objc_setAssociatedObject(self, @"SQPopupView_key_clicked", aBlock, OBJC_ASSOCIATION_COPY);
}

- (void)popupView:(SQPopupView *)popupView clickButtonAtInder:(NSInteger)buttonIndex{
    void (^block)(NSInteger btnIndex) = objc_getAssociatedObject(self, @"SQPopupView_key_clicked");
    if (block) block(buttonIndex);
}


//SQPopupTextInputV Delegate
-(void)startEditing{
    [UIView animateWithDuration:kStartEditingAnimationDuration
                     animations:^{
                         self.popView.center = CGPointMake(self.center.x, self.center.y-100);
                     } completion:^(BOOL finished) {}];
}

-(void)endEditing{
    [UIView animateWithDuration:kEndEditingAnimationDuration
                     animations:^{
                         self.popView.center = CGPointMake(self.center.x, self.center.y-40);
                     } completion:^(BOOL finished) {}];
}


//添加点击事件
-(void)createTapGestureRecognizer{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self addGestureRecognizer:tap];
}

-(void)tapView{
    switch (_style) {
        case SQPopupViewStyleDefaule:
            [self addOutAnimation];
            break;
        case SQPopupViewStylePlainTextInput:
        {
            SQPopupTextInputV* inputV = (SQPopupTextInputV*)_popView;
            [inputV textFieldResignFirstResponder];
        }
            break;
        default:
            break;
    }
}

//delegate
-(void)cancle{
    [self addOutAnimation];
}

-(void)clickOtherOneBtn{
    [_delegate popupView:self clickButtonAtInder:1];
    [self addOutAnimation];
}

-(void)clickOtherTwoBtn{
    [_delegate popupView:self clickButtonAtInder:2];
    [self addOutAnimation];
}

//动画
-(void)addInAnimation{
    [UIView animateKeyframesWithDuration:kInAnimationDuration
                                   delay:0
                                 options:(UIViewAnimationOptionCurveEaseIn)
                              animations:^{
                                  switch (self->_style) {
                                      case SQPopupViewStyleDefaule:
                                      {
                                         self.popView.center = CGPointMake(self.center.x, self.center.y-40);
                                      }
                                          break;
                                      case SQPopupViewStylePlainTextInput:{
                                          self.popView.center = CGPointMake(self.center.x, self.center.y-100);
                                      }
                                          break;
                                      default:
                                          break;
                                  }
                                  
                              } completion:^(BOOL finished) {}];
}

-(void)addOutAnimation{
    [UIView animateWithDuration:kOutAnimationDuration
                     animations:^{
                         self.popView.center = CGPointMake(self.center.x, self.frame.size.height+self.popView.bounds.size.height);
                         
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}



@end
