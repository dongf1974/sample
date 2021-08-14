//
//  AppDelegate.m
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import "AppDelegate.h"
#import "ServiceClientController.h"
#import "ServiceServerController.h"

@interface AppDelegate ()

-(void)onAuthorized:(GDAppEvent*)event;
-(void)onNotAuthorized:(GDAppEvent*)event;
-(void)onServiceUpdate:(GDAppEvent*)event;

@property (strong, nonatomic) ServiceClientController* client;
@property (strong, nonatomic) ServiceServerController* server;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

-(BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.window = [[GDiOS sharedInstance] getWindow];
    self.good = [GDiOS sharedInstance];

    _good.delegate = self;
    started = NO;

    [_good authorize];

    return YES;

    #pragma unused(application)
    #pragma unused(launchOptions)
}

#pragma mark - Good Dynamics Delegate (GDiOSDelegate)

-(void)handleEvent:(GDAppEvent*)event
{
    switch (event.type)
    {
    case GDAppEventAuthorized:
        [self onAuthorized:event];
        break;
    case GDAppEventNotAuthorized:
        [self onNotAuthorized:event];
        break;
    case GDAppEventRemoteSettingsUpdate:
        break;
    case GDAppEventServicesUpdate:
        [self onServiceUpdate:event];
        break;
    case GDAppEventPolicyUpdate:
        break;
    }
}

-(void)onAuthorized:(GDAppEvent*)event
{
    switch (event.code)
    {
    case GDErrorNone:
        if (!started)
        {
            started = YES;

            self.client = [ServiceClientController new];
            self.server = [ServiceServerController new];

            [_client updateServices];
            [_server updateServices];

            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            _window.rootViewController = [mainStoryboard instantiateInitialViewController];
        }
        break;
    default:
        NSAssert(NO, @"Authorized startup with an error, (%d) %@", (int)event.code, event.message);
        break;
    }
}

-(void)onNotAuthorized:(GDAppEvent*)event
{
    switch (event.code)
    {
    case GDErrorActivationFailed:
    case GDErrorProvisioningFailed:
    case GDErrorPushConnectionTimeout:
        [_good authorize];
        break;
    case GDErrorSecurityError:
    case GDErrorAppDenied:
    case GDErrorBlocked:
    case GDErrorWiped:
    case GDErrorRemoteLockout:
    case GDErrorPasswordChangeRequired:
        NSLog(@"Not authorized, %@", event.message);
        break;
    case GDErrorIdleLockout:
        break;
    default:
        NSAssert(NO, @"Unhandled not authorized event, (%d) %@", (int)event.code, event.message);
        break;
    }
}

-(void)onServiceUpdate:(GDAppEvent*)event
{
    switch (event.code)
    {
    case GDErrorNone:
        NSAssert(started, @"Service update before authorized");
        [_client updateServices];
        [_server updateServices];
        break;
    default:
        NSAssert(NO, @"Service update with an error, (%d) %@", (int)event.code, event.message);
        break;
    }
}

@end
