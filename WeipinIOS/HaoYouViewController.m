//
//  HaoYouViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-24.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "HaoYouViewController.h"
#import "BaseViewController.h"
@interface HaoYouViewController ()

@end

@implementation HaoYouViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.title = WSTRING_HAOYOU;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:@"点击分享给好友" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0, 0, 320, 40);
    shareButton.backgroundColor = [UIColor whiteColor];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [shareButton release];

    
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    NSLog(@"点击了分享平台");
}

-(void)onClick{

    NSString *text = @"我通过微聘获得了一家公司的录用通知,大家快来使用微聘吧真的很好用!";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53bcfc2056240bf0470623e7"
                                      shareText:text//文字
                                     shareImage:@"logot.png" //图片
                                shareToSnsNames:nil
                                       delegate:self];
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        //分享成功.面试次数++
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        long oralCount = [ud integerForKey:WKEY_ORAL_COUNT];
        oralCount = oralCount + 1;
        [ud setInteger:oralCount forKey:WKEY_ORAL_COUNT];
    }
}
@end
