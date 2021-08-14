//
//  main.m
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GD/GDiOS.h>
#import "AppDelegate.h"

int main(int argc, char* argv[])
{
    @autoreleasepool
    {
        [GDiOS initialiseWithClassNameConformingToUIApplicationDelegate:@"AppDelegate"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
