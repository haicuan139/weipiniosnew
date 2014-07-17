//
//  MianshiTableViewCell.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-14.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MianshiTableViewCell.h"

@implementation MianshiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    [super dealloc];
    [_cellOralNumberButton release];//条目编号
    
    [_cellOralCompanyName release];//公司名称
    
    [_cellOralNumberLable release];//面试编号
    
    [_cellOralAddressLable release];//面试地址
    
    [_cellOralTime release];//创建时间
    
    [_cellOralState release];//面试状态
    
    [_cellOralTel release];//联系电话
    
    [_cellOralContacts release];//联系人
}

@end
