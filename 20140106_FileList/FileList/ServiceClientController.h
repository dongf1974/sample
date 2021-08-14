//
//  ServiceClientController.h
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GD/GDServices.h>

@protocol ServiceClientControllerDelegate

@optional
-(void)request:(NSString*)requestID returnError:(NSError*)error from:(NSString*)application;
-(void)request:(NSString*)requestID returnWithParams:(id)parameters withAttachments:(NSArray*)attachments from:(NSString*)application;

@end

@interface ServiceClientController:
    NSObject<
    GDServiceClientDelegate>
{
}

+(ServiceClientController*)sharedInstance;
-(void)updateServices;
-(void)setDelegate:(id<ServiceClientControllerDelegate>)delegate forRequest:(NSString*)requestID;

@end
