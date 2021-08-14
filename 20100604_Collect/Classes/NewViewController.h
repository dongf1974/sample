/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              NewViewController.h

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

#import <UIKit/UIKit.h>

@class Task;

@interface NewViewController: UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
{
    UITextField* userNameTextField;
    UITextField* ageTextField;
    UITextField* genderTextField;
    UITextField* educationTextField;
    UITextField* professionTextField;
    UITextField* deviceTextField;
    Task* task;
}
@property (nonatomic, retain) IBOutlet UITextField* userNameTextField;
@property (nonatomic, retain) IBOutlet UITextField* ageTextField;
@property (nonatomic, retain) IBOutlet UITextField* genderTextField;
@property (nonatomic, retain) IBOutlet UITextField* educationTextField;
@property (nonatomic, retain) IBOutlet UITextField* professionTextField;
@property (nonatomic, retain) IBOutlet UITextField* deviceTextField;
@property (nonatomic, retain) Task* task;
-(IBAction)ok:(id)sender;
-(IBAction)cancel:(id)sender;
@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of NewViewController.h

\*_________________________________________________________*/
