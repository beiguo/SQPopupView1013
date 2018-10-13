//
//  SQPopupGradientButton.m
//  Test
//
//  Created by DOFAR on 2018/10/11.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import "SQPopupGradientButton.h"
#import "UIColor+SQToolColor.h"

@implementation SQPopupGradientButton

- (void)awakeFromNib{
    [super awakeFromNib];
    [self changeUI];
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self changeUI];
    }
    return self;
}

-(void)changeUI{
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = 3;
    [self.layer addSublayer:[UIColor setGradualChangingColor:self fromColor:@"00a2ff" toColor:@"2ddaff"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
