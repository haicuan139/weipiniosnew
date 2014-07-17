//
//  RegViewController.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-26.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBaseViewController.h"
@interface RegViewController : PBaseViewController
{
    int timerCount;
    NSTimer *timer;
    NSString* code;

}
@property (retain, nonatomic) IBOutlet UIButton *sendCodeButton;
@property (retain, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (retain, nonatomic) IBOutlet UITextField *checkCodeTextField;
@property (retain, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)sendCodeOnClick:(id)sender;
- (IBAction)nextOnClick:(id)sender;
@end
