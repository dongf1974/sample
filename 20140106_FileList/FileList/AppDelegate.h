//
//  AppDelegate.h
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GD/GDiOS.h>

@interface AppDelegate:
    UIResponder<
    UIApplicationDelegate,
    GDiOSDelegate>
{
    BOOL started;
}

@property (strong, nonatomic) UIWindow* window;
@property (strong, nonatomic) GDiOS* good;

@end
