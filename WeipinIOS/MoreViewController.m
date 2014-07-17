//
//  MoreViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-1.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "FeedBackViewController.h"
#import "MyInfoViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moreArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIViewController* uvc = [controllerArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:uvc animated:true];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(tabCell == nil){
        tabCell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CellIdentifier autorelease]];
    }
    NSString* str = [moreArray objectAtIndex:indexPath.row];
    tabCell.textLabel.text = str;
    
    return tabCell;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多";
    _moreTableView.delegate = self;
    _moreTableView.dataSource = self;
    UIStoryboard* myinfoSd = [UIStoryboard storyboardWithName:@"myinfos" bundle:nil];
    UIViewController *myinfo = [myinfoSd instantiateViewControllerWithIdentifier:@"myinfos"];
    UIStoryboard* aboutSd = [UIStoryboard storyboardWithName:@"about" bundle:nil];
    UIViewController *about = [aboutSd instantiateViewControllerWithIdentifier:@"about"];
    UIStoryboard* feedbackSd = [UIStoryboard storyboardWithName:@"feedback" bundle:nil];
    UIViewController *feedback = [feedbackSd instantiateViewControllerWithIdentifier:@"feedback"];
    
    controllerArray = [NSArray arrayWithObjects:myinfo,feedback,about, nil];
    [controllerArray retain];
    moreArray = [NSArray arrayWithObjects:@"我的资料",@"建议反馈",@"关于" , nil];
    
    [moreArray retain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_moreTableView release];
    [moreArray release];
    [controllerArray release];
    [super dealloc];
}
@end
