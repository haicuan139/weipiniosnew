//
//  MoreViewController.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-1.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>
{
    NSArray *moreArray;
    NSArray *controllerArray;
}
@property (retain, nonatomic) IBOutlet UITableView *moreTableView;

@end
