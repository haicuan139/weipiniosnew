//
//  ZhiWeiViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-24.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "ZhiWeiViewController.h"
#import "RegViewController.h"
@interface ZhiWeiViewController ()

@end

@implementation ZhiWeiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UITableViewCell *)initCellView:(NSUInteger)index{
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *marray = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [marray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OralsInfoBean* b = [array objectAtIndex:index];
    if (b != nil) {
        NSString* addrStr = @"地址:";
        cell.cellAddressLable.text = [addrStr stringByAppendingString:b.cellAddress];
        [cell.cellCompanyName setTitle:b.cellNCompanyName forState:UIControlStateNormal];
        NSString* jobStr = @"职位:";
        cell.cellJobLable.text = [jobStr stringByAppendingString:b.cellJob];
        cell.cellTime.text = b.cellTime;
        NSString* salaryStr = @"薪酬:";
        cell.cellSalaryLable.text = [[salaryStr stringByAppendingString:b.cellSalary]stringByAppendingString:@"/月(税前)"];
        cell.cellWorkTypeLable.text = b.cellOralWorkType;
    }
    index = index + 1;
    [cell.cellNumberButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)index] forState:UIControlStateNormal];
    return cell;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = WSTRING_ZHIWEI;


}
-(NSArray *)initArray
{
    return [[NSArray alloc] init];
}
@end
