//
//  MianshiTableViewCell.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-14.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MianshiTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIButton *cellOralNumberButton;//条目编号

@property (retain, nonatomic) IBOutlet UIButton *cellOralCompanyName;//公司名称

@property (retain, nonatomic) IBOutlet UILabel *cellOralNumberLable;//面试编号

@property (retain, nonatomic) IBOutlet UILabel *cellOralAddressLable;//面试地址

@property (retain, nonatomic) IBOutlet UILabel *cellOralTime;//创建时间

@property (retain, nonatomic) IBOutlet UIButton *cellOralState;//面试状态

@property (retain, nonatomic) IBOutlet UILabel *cellOralTel;//联系电话

@property (retain, nonatomic) IBOutlet UILabel *cellOralContacts;//联系人
@end
