//
//  OralDetailViewController.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-1.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "PBaseViewController.h"
#import "MJAppDelegate.h"
#import "OralsInfoBean.h"
@interface OralDetailViewController : PBaseViewController
{
    OralsInfoBean *oralInfo;
}
@property (retain, nonatomic) IBOutlet UIButton *toudiButton;
- (IBAction)toudiButtonClick:(id)sender;
@property (retain, nonatomic) IBOutlet UITextView *companyNameText;
@property (retain, nonatomic) IBOutlet UITextField *gangweiText;
@property (retain, nonatomic) IBOutlet UITextField *oralTimeText;

@property (retain, nonatomic) IBOutlet UITextView *oralAddrText;

@property (retain, nonatomic) IBOutlet UITextField *oralSalaryText;
@property (retain, nonatomic) IBOutlet UITextField *oralWorkYear;

@property (retain, nonatomic) IBOutlet UITextField *oralTelText;

@end
