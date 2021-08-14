//
//  EditFileServiceProxy.m
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import "EditFileServiceProxy.h"
#import <GD/GDiOS.h>
#import <GD/GDServices.h>
#import <GD/GDAppDetail.h>

static NSString* service = @"com.good.gdservice.edit-file";
static NSString* version = @"1.0.0.0";

@implementation EditFileServiceProxy

-(id)initWithProvider:(GDAppDetail*)provider
{
    NSAssert(provider!=nil, @"nil service provider");

    self = [super init];
    if (self!=nil)
    {
        self.provider = provider;
    }
    return self;
}

+(NSArray*)getProviders;
{
    GDiOS* good = [GDiOS sharedInstance];
    return [good getApplicationDetailsForService:service andVersion:version];
}

-(BOOL)editFile:(NSString*)path requestID:(NSString* __autoreleasing*)requestID error:(NSError* __autoreleasing*)error
{
    NSAssert(path!=nil, @"nil file name");
    NSAssert(path.length>0, @"empty file name");

    NSData* identificationData = [path dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* parameters = [NSDictionary dictionaryWithObject:identificationData forKey:@"identificationData"];

    NSArray* attachments = [NSArray arrayWithObject:path];

    NSString* application = _provider.address;

    return [GDServiceClient sendTo:application
                       withService:service
                       withVersion:version
                        withMethod:@"editFile"
                        withParams:parameters
                   withAttachments:attachments
               bringServiceToFront:GDEPreferPeerInForeground
                         requestID:requestID
                             error:error];
}

@end
