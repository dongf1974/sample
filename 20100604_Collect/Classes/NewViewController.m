/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              NewViewController.m

    Comment:                Collect new view controller

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

#import "NewViewController.h"
#import "Task.h"
#include <dal.h>

@implementation NewViewController

@synthesize userNameTextField;
@synthesize ageTextField;
@synthesize genderTextField;
@synthesize educationTextField;
@synthesize professionTextField;
@synthesize deviceTextField;
@synthesize task;

-(void)dealloc
{
    [userNameTextField release];
    [ageTextField release];
    [genderTextField release];
    [educationTextField release];
    [professionTextField release];
    [deviceTextField release];
    [task release];
    [super dealloc];
}

-(void)viewDidUnload
{
    self.userNameTextField = nil;
    self.ageTextField = nil;
    self.genderTextField = nil;
    self.educationTextField = nil;
    self.professionTextField = nil;
    self.deviceTextField = nil;
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    userNameTextField.text = @"";
    ageTextField.text = @"";
    genderTextField.text = @"";
    educationTextField.text = @"";
    professionTextField.text = @"";
    deviceTextField.text = @"";
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
    [textField resignFirstResponder];
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
    NSString* age = ageTextField.text;
    NSString* gender = genderTextField.text;
    NSString* education = educationTextField.text;
    NSString* profession = professionTextField.text;
    NSString* device = deviceTextField.text;
    if( userName.length>0 )
    {
        TaskResult result = [task newTaskWithUserName:userName age:age gender:gender education:education profession:profession device:device];
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
                case taskExists:
                    message = @"文件已存在";
                    break;
                case taskIsFolder:
                    message = @"文件和目录同名";
                    break;
                case taskOpenFail:
                    message = @"创建文件失败";
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

    End of NewViewController.m

\*_________________________________________________________*/
