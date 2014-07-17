//
//  MyTabCellTableViewCell.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *cellNumberButton;//条目编号

@property (retain, nonatomic) IBOutlet UIButton *cellCompanyName;//公司名称

@property (retain, nonatomic) IBOutlet UILabel *cellSalaryLable;//薪酬

@property (retain, nonatomic) IBOutlet UILabel *cellJobLable;//工作类型

@property (retain, nonatomic) IBOutlet UILabel *cellAddressLable;//公司地址

@property (retain, nonatomic) IBOutlet UILabel *cellTime;//创建时间

@property (retain, nonatomic) IBOutlet UILabel *cellWorkTypeLable;//工作类型
@end
