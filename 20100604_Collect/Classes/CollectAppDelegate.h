/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              CollectAppDelegate.h

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

#import <UIKit/UIKit.h>

@class CollectViewController;

@interface CollectAppDelegate: NSObject <UIApplicationDelegate>
{
    UIWindow* window;
    CollectViewController* viewController;
}
@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet CollectViewController* viewController;
@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of CollectAppDelegate.h

\*_________________________________________________________*/
