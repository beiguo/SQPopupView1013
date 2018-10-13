//
//  SQPopupAlertV.m
//  SQPopupView
//
//  Created by DOFAR on 2018/10/12.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import "SQPopupAlertV.h"
#import "SQPopupGradientButton.h"
#import "NSString+SQPopupString.h"


static const int kMassageFontSize = 14;
static const float kMessaeTextViewMaxHeight = 130.0;

@interface SQPopupAlertV()

@property (nonatomic,weak) id<SQPopupAlertVDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet SQPopupGradientButton *otherButton1;
@property (weak, nonatomic) IBOutlet SQPopupGradientButton *otherButton2;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgVTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgVHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imessageTextViewTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewTrailingSafeArea;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherButton1TopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherButton1Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherButton2TopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherButton2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancleTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancleHeight;

@end

@implementation SQPopupAlertV

-(void)setTitle:(NSString*)title
   andImageName:(NSString*)imgName
     andMessage:(NSString*)message
    andDelegate:(id <SQPopupAlertVDelegate>)delegate
andCancleButtonTitle:(NSString*)cancleButtonTitle
andOtherButtonTitles:(NSString*)otherButtonTitles{
    //标题
    _titleLable.text = title;
    //判断是否有图
    if (!imgName) {
        [self noImg];
    }else{
        _imgV.image = [UIImage imageNamed:imgName];
    }
    //判断是否有message
    if (!message || [message isEqualToString:@""]) {
        [self noMessage];
    }else{
        _messageTextView.text = message;
        [self changeTextViewHeightWithMessage:message];
    }
    //判断other的按钮有几个
    if (!otherButtonTitles || [otherButtonTitles isEqualToString:@""]) {//一个也没有
        [self noOtherButton];
    }else{
        NSArray* otherBtnTitles = [otherButtonTitles componentsSeparatedByString:@","];
        if (otherBtnTitles.count == 1) {//有一个
            [self haveOneOtherBtnWithTitle:otherBtnTitles[0]];
        }else if(otherBtnTitles.count == 2){ //有两个
            [self haveTwoOtherBtnWithTitle1:otherBtnTitles[0] andTitle2:otherBtnTitles[1]];
        }
    }

    if (!cancleButtonTitle || [cancleButtonTitle isEqualToString:@""]) {
        [self noCancleBtn];
    }else{
        [self haveCancleBtnWithTitle:cancleButtonTitle];
    }
    [self changeSelfHeight];
    _delegate = delegate;
}

-(void)noImg{
    _imgV.hidden = YES;
    _imgVHeight.constant = 0;
    _imgVTopSpace.constant = 0;
    [self layoutIfNeeded];
}

-(void)changeTextViewHeightWithMessage:(NSString*)message{
    CGFloat messageTextMaxWidth = self.frame.size.width - 2*_messageTextViewTrailingSafeArea.constant - 16;
    CGSize size = [message getStringSizeWithRectSize:CGSizeMake(messageTextMaxWidth, MAXFLOAT) andFontSize:kMassageFontSize];
    if (size.height+16 > kMessaeTextViewMaxHeight) {
        _messageTextViewHeight.constant = kMessaeTextViewMaxHeight;
        _messageTextView.scrollEnabled = YES;
    }else{
        _messageTextViewHeight.constant = size.height+16;
        _messageTextView.scrollEnabled = NO;
    }
}

-(void)noMessage{
    _messageTextView.hidden = YES;
    _messageTextViewHeight.constant = 0;
    _imessageTextViewTopSpace.constant = 0;
}

-(void)noOtherButton{
    _otherButton1.hidden = YES;
    _otherButton1Height.constant = 0;
    _otherButton1TopSpace.constant = 0;
    
    
}

-(void)haveOneOtherBtnWithTitle:(NSString*)title{
    [_otherButton1 setTitle:title forState:UIControlStateNormal];
    
    _otherButton2.hidden = YES;
    _otherButton2Height.constant = 0;
    _otherButton2TopSpace.constant = 0;
}

-(void)haveTwoOtherBtnWithTitle1:(NSString*)title1 andTitle2:(NSString*)title2{
    [_otherButton1 setTitle:title1 forState:UIControlStateNormal];
    [_otherButton2 setTitle:title2 forState:UIControlStateNormal];
}

-(void)noCancleBtn{
    _cancleButton.hidden = YES;
    _cancleHeight.constant = 0;
    _cancleTopSpace.constant = 0;
}

-(void)haveCancleBtnWithTitle:(NSString*)title{
    [_cancleButton setTitle:title forState:UIControlStateNormal];
}

-(void)changeSelfHeight{
    CGFloat height = 50 + _imgVTopSpace.constant + _imgVHeight.constant + _imessageTextViewTopSpace.constant + _messageTextViewHeight.constant + _otherButton1TopSpace.constant + _otherButton1Height.constant + _otherButton2TopSpace.constant + _otherButton2Height.constant + _cancleTopSpace.constant + _cancleHeight.constant + 20;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (IBAction)onclickOtherButton1:(id)sender {
    [_delegate clickOtherOneBtn];
}

- (IBAction)onclickOtherButton2:(id)sender {
    [_delegate clickOtherTwoBtn];
}

- (IBAction)onclickCancleButton:(id)sender {
    [_delegate cancle];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
