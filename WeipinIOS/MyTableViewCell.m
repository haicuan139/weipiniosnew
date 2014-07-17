//
//  MyTabCellTableViewCell.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

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
    
-(void)dealloc{
    
    [_cellNumberButton release];
    
    [_cellCompanyName release];
    
    [_cellSalaryLable release];
    
    [_cellJobLable release];
    
    [_cellAddressLable release];
    
    [_cellTime release];
    
    [_cellWorkTypeLable release];
    
    [super dealloc];
    
}
@end
