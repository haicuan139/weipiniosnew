//
//  TextOralDetailViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-14.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "TextOralDetailViewController.h"
#import "HaoYouViewController.h"
@interface TextOralDetailViewController ()

@end

@implementation TextOralDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MJAppDelegate *appDelegate = (MJAppDelegate *)[[UIApplication sharedApplication] delegate];
    OralsInfoBean *oralInfo = appDelegate.oralInfos;
    MyInfosBean *info = [self getUserInfo];
    //通过面试
    self.title = @"详细";
    NSString *t = @"尊敬的";
    t = [t stringByAppendingString:info.name];
    t =[t stringByAppendingString:@":\n"];
    if ([oralInfo.cellOralRst isEqualToString:@"4"]) {
        //未通过
        t = [t stringByAppendingString:@"我们很遗憾的通知您,您没有通过"];
        t = [t stringByAppendingString:oralInfo.cellNCompanyName];
        t = [t stringByAppendingString:@"公司"];
        t = [t stringByAppendingString:oralInfo.cellJob];
        t = [t stringByAppendingString:@"职位的面试。\n"];
        t = [t stringByAppendingString:@"只需要您分享本信息，即可更多获得5次工作推荐机会，希望您再接再厉。"];
    }else if([oralInfo.cellOralRst isEqualToString:@"2"]){
        t = [t stringByAppendingString:@"您的入职时间已确认，请您携带本人身份证前往以下地址进行入职：\n"];
        t = [t stringByAppendingString:@"公司名称:"];
        t = [t stringByAppendingString:oralInfo.cellNCompanyName];
        t = [t stringByAppendingString:@"\n月薪:"];
        t = [[t stringByAppendingString:oralInfo.cellSalary]stringByAppendingString:@"元/月(税前)"];
        t = [t stringByAppendingString:@"\n入职时间:"];
        t = [t stringByAppendingString:oralInfo.cellOfferTime];
        t = [t stringByAppendingString:@"\n入职地址:"];
        t = [t stringByAppendingString:oralInfo.cellAddress];
        t = [t stringByAppendingString:@"\n联系人:"];
        t = [t stringByAppendingString:oralInfo.cellOralContacts];
        t = [t stringByAppendingString:@"\n联系电话:"];
        t = [t stringByAppendingString:oralInfo.cellOralTel];
        t = [t stringByAppendingString:@"\n分享您的成功经历，您将有机会双喜临门，抽取APPLE IPHONE6大奖（预约）"];
    }else{
//        t = [t stringByAppendingString:@"我们很高兴的通知您，您已通过：\n"];
//        t = [t stringByAppendingString:oralInfo.cellNCompanyName];
//        t = [t stringByAppendingString:@"公司"];
//        t = [t stringByAppendingString:oralInfo.cellJob];
//        t = [t stringByAppendingString:@"职位"];
//        t = [t stringByAppendingString:@"税前月薪"];
//        t = [t stringByAppendingString:oralInfo.cellSalary];
//        t = [t stringByAppendingString:@"元的面试,请您保持手机通信畅通，我们会在48小时内与您联系并确认入职时间。\n长按本信息分享您的喜悦，让更多好友找工作只需要动动手。"];
        t = [t stringByAppendingString:@"我们已确认您的面试时间，请您参见以下内容并牢记面试编号：\n"];
        t = [t stringByAppendingString:@"公司名称:"];
        t = [t stringByAppendingString:oralInfo.cellNCompanyName];
        t = [t stringByAppendingString:@"\n面试地点:"];
        t = [t stringByAppendingString:oralInfo.cellOralAddress];
        t = [t stringByAppendingString:@"\n面试时间:"];
        t = [t stringByAppendingString:oralInfo.cellOralTime];
        t = [t stringByAppendingString:@"\n联系人:"];
        t = [t stringByAppendingString:oralInfo.cellOralContacts];
        t = [t stringByAppendingString:@"\n联系电话:"];
        t = [t stringByAppendingString:oralInfo.cellOralTel];
        t = [t stringByAppendingString:@"\n请您携带个人身份证件，学历和技能证书（复印件）前往，如面试时间冲突，请致电调整。\n长按本信息分享您的喜悦，让更多好友找工作只需要动动手。"];
        
        
    }
    _contentTextView.text = t;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

- (void)dealloc {
    [_contentTextView release];
    [super dealloc];
}
@end
