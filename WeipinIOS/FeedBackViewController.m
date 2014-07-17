//
//  FeedBackViewController.m
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-1.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch");
    [self.feedbackTextView resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.feedbackTextView resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"建议反馈";
    _feedbackTextView.delegate = self;
    
    // Do any additional setup after loading the view.
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
- (void)requestFinished:(ASIHTTPRequest *)request{
    [super requestFinished:request];
    [self showMessageDialog:@"提交完成,谢谢您的建议"];
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    [super requestFailed:request];
}
- (void)dealloc {
    [_commitButton release];
    [_feedbackTextView release];
    [super dealloc];
}
- (IBAction)onClick:(id)sender {
    NSString *feedBackText = _feedbackTextView.text;
    if (![self isEmpty:feedBackText]) {
        [self sendFeedBackRequest:feedBackText];
    }else {
        [self showMessageDialog:@"请输入内容!"];
    }
}
@end
