//
//  ServiceServerController.m
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import "ServiceServerController.h"
#import <GD/GDServices.h>

static __weak ServiceServerController* instance;

@interface ServiceServerController ()

@property (strong, nonatomic) GDService* server;

@end

@implementation ServiceServerController

-(id)init
{
    NSAssert(instance==nil, @"only one ServiceServerController instance could be instantiated");

    self = [super init];
    if (self!=nil)
    {
        self.server = [GDService new];

        _server.delegate = self;
    }

    instance = self;

    return self;
}

+(ServiceServerController*)sharedInstance
{
    NSAssert(instance!=nil, @"no ServiceServerController instance yet");

    return instance;
}

-(void)updateServices
{
    //nothing yet
}

#pragma mark - Good Dynamics Service Delegate (GDServiceDelegate)
-(void)GDServiceDidReceiveFrom:(NSString*)application forService:(NSString*)service withVersion:(NSString*)version forMethod:(NSString*)method withParams:(id)parameters withAttachments:(NSArray*)attachments forRequestID:(NSString*)requestID
{
    #pragma unused(application)
    #pragma unused(service)
    #pragma unused(version)
    #pragma unused(method)
    #pragma unused(parameters)
    #pragma unused(attachments)
    #pragma unused(requestID)
}

-(void)GDServiceDidFinishSendingTo:(NSString*)application withAttachments:(NSArray*)attachments withParams:(id)parameters correspondingToRequestID:(NSString*)requestID
{
    #pragma unused(application)
    #pragma unused(attachments)
    #pragma unused(parameters)
    #pragma unused(requestID)
}

@end
