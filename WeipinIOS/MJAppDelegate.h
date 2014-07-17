//
//  MJAppDelegate.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-24.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OralsInfoBean.h"
#import "BPush.h"
@interface MJAppDelegate : UIResponder <UIApplicationDelegate , BPushDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (retain , nonatomic) OralsInfoBean *oralInfos;

@end
