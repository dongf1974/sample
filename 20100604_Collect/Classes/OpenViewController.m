/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              OpenViewController.m

    Comment:                Collect open view controller

    Version:                1.0

    Build:                  2

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/10-2010/06/11 (1.0)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/

#import "OpenViewController.h"
#import "Task.h"
#include <dal.h>

@implementation OpenViewController

@synthesize userNameTextField;
@synthesize task;

-(void)dealloc
{
    [userNameTextField release];
    [task release];
    [super dealloc];
}

-(void)viewDidUnload
{
    self.userNameTextField = nil;
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    userNameTextField.text = @"";
    [userNameTextField becomeFirstResponder];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    ASSERT( textField==userNameTextField );
    [userNameTextField resignFirstResponder];
    [self ok:userNameTextField];
    return YES;
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ASSERT( buttonIndex==0 );
    [userNameTextField becomeFirstResponder];
}

-(IBAction)ok:(id)sender
{
    ASSERT( task!=nil );
    NSString* userName = userNameTextField.text;
    if( userName.length>0 )
    {
        TaskResult result = [task openTaskWithUserName:userName];
        if( result==taskOpend )
        {
            UIViewController* parent = [self parentViewController];
            [parent dismissModalViewControllerAnimated:YES];
        }
        else
        {
            NSString* message;
            switch( result )
            {
            case taskNotExists:
                message = @"文件不存在";
                break;
            case taskNotReadable:
                message = @"文件不可读";
                break;
            case taskNotWritable:
                message = @"文件不可写";
                break;
            case taskOpenFail:
                message = @"打开文件失败";
                break;
            }
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

-(IBAction)cancel:(id)sender
{
    UIViewController* parent = [self parentViewController];
    [parent dismissModalViewControllerAnimated:YES];
}

@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of OpenViewController.m

\*_________________________________________________________*/
