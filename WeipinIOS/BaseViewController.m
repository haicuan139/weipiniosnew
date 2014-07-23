//
//  BaseViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-6-26.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "BaseViewController.h"
#import "MyTableViewCell.h"
#import "MJAppDelegate.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }

    return self;
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    array = [self initArray];
    [array retain];
    UIBarButtonItem *left = [self getLeftItem];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL noIsFirst = [ud boolForKey:WKEY_FIRST_RUN_KEY];
    BOOL isCheck = [ud boolForKey:WKEY_CHECK_STATE_BOOL];
    BOOL isSaveUserInfo = [ud boolForKey:WKEY_SAVE_USERINFO];
    if (!noIsFirst || !isCheck) {
        //开启验证
        [ud setBool:YES forKey:WKEY_FIRST_RUN_KEY];
        [self pushViewControllerWithStorboardName:@"reg" sid:@"regController"];
    }
    else if(!isSaveUserInfo){
        
        [self pushViewControllerWithStorboardName:@"myinfos" sid:@"myinfos"];
    }
    //初始化TabView
    tableView = [[UITableView alloc ] init];
    tableView.separatorStyle = NO;
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    tableView.delegate = self;
    tableView.dataSource = self;
    if (refreshTableHeaderView == nil) {
        EGORefreshTableHeaderView* view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0, 0.0 - tableView.frame.size.height, tableView.frame.size.width, tableView.frame.size.height)];
        view.delegate = self;
        refreshTableHeaderView = view;
        [tableView addSubview:view];
        [view release];
        [self sendRequest];
    }
    
    [self.view addSubview:tableView];
    
        
}

- (void)reloadData{
    [tableView reloadData];
}
-(NSArray *)initArray
{
  return   [NSArray arrayWithObjects:@"cell", nil];
}
-(void)doneLoadingTableViewData
{
    _reloading = NO;
    [refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
}
-(void)reloadTableViewDataSource
{
    _reloading = YES;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
-(void) egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    NSLog(@"egoRefreshTableHeaderDidTriggerRefresh");
    [self reloadTableViewDataSource];
//    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:10.0];
    //耗时操作
    [self refreshDoInBackground];
}
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    NSLog(@"egoRefreshTableHeaderDataSourceLastUpdated");
    return [NSDate date];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableViewT cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = [indexPath row];
    
    return [self initCellView:index];
    
}
-(UITableViewCell *)initCellView:(NSUInteger)index
{
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
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self sendRequest];
//}
-(void)onItemClick:(NSInteger)index
{
    MJAppDelegate *appDelegate = (MJAppDelegate *)[[UIApplication sharedApplication] delegate];
    OralsInfoBean *oralInfo = [array objectAtIndex:index];
    appDelegate.oralInfos = oralInfo;
    [self pushViewControllerWithStorboardName:@"detail" sid:@"detail"];
}
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSUInteger index = [indexPath row];
    [self onItemClick:index];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    tableView = nil;
    array = nil;
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [super dealloc];
    [array release];
    [tableView release];
//    [refreshTableHeaderView release];
//    [url release];
}



- (void)requestFinished:(ASIHTTPRequest *)request{
    [super requestFinished:request];
    NSString *res = [request responseString];
    NSArray *arr = [self toArrayOrNSDictionary:res];
    NSMutableArray *oralArray = [[NSMutableArray alloc] init];
    NSLog(@"%@",res);
    if (arr == nil) {
        NSLog(@"解析失败");
    }else{
        for (int i=0; i < arr.count; i++) {
            NSDictionary* dic = [arr objectAtIndex:i];
            OralsInfoBean *b = [self dicToOralInfo:dic];
            NSString *t = self.title;
            if ([t isEqualToString:WSTRING_ZHIWEI] && [b.cellOralRst isEqualToString:@"0"]) {
                [oralArray addObject:b];
            }else if([t isEqualToString:WSTRING_ORAL] && [b.cellOralRst isEqualToString:@"1"]){
                [oralArray addObject:b];
            }else if([t isEqualToString:WSTRING_LUYONG] && [b.cellOralRst isEqualToString:@"2"]){
                [oralArray addObject:b];
            }
        }
        array = oralArray;
    }
    [self reloadData];
    [self doneLoadingTableViewData];
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    [super requestFailed:request];
    [self doneLoadingTableViewData];
}
- (void)refreshDoInBackground{
    [self sendRequest];

}

@end
