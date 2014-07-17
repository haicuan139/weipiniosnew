//
//  MyUITabBarController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-7.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MyUITabBarController.h"

@implementation MyUITabBarController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBar.hidden = YES;
    }
    
    return self;
}

- (void)viewDidLoad{
       [super viewDidLoad];
    
//    CGRect frame = CGRectMake(0, 0, 320, 49);
//    
//    UIView *v = [[UIView alloc] initWithFrame:frame];
//    
//    UIImage *img = [UIImage imageNamed:@"tabbg.png"];
//    
//    UIColor *color = [[UIColor alloc] initWithPatternImage:img];
//    
//    v.backgroundColor = color;
//    
//    [self.tabBar insertSubview:v atIndex:0];
//    
//    self.tabBar.opaque = YES;
//    
//    [color release];
//    
//    [v release];
//
//    [self.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
//    CGRect frame = CGRectMake(0, 519, 320, 49);
//    UIView *bottom = [[UIView alloc] init];
//    bottom.userInteractionEnabled = YES;
//    bottom.backgroundColor = [UIColor redColor];
//    bottom.frame = frame;
//    [self.view addSubview:bottom];
//    [bottom release];
//    int x = 0;
//    for (int index = 0; index < 4; index++) {
//        UIButton * button = [[UIButton alloc ]init];
//        button.tag = index;
//        CGRect rect = CGRectMake(x, 0, 80, 49);
//        button.frame = rect;
//        button.backgroundColor = [UIColor blueColor];
//        [button addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
////        [button setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>]
//        [bottom addSubview:button];
//        x = x + 80;
//    }
}
-(void)tabClick:(UIButton *)button{
    self.selectedIndex = button.tag;
}
@end
