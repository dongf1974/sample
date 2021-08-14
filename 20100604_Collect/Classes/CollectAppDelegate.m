/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              CollectAppDelegate.m

    Comment:                Collect application delegate

    Version:                1.0

    Build:                  2

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/09-2010/06/11 (1.0)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/

#import "CollectAppDelegate.h"
#import "CollectViewController.h"
#include <dal.h>

@implementation CollectAppDelegate

@synthesize window;
@synthesize viewController;

-(void)dealloc
{
    [viewController release];
    [window release];
    [super dealloc];
}

-(BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    DEBUG_MESSAGE(TRUE, ("Collect launch\n"));
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    return YES;
}

-(void)applicationWillTerminate:(UIApplication*)application
{
    [viewController exitTask:nil];
    DEBUG_MESSAGE(TRUE, ("Collect exit\n"));
}

@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of CollectAppDelegate.m

\*_________________________________________________________*/
