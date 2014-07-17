//
//  MyInfoViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-27.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MyInfoViewController.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (IBAction)doneButtonOnClick:(id)sender {
    //提交个人资料
    NSString* name = self.nameTextField.text;
    NSString* idCard = self.idCardTextField.text;
    NSString* salary = self.salaryTextField.text;
    NSString* workType = self.typeWorkTextField.text;
    NSString* currentState = self.currentStateTextField.text;
    _myinfos = [MyInfosBean alloc];
    _myinfos.name = name;
    _myinfos.idCard = idCard;
    _myinfos.salary = salary;
    _myinfos.workType = workType;
    _myinfos.currentState = currentState;
    if ((name.length == 0 && name.length > 10) || idCard.length != 18 || (salary.length == 0 && name.length > 15) ) {
        [self showMessageDialog:@"请检查内容是否合法!"];
    }else{
        NSLog(@"name:%@ -- id:%@ -- salary:%@" , name , idCard , salary);
        [self commitMyInfos:_myinfos];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* t = [alertView buttonTitleAtIndex:buttonIndex];
    if (workTypeAlert) {
        _typeWorkTextField.text = t;
    }else{
        _currentStateTextField.text = t;
    }
}
- (IBAction)workTypeButtonClick:(id)sender {
    workTypeAlert = YES;
    //弹出工作类型对话框
    UIAlertView* alertView = [[UIAlertView alloc]init];
    alertView.delegate = self;
    alertView.title = @"选择工种";
    [alertView addButtonWithTitle:@"不限"];
    [alertView addButtonWithTitle:@"管理"];
    [alertView addButtonWithTitle:@"服务"];
    [alertView addButtonWithTitle:@"销售"];
    [alertView addButtonWithTitle:@"技工"];
    [alertView addButtonWithTitle:@"普工"];
    [alertView show];
}

- (IBAction)currentStateButtonClick:(id)sender {
    //弹出当前状态对话框
    workTypeAlert = NO;
    UIAlertView* alertView = [[UIAlertView alloc]init];
    alertView.delegate = self;
    alertView.title = @"工作状态";
    [alertView addButtonWithTitle:@"在职急于找工作"];
    [alertView addButtonWithTitle:@"离职正在找工作"];
    [alertView addButtonWithTitle:@"在职不急于找工作"];
    [alertView show];
}

-(void)commitMyInfos:(MyInfosBean *)myinfos{
    if (myinfos != nil) {
        NSString* url = [WURL_BASE_URL stringByAppendingString:WURL_COMMIT_USERINFO_HEADERIMAGE];
        ASIFormDataRequest *req = [self getPostHttpRequest:url];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([ud boolForKey:WKEY_SAVE_USERINFO]) {
            //修改资料
            NSString *userId = [ud objectForKey:WCONFIGKEY_USERID];
            if (![self isEmpty:userId]) {
                url = [WURL_BASE_URL stringByAppendingString:WURL_UPDATE_USER_INFO];
                [req setPostValue:userId forKey:WCONFIGKEY_USERID];
            }
        }
        NSString* pm =[self getPhoneNumber];
        [req setPostValue:pm forKey:WPOST_PARAMS_TEL];
        [req setPostValue:myinfos.idCard forKey:WPOST_PARAMS_IDCARD];
        [req setPostValue:myinfos.salary forKey:WPOST_PARAMS_SALARY];
        [req setPostValue:myinfos.workType forKey:WPOST_PARAMS_WORK_TYPE];
        [req setPostValue:myinfos.currentState forKey:WPOST_PARAMS_USER_STATE];
        [req startAsynchronous];
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    [super requestFinished:request];
    NSString* response = [request responseString];
    NSDictionary *dic = [self getDicByNSString:response];
    NSString *code = [dic objectForKey:WPOST_REQUEST_CODE];
    NSLog(@"用户ID：%@",code);
    if ([self isEmpty:code]) {
        [self showMessageDialog:@"注册失败"];
    }else{
        //保存用户ID
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *userId = [ud objectForKey:WCONFIGKEY_USERID];
        if ([self isEmpty:userId]) {
            [ud setObject:code forKey:WCONFIGKEY_USERID];
        }
        //保存用户资料
        [ud setObject:_myinfos.name forKey:WPOST_PARAMS_USERNAME];
        [ud setObject:_myinfos.idCard forKey:WPOST_PARAMS_IDCARD];
        [ud setObject:_myinfos.salary forKey:WPOST_PARAMS_SALARY];
        [ud setObject:_myinfos.workType forKey:WPOST_PARAMS_WORK_TYPE];
        [ud setObject:_myinfos.currentState forKey:WPOST_PARAMS_USER_STATE];
        [ud setBool:YES forKey:WKEY_SAVE_USERINFO];
        //设置面试次数
        [ud setInteger:5  forKey:WKEY_ORAL_COUNT];
        //回到主界面
            self.navigationItem.backBarButtonItem.enabled = YES;
        [self.navigationController popToRootViewControllerAnimated:true];
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [super requestFailed:request];
}
-(void)hideKeyboard
{
    [self.nameTextField resignFirstResponder];
    [self.idCardTextField resignFirstResponder];
    [self.salaryTextField resignFirstResponder];
    [self.typeWorkTextField resignFirstResponder];
    [self.currentStateTextField resignFirstResponder];


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人资料";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.backBarButtonItem.enabled = NO;
    // Do any additional setup after loading the view.
    self.nameTextField.delegate = self;
    self.idCardTextField.delegate = self;
    self.salaryTextField.delegate = self;
    self.typeWorkTextField.delegate = self;
    self.currentStateTextField.delegate = self;
    //初始化手机号码
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *phone = [def objectForKey:WKEY_PHONE_NUMBER];
    NSString* ps = @"手机号码:";
    _phoneNameLable.text = [ps stringByAppendingString:phone];
    //初始化个人资料
    MyInfosBean *userInfo = [self getUserInfo];
    if (![self isEmpty:userInfo.name]) {
        NSString *userId = [def objectForKey:WCONFIGKEY_USERID];
        long oralCount = [def integerForKey:WKEY_ORAL_COUNT];
        NSString* userIdStr = @"用户ID:";
        NSString* oralCountStr = @"面试次数:";
        _userIdLable.text = [userIdStr stringByAppendingString:userId];
        _oralCountLable.text = [oralCountStr stringByAppendingString:[NSString stringWithFormat:@"%li" , oralCount]];
        self.navigationItem.hidesBackButton = NO;
        _nameTextField.text = userInfo.name;
        _nameTextField.enabled = NO;
        _idCardTextField.text = userInfo.idCard;
        _idCardTextField.enabled = NO;
        _salaryTextField.text = userInfo.salary;
        _typeWorkTextField.text = userInfo.workType;
        _currentStateTextField.text = userInfo.currentState;
        //设置评分图片
        UIImage *image = [UIImage imageNamed:@"rating_full.png"];
        [_ratingImage setImage:image];

    }else{
        self.navigationItem.hidesBackButton = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideKeyboard];
    return YES;
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
    [_nameTextField release];
    [_idCardTextField release];
    [_salaryTextField release];
    [_typeWorkTextField release];
    [_currentStateTextField release];
    [_phoneNameLable release];
    [_userIdLable release];
    [_userIdLable release];
    [_oralCountLable release];
    [_doneButton release];
    [_myinfos release];
    [_ratingImage release];
    [super dealloc];
}
@end
