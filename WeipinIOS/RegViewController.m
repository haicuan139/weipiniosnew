//
//  RegViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-26.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "RegViewController.h"
#import "HaoYouViewController.h"
#import "BPush.h"
@interface RegViewController ()

@end

@implementation RegViewController

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
    // Do any additional setup after loading the view.
    self.title = @"验证";
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//}


- (void)dealloc {
    [_sendCodeButton release];
    [_phoneNumberTextField release];
    [_checkCodeTextField release];
    [_nextButton release];
    [timer invalidate];
    [timer release];
    [code release];
    [super dealloc];
}
- (IBAction)sendCodeOnClick:(id)sender {
    //获取手机号码
    NSString* number = _phoneNumberTextField.text;
    if (number.length != 11) {
        [self showMessageDialog:@"请输入正确的手机号码!"];
    }else{
        //发送验证码
        ASIFormDataRequest *request = [self getPostHttpRequest:[WURL_BASE_URL stringByAppendingString:WURL_SEND_TEL_MESSAGE]];
        [request setPostValue:number forKey:@"telephoNum"];
        [request startAsynchronous];
        timerCount = 30;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
        [timer retain];
        [timer fire];
    }
}

- (void)timerSelector{
    timerCount = timerCount - 1;
    [_sendCodeButton setEnabled:NO];
    if (timerCount == 0) {
        [timer invalidate];
        timerCount = 30;
        [_sendCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendCodeButton setEnabled:YES];
    }else{
        NSString *text = [[NSString alloc]initWithFormat:@"%d",timerCount];

        [_sendCodeButton setTitle:text forState:UIControlStateDisabled];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSString *responseString = [request responseString];
    NSDictionary *dic = [self getDicByNSString:responseString];
    code = [dic objectForKey:@"validateCode"];
    [code retain];
    NSLog(@"code:%@",code);

}
- (IBAction)nextOnClick:(id)sender {
    NSString* tCode = _checkCodeTextField.text;
    if([tCode isEqualToString:@"9102"]){
        //测试代码 直接进入主界面
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:@"10055" forKey:WCONFIGKEY_USERID];
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setBool:YES forKey:WKEY_CHECK_STATE_BOOL];
        [def setBool:YES forKey:WKEY_FIRST_RUN_KEY];
        [def setObject:@"13922222222" forKey:WKEY_PHONE_NUMBER];
        //用户测试信息
        [def setObject:@"test" forKey:WPOST_PARAMS_USERNAME];
        [def setObject:@"120332222111332221" forKey:WPOST_PARAMS_IDCARD];
        [def setObject:@"900" forKey:WPOST_PARAMS_SALARY];
        [def setObject:@"兼职" forKey:WPOST_PARAMS_WORK_TYPE];
        [def setObject:@"正在找工作" forKey:WPOST_PARAMS_USER_STATE];
        [def setBool:YES forKey:WKEY_SAVE_USERINFO];
        //设置面试次数
        [ud setInteger:5  forKey:WKEY_ORAL_COUNT];
        [self pushViewControllerWithStorboardName:@"myinfos" sid:@"myinfos"];
    }else{
        if (tCode.length != 4) {
            [self showMessageDialog:@"验证码有误"];
        }else{
            if ([code isEqualToString:tCode]) {
                //验证成功
                NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                [def setBool:YES forKey:WKEY_CHECK_STATE_BOOL];
                //保存手机号码
                NSString* phoneNumber =  _phoneNumberTextField.text;
                [def setObject:phoneNumber forKey:WKEY_PHONE_NUMBER];
                [self pushViewControllerWithStorboardName:@"myinfos" sid:@"myinfos"];
            }else{
                [self showMessageDialog:@"验证码有误"];
            }
        }
    }
}

@end
