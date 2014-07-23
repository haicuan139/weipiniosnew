//
//  MianShiViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-24.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MianShiViewController.h"

@interface MianShiViewController ()

@end

@implementation MianShiViewController

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
        self.title =    WSTRING_ORAL;
    NSLog(@"面试加载");
}
-(NSArray *)initArray
{
    return  [[NSArray alloc] init];
}
- (UITableViewCell *)initCellView:(NSUInteger)index{
    static NSString *CellIdentifier = @"MianshiCustomCellIdentifier";
        MianshiTableViewCell *cell = (MianshiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *marray = [[NSBundle mainBundle] loadNibNamed:@"CustomCellOral" owner:self options:nil];
        cell = [marray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OralsInfoBean* b = [array objectAtIndex:index];
    if (b != nil) {
        [cell.cellOralCompanyName setTitle:b.cellNCompanyName forState:UIControlStateNormal];
        NSString *mid = @"编号:";
        NSString *addr = @"面试地址:";
        NSString *time = @"面试时间:";
        NSString *lianxiren = @"联系人:";
        NSString *tel = @"联系电话:";
        cell.cellOralNumberLable.text = [mid stringByAppendingString:b.cellOralId];
        cell.cellOralAddressLable.text = [addr stringByAppendingString:b.cellOralAddress];
        cell.cellOralTime.text = [time stringByAppendingString:b.cellOralTime];
        cell.cellOralContacts.text = [lianxiren stringByAppendingString:b.cellOralContacts];
        cell.cellOralTel.text = [tel stringByAppendingString:b.cellOralTel];
        cell.cellCreateTime.text = b.cellCreateTime;
        if ([b.cellOralRst isEqualToString:@"4"]) {
            //未通过
            [cell.cellOralState setTitle:@"未通过" forState:UIControlStateNormal];
        }
    }
    index = index + 1;
    [cell.cellOralNumberButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)index] forState:UIControlStateNormal];
    return cell;
}
- (void)onItemClick:(NSInteger)index{
        MJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        OralsInfoBean *oralInfo = [array objectAtIndex:index];
        appDelegate.oralInfos = oralInfo;
        [self pushViewControllerWithStorboardName:@"textdetail" sid:@"textdetail"];
}
@end
