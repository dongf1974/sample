/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              main.m

    Comment:                Collect main

    Version:                1.0

    Build:                  1

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/09-2010/06/09 (1.0)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/

#import <UIKit/UIKit.h>

int main(int argument_count, char* arguments[])
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    int returnValue = UIApplicationMain(argument_count, arguments, nil, nil);
    [pool release];
    return returnValue;
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of main.m

\*_________________________________________________________*/
