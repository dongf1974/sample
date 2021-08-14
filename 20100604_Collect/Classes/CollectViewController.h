/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              CollectViewController.h

    Comment:                Collect view controller

    Version:                1.0

    Build:                  6

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/09-2010/06/13 (1.0)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/

#import <UIKit/UIKit.h>
#import "DFDrawViewDelegate.h"

@class DFDrawView;
@class NewViewController;
@class OpenViewController;
@class Phrases;
@class Task;

@interface CollectViewController: UIViewController <DFDrawViewDelegate>
{
    UIButton* newButton;
    UIButton* openButton;
    UIButton* exitButton;
    UIButton* rewriteButton;
    UIButton* nextButton;
    UILabel* totalPhraseLabel;
    UILabel* finishedPhraseLabel;
    UILabel* userNameLabel;
    UILabel* phraseLabel;
    DFDrawView* drawView;
    NewViewController* newViewController;
    OpenViewController* openViewController;
    Phrases* phrases;
    Task* task;
    void* dots;
}
@property (nonatomic, retain) IBOutlet UIButton* newButton;
@property (nonatomic, retain) IBOutlet UIButton* openButton;
@property (nonatomic, retain) IBOutlet UIButton* exitButton;
@property (nonatomic, retain) IBOutlet UIButton* rewriteButton;
@property (nonatomic, retain) IBOutlet UIButton* nextButton;
@property (nonatomic, retain) IBOutlet UILabel* totalPhraseLabel;
@property (nonatomic, retain) IBOutlet UILabel* finishedPhraseLabel;
@property (nonatomic, retain) IBOutlet UILabel* userNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* phraseLabel;
@property (nonatomic, retain) IBOutlet DFDrawView* drawView;
@property (nonatomic, retain) IBOutlet NewViewController* newViewController;
@property (nonatomic, retain) IBOutlet OpenViewController* openViewController;
-(IBAction)newTask:(id)sender;
-(IBAction)openTask:(id)sender;
-(IBAction)exitTask:(id)sender;
-(IBAction)nextPhrase:(id)sender;
-(IBAction)rewritePhrase:(id)sender;
-(IBAction)about:(id)sender;
@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of CollectViewController.h

\*_________________________________________________________*/
