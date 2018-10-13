//
//  ViewController.m
//  SQPopupView
//
//  Created by DOFAR on 2018/10/12.
//  Copyright © 2018年 DOFAR. All rights reserved.
//

#import "ViewController.h"
#import "SQPopupView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)clickBtn:(id)sender {
    [self createPopupView];
}

-(void)createPopupView{
    
    SQPopupView* view = [[[NSBundle mainBundle]loadNibNamed:@"SQPopupView" owner:self options:nil] firstObject];
    
    [view setTitle:@"AAA"
      andImageName:@"popupViewAnswer"
        andMessage:@"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
 andPopupViewStyle:SQPopupViewStylePlainTextInput
    andPlaceholder:@"HWLLOOOOO"
 andTapOutsideExit:YES
andCancleButtonTitle:@"Cancle"
andOtherButtonTitles:@"Hello",@"Ni", nil];
    
    [view handlerClickButton:^(NSInteger btnIndex) {
        NSLog(@"buttonIndex->%ld   text->%@",(long)btnIndex,[view getInputTextFieldString]);
    }];
    
    [self.view addSubview:view];
    
    [view show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
