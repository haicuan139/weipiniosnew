//
//  HaoYouViewController.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-24.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PBaseViewController.h"
#import "UMSocial.h"
#import "WXApi.h"
@interface HaoYouViewController : PBaseViewController <WXApiDelegate , UMSocialUIDelegate>
{
    
}
-(void)onClick;
@end
