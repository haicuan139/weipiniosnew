//
//  GodBaseViewController.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "URLHeader.h"
#import "ConfigKey.h"
#import "MyInfosBean.h"
#import "EGORefreshTableHeaderView.h"
#import "URLHeader.h"
#import "ConfigKey.h"
#import "OralsInfoBean.h"
#import "StringHeader.h"
#import "MyTableViewCell.h"
#import "MianshiTableViewCell.h"
#import "MJAppDelegate.h"
@interface GodBaseViewController : UIViewController <ASIHTTPRequestDelegate>
-(void)showMessageDialog:(NSString* )msg;
-(ASIHTTPRequest *) getNormalHttpRequest :(NSString *) url;
-(ASIFormDataRequest *) getPostHttpRequest : (NSString *)url;
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id;
-(void)pushViewControllerWithController:(UIViewController *)controller;
-(NSString *) getPhoneNumber;
-(NSDictionary *)getDicByNSString:(NSString *) string;
-(MyInfosBean *)getUserInfo;
-(BOOL)isEmpty:(NSString *)string;
-(void)sendRequest:(NSString *)url;
-(void)sendRequest;
-(void)sendTouDiRequest:(NSString *)oralId;
-(id)toArrayOrNSDictionary:(NSString *)json;
-(OralsInfoBean *)dicToOralInfo:(NSDictionary *)dic;
-(NSString *)getUserId;
-(void)sendFeedBackRequest:(NSString *)content;
-(UIBarButtonItem *)getLeftItem;
-(UIBarButtonItem *)getRightItem;
-(void)onRightBarItemClick;
-(void)onLeftBarItemClick;
@end
