//
//  EditFileServiceProxy.h
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDAppDetail;

@interface EditFileServiceProxy:
    NSObject
{
}

-(id)initWithProvider:(GDAppDetail*)provider;
+(NSArray*)getProviders;
-(BOOL)editFile:(NSString*)path requestID:(NSString**)requestID error:(NSError**)error;

@property (strong, nonatomic) GDAppDetail* provider;

@end
