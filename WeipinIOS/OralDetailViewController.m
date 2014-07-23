//
//  OralDetailViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-1.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "OralDetailViewController.h"
@interface OralDetailViewController ()

@end

@implementation OralDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"详细";
    MJAppDelegate *appDelegate = (MJAppDelegate *)[[UIApplication sharedApplication] delegate];
    oralInfo = appDelegate.oralInfos;
    if (![oralInfo.cellOralRst isEqualToString:@"0"]) {
        _toudiButton.hidden = YES;
    }else{
        _toudiButton.hidden = NO;
    }
    _companyNameText.text = oralInfo.cellNCompanyName;
    _gangweiText.text = oralInfo.cellJob;
    _oralTimeText.text = oralInfo.cellOralTime;
    _oralAddrText.text = oralInfo.cellAddress;
    _oralTelText.text = oralInfo.cellOralTel;
    NSString *s = @"元/月(税前)";
    _oralSalaryText.text = [oralInfo.cellSalary stringByAppendingString:s];
    _oralWorkYear.text =[ oralInfo.cellWorkYear stringByAppendingString:@"年"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_toudiButton release];
    [_companyNameText release];
    [_oralTimeText release];
    [_oralAddrText release];
    [_oralTelText release];
    [_oralTimeText release];
    [_oralAddrText release];
    [oralInfo release];
    [_oralSalaryText release];
    [_oralWorkYear release];
    [super dealloc];
}
- (IBAction)toudiButtonClick:(id)sender {
    [self sendTouDiRequest:oralInfo.cellOralId];
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [super requestFailed:request];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    [super requestFinished:request];
    NSString* content = [request responseString];
    NSDictionary* dic = [self getDicByNSString:content];
    NSString *code = [dic objectForKey:@"code"];
    if (![self isEmpty:code] && [code isEqualToString:@"1"]) {
        //申请成功
        [self showMessageDialog:@"申请成功"];
        //面试次数-1
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        long oralCount = [ud integerForKey:WKEY_ORAL_COUNT];
        oralCount = oralCount - 1;
        [ud setInteger:oralCount forKey:WKEY_ORAL_COUNT];
    }else{
        //申请失败
        [self showMessageDialog:@"申请失败"];
    }
}
@end
