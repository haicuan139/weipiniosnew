//
//  LuYongViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-24.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "LuYongViewController.h"
#import "LuYongTableViewCell.h"
@interface LuYongViewController ()

@end

@implementation LuYongViewController

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
	// Do any additional setup after loading the view.
        self.title = WSTRING_LUYONG;
}

- (UITableViewCell *)initCellView:(NSUInteger)index{
    static NSString *CellIdentifier = @"LuyongCustomCell";
    LuYongTableViewCell *cell = (LuYongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *marray = [[NSBundle mainBundle] loadNibNamed:@"LuyongCustomCell" owner:self options:nil];
        cell = [marray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OralsInfoBean* b = [array objectAtIndex:index];
    if (b != nil) {
        [cell.cellCompanyName setTitle:b.cellNCompanyName forState:UIControlStateNormal];
        NSString* jobStr = @"职位:";
        cell.cellJobLable.text = [jobStr stringByAppendingString:b.cellJob];
        cell.cellTime.text = b.cellTime;
        NSString* salaryStr = @"薪酬:";
        cell.cellSalaryLable.text = [[salaryStr stringByAppendingString:b.cellSalary]stringByAppendingString:@"/月(税前)"];
        cell.cellWorkTypeLable.text = b.cellOralWorkType;//工作性质
    }
    index = index + 1;
    [cell.cellNumberButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)index] forState:UIControlStateNormal];
    if ([b.cellOralRst isEqualToString:@"3"]) {
        //未通过
        [cell.cellWorkState setTitle:@"已经入职" forState:UIControlStateNormal];
    }
    return cell;
   
}
- (void)onItemClick:(NSInteger)index{
    MJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    OralsInfoBean *oralInfo = [array objectAtIndex:index];
    appDelegate.oralInfos = oralInfo;
    [self pushViewControllerWithStorboardName:@"textdetail" sid:@"textdetail"];
}
-(NSArray *)initArray
{
    return  [[NSArray alloc] init];
}

@end
