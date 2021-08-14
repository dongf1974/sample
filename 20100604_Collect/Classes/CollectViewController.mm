/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              CollectViewController.mm

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

#import "CollectViewController.h"
#include <dal.h>
#include <simple_vector.hpp>
#include "stroke.hpp"
#import "DFDrawView.h"
#import "NewViewController.h"
#import "OpenViewController.h"
#import "Phrases.h"
#import "Task.h"
#import "about.h"

using namespace draw;

@interface CollectViewController ()
-(void)onTaskBegin;
-(void)onTaskEnd;
-(void)onTaskFinished;
-(void)onPhrasekBegin;
@end

@implementation CollectViewController

@synthesize newButton;
@synthesize openButton;
@synthesize exitButton;
@synthesize rewriteButton;
@synthesize nextButton;
@synthesize totalPhraseLabel;
@synthesize finishedPhraseLabel;
@synthesize userNameLabel;
@synthesize phraseLabel;
@synthesize newViewController;
@synthesize openViewController;
@synthesize drawView;

-(void)dealloc
{
    [newButton release];
    [openButton release];
    [exitButton release];
    [rewriteButton release];
    [nextButton release];
    [totalPhraseLabel release];
    [finishedPhraseLabel release];
    [userNameLabel release];
    [phraseLabel release];
    [newViewController release];
    [openViewController release];
    [drawView release];
    [phrases release];
    [task release];
    if( dots!=(void*)NULL )
    {
        delete (stroke*)dots;
    }
    [super dealloc];
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    ASSERT( phrases==nil );
    NSString* home = NSHomeDirectory();
    NSString* phraseFileName = [NSString stringWithFormat:@"%@/Collect.app/phrase.txt", home];
    phrases = [[Phrases alloc] initWithFile:phraseFileName];
    ASSERT( task==nil );
    task = [[Task alloc] init];
    ASSERT( dots==(void*)NULL );
    dots = new stroke;
    ((stroke*)dots)->reserve(1000);

    NSString* phrase = [NSString stringWithFormat:@"%lu", phrases.count];
    totalPhraseLabel.text = phrase;
    drawView.dots = (stroke*)dots;
    [self onTaskEnd];
}

-(void)viewDidUnload
{
    self.newButton = nil;
    self.openButton = nil;
    self.exitButton = nil;
    self.rewriteButton = nil;
    self.nextButton = nil;
    self.totalPhraseLabel = nil;
    self.finishedPhraseLabel = nil;
    self.userNameLabel = nil;
    self.phraseLabel = nil;
    self.drawView.dots = (stroke*)NULL;
    self.drawView = nil;
    [phrases release];
    phrases = nil;
    [task release];
    task = nil;
    if( dots!=(void*)NULL )
    {
        delete (stroke*)dots;
        dots = (void*)NULL;
    }
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if( task.open )
    {
        [self onTaskBegin];
    }
    else
    {
        [self onTaskEnd];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [drawView setNeedsDisplay];
    return YES;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)newTask:(id)sender
{
    newViewController.task = task;
    [self presentModalViewController:newViewController animated:YES];
}

-(IBAction)openTask:(id)sender
{
    openViewController.task = task;
    [self presentModalViewController:openViewController animated:YES];
}

-(IBAction)exitTask:(id)sender
{
    if( task.open )
    {
        [task closeTask];
    }
    ASSERT( !task.open );
    [self onTaskEnd];
}

-(IBAction)nextPhrase:(id)sender
{
    NSString* phrase = phraseLabel.text;
    [task addPhrase:phrase withStroke:dots];
    [drawView clear];
    [self onPhrasekBegin];
}

-(IBAction)rewritePhrase:(id)sender
{
    [drawView clear];
    [self onPhrasekBegin];
}

-(void)onTaskBegin
{
    newButton.enabled = NO;
    openButton.enabled = NO;
    exitButton.enabled = YES;
    NSString* userName = [task user];
    userNameLabel.text = userName;
    [self onPhrasekBegin];
}

-(void)onTaskEnd
{
    newButton.enabled = YES;
    openButton.enabled = YES;
    exitButton.enabled = NO;
    rewriteButton.enabled = NO;
    nextButton.enabled = NO;
    finishedPhraseLabel.text = @"";
    userNameLabel.text = @"";
    phraseLabel.text = @"";
    drawView.enabled = NO;
    [drawView clear];
}

-(void)onTaskFinished
{
    phraseLabel.text = @"已完成";
    drawView.enabled = NO;
    [drawView clear];
}

-(void)onPhrasekBegin
{
    rewriteButton.enabled = NO;
    nextButton.enabled = NO;
    size_t finishedPhraseCount = [task count];
    NSString* finishedPhrase = [NSString stringWithFormat:@"%lu", finishedPhraseCount];
    finishedPhraseLabel.text = finishedPhrase;
    size_t count = phrases.count;
    if( finishedPhraseCount<count )
    {
        NSString* phrase = [phrases phrase:finishedPhraseCount];
        phraseLabel.text = phrase;
        drawView.enabled = YES;
        [drawView clear];
    }
    else
    {
        [self onTaskFinished];
    }
}

-(void)drawViewBeganTouch:(DFDrawView*)drawView
{
    rewriteButton.enabled = YES;
    nextButton.enabled = YES;
}

-(IBAction)about:(id)sender
{
    NSString* copyRight = APPLICATION_COPY_RIGHT;
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:copyRight delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of CollectViewController.mm

\*_________________________________________________________*/
