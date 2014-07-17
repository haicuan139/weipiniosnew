//
//  ContentTextView.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-14.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "ContentTextView.h"
#import "HaoYouViewController.h"
#import "TextOralDetailViewController.h"
@implementation ContentTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            TextOralDetailViewController * cvc = (TextOralDetailViewController *)nextResponder;
            HaoYouViewController *h = [[HaoYouViewController alloc]initWithNibName:nil bundle:nil];
            [h retain];
            [cvc.navigationController pushViewController:h animated:YES];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
