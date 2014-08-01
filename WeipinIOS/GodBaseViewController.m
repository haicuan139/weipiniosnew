//
//  GodBaseViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "GodBaseViewController.h"

@interface GodBaseViewController ()

@end

@implementation GodBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem* right = [self getRightItem];
    self.navigationItem.rightBarButtonItem = right;
    [right release];
}
-(void)showMessageDialog:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc ] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ];
    [alert show];
    
}
-(ASIHTTPRequest *)getNormalHttpRequest : (NSString *)url
{
    NSURL *myurl = [NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:myurl];
    
    request.delegate = self;
    return request;
}
-(ASIFormDataRequest *) getPostHttpRequest : (NSString *)url{
    NSURL *myurl = [NSURL URLWithString:url];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:myurl];
    request.delegate = self;
    return request;
}
-(void)requestFinished:(ASIHTTPRequest *)request{

    [[UIApplication sharedApplication ] setStatusBarHidden:YES];
}

-(void)requestStarted:(ASIHTTPRequest *)request
{

    [[UIApplication sharedApplication ] setNetworkActivityIndicatorVisible:YES];
}
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id
{
    NSLog(@"调用了PushView");
    UIStoryboard* st = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *controller = [st instantiateViewControllerWithIdentifier:id];
    [controller retain];
    [self pushViewControllerWithController:controller];
    
}
-(void)pushViewControllerWithController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)requestFailed:(ASIHTTPRequest *)request
{

    [[UIApplication sharedApplication ] setStatusBarHidden:YES];
    [self showMessageDialog:@"网络连接错误"];
    NSError *error = [request error];
    NSLog(@"code:%li -- des:%@",(long)error.code , error.description);
}
-(NSString *)getPhoneNumber{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return  [ud objectForKey:WKEY_PHONE_NUMBER];
}
-(NSDictionary *)getDicByNSString:(NSString *) string{
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dic;
}
-(BOOL)isEmpty:(NSString *)string{
    if (string == nil || string.length == 0) {
        return YES;
    }
    return NO;
}
-(MyInfosBean *)getUserInfo{
    MyInfosBean * infos = [MyInfosBean alloc];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    infos.name    = [ud objectForKey:WPOST_PARAMS_USERNAME];
    infos.userId = [ud objectForKey :WCONFIGKEY_USERID];
    infos.idCard = [ud objectForKey :WPOST_PARAMS_IDCARD];
    infos.salary = [ud objectForKey :WPOST_PARAMS_SALARY];
    infos.workType = [ud objectForKey :WPOST_PARAMS_WORK_TYPE];
    infos.currentState = [ud objectForKey :WPOST_PARAMS_USER_STATE];
    return infos;
}
- (id)toArrayOrNSDictionary:(NSString *)json{
    NSError *error = nil;
    NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                options:NSJSONReadingAllowFragments
                                  error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}
-(void)sendRequest:(NSString *)url{
    ASIFormDataRequest *req = [self getPostHttpRequest:url];
    NSString* userId = [self getUserId];
    [req setPostValue:userId forKey:WCONFIGKEY_USERID];
    [req startAsynchronous];
}
-(void)sendRequest{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString* uid = [ud objectForKey:WCONFIGKEY_USERID];
    if (![self isEmpty:uid]) {
        NSString *url = [WURL_BASE_URL stringByAppendingString:WURL_ORAL_LIST];
        [self sendRequest:url];
    }
}
-(OralsInfoBean *)dicToOralInfo:(NSDictionary *)dic{
    OralsInfoBean *oi = [[OralsInfoBean alloc] init];
    NSString* oid = [NSString stringWithFormat:@"%@",[dic objectForKey:WKEY_ORALINFO_ID]];
    oi.cellOralId = oid;
    NSLog(@"ORALID:%@",[dic objectForKey:WKEY_ORALINFO_ID]);
    oi.cellAddress = [dic objectForKey:WKEY_ORALINFO_COMPANADDRESS];
    oi.cellNCompanyName = [dic objectForKey:WKEY_ORALINFO_COMPANYNAME];
    oi.cellJob = [dic objectForKey:WKEY_ORALINFO_GANGWEI];
    //面试状态
    oi.cellOralRst = [dic objectForKey:WKEY_ORALINFO_REST];
    //面试状态
    oi.cellOralState = [dic objectForKey:WKEY_ORALINFO_REST];
    oi.cellTime = [dic objectForKey:WKEY_ORALINFO_TIME];
    oi.cellCreateTime = [dic objectForKey:WKEY_ORALINFO_TIME];
    oi.cellSalary = [dic objectForKey:WKEY_ORALINFO_SALARY];
    oi.cellOralTel = [dic objectForKey:WKEY_ORALINFO_TEL];
    oi.cellOralTime = [dic objectForKey:WKEY_ORALINFO_ORALTIME];//TODO:改为面试时间
    //面试地址
    oi.cellOralAddress = [dic objectForKey:WKEY_ORALINFO_COMPANYNAME];

    //面试时间
    //工作类型
    oi.cellOralWorkType = [dic objectForKey:WKEY_WORK_TYPE];
    //联系人
    oi.cellOralContacts = [dic objectForKey:WKEY_LINKMAN];
    //入职时间
    oi.cellOfferTime = [dic objectForKey:WKEY_EMP_TIME];
    //工作年限
    oi.cellWorkYear = [dic objectForKey:WKEY_WORK_YEAR];;
    return oi;
}
-(void)sendTouDiRequest:(NSString *)oralId{
    NSString *url = [WURL_BASE_URL stringByAppendingString:WURL_OREL_TOUDI];
    ASIFormDataRequest *req = [self getPostHttpRequest:url];
    [req setPostValue:@"1" forKey:WKEY_ORALINFO_REST];
    [req setPostValue:oralId forKey:WKEY_ORALINFO_ID];
    [req startAsynchronous];
}
- (NSString *)getUserId{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:WCONFIGKEY_USERID];
}

- (void)sendFeedBackRequest:(NSString *)content{
        NSString *purl = [WURL_BASE_URL stringByAppendingString:WURL_URL_FEEDBACK];
        ASIFormDataRequest* req = [self getPostHttpRequest:purl];
        [req setPostValue:content forKey:@"content"];
        [req setPostValue:@"IOS手机客户端" forKey:@"source"];
        [req setPostValue:@"建议反馈" forKey:@"title"];
        [req startAsynchronous];
}
-(UIBarButtonItem *)getLeftItem{
    UIImage *logo = [UIImage imageNamed:@"title_logo.png"];
    UIImageView *tLogoView = [[UIImageView alloc] init];
    tLogoView.frame = CGRectMake(0, 0, 30, 30);
    [tLogoView setImage:logo];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:tLogoView];
    [leftItem setImage:logo];
    return leftItem;
}
-(UIBarButtonItem *)getRightItem{
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"more_icon" ofType:@"png"];
//    UIImage* more = [[UIImage alloc ] initWithContentsOfFile:path];
//    UIImage* more = [UIImage imageNamed:@"more_icon.png"];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:more style:UIBarButtonItemStylePlain target:self action:@selector(onRightBarItemClick)];
//    [rightItem setTintColor:[UIColor whiteColor]];
//    UIButton* morebt = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIBarButtonItem *m = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onRightBarItemClick)];
    [m setTintColor:[UIColor whiteColor]];
    return m;
}

-(void)onRightBarItemClick{
    [self pushViewControllerWithStorboardName:@"more" sid:@"more"];
}
//这个方法暂时没使用
-(void)onLeftBarItemClick{
    
}
@end
