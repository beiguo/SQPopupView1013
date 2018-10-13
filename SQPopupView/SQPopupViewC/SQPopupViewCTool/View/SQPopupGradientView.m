//
//  SQPopupGradientView.m
//  Test
//
//  Created by DOFAR on 2018/10/11.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import "SQPopupGradientView.h"
#import "UIColor+SQToolColor.h"

@implementation SQPopupGradientView

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
    [self.layer addSublayer:[UIColor setGradualChangingColor:self fromColor:@"00a2ff" toColor:@"2ddaff"]];
}

@end
