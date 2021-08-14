//
//  ServiceClientController.m
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import "ServiceClientController.h"
#import <GD/GDServices.h>
#import "WeakReference.h"

static __weak ServiceClientController* instance;

@interface ServiceClientController ()

-(void)removeDelegateForRequest:(NSString*)requestID;
-(id<ServiceClientControllerDelegate>)findDelegateForRequest:(NSString*)requestID;

@property (strong, nonatomic) GDServiceClient* client;
@property (strong, nonatomic) NSMutableDictionary* delegates;

@end

@implementation ServiceClientController

-(id)init
{
    NSAssert(instance==nil, @"only one ServiceClientController instance could be instantiated");

    self = [super init];
    if (self!=nil)
    {
        self.client = [GDServiceClient new];
        self.delegates = [NSMutableDictionary new];

        _client.delegate = self;
    }

    instance = self;

    return self;
}

+(ServiceClientController*)sharedInstance
{
    NSAssert(instance!=nil, @"no ServiceClientController instance yet");

    return instance;
}

-(void)updateServices
{
    //nothing yet
}

-(void)setDelegate:(id<ServiceClientControllerDelegate>)delegate forRequest:(NSString*)requestID
{
    NSAssert(delegate!=nil, @"nil delegate");
    NSAssert(requestID!=nil, @"nil request ID");
    NSAssert(requestID.length>0, @"empty request ID");

    WeakReference* weakDelegate = [WeakReference new];
    weakDelegate.object = delegate;
    [_delegates setValue:weakDelegate forKey:requestID];
}

-(void)removeDelegateForRequest:(NSString*)requestID
{
    NSAssert(requestID!=nil, @"nil request ID");
    NSAssert(requestID.length>0, @"empty request ID");

    [_delegates removeObjectForKey:requestID];
}

-(id<ServiceClientControllerDelegate>)findDelegateForRequest:(NSString*)requestID
{
    NSAssert(requestID!=nil, @"nil request ID");
    NSAssert(requestID.length>0, @"empty request ID");

    WeakReference* weakDelegate = _delegates[requestID];

    if (weakDelegate!=nil && weakDelegate.object==nil)
    {
        [_delegates removeObjectForKey:requestID];
    }

    return weakDelegate.object;
}

#pragma mark - Good Dynamics Service Client Delegate (GDServiceClientDelegate)

-(void)GDServiceClientDidReceiveFrom:(NSString*)application withParams:(id)parameters withAttachments:(NSArray*)attachments correspondingToRequestID:(NSString*)requestID
{
    id<ServiceClientControllerDelegate> delegate = [self findDelegateForRequest:requestID];

    if (parameters!=nil && [parameters isKindOfClass:[NSError class]])
    {
        NSError* error = parameters;

        if (delegate!=nil)
        {
            [delegate request:requestID returnError:error from:application];
        }
        else
        {
            NSLog(@"Error: call service return error, %@ (%d), %@", error.domain, (int)error.code, error.localizedDescription);
        }
    }
    else
    {
        [delegate request:requestID returnWithParams:parameters withAttachments:attachments from:application];
    }

    [self removeDelegateForRequest:requestID];
}

/*
-(void)GDServiceClientDidFinishSendingTo:(NSString*)application withAttachments:(NSArray*)attachments withParams:(id)parameters correspondingToRequestID:(NSString*)requestID
{
    //optional
    //currently, called before [GDServiceClient sendTo...] return
    #pragma unused(application)
    #pragma unused(attachments)
    #pragma unused(parameters)
    #pragma unused(requestID)
}
*/

@end
