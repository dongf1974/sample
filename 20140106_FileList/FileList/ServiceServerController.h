//
//  ServiceServerController.h
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GD/GDServices.h>

@interface ServiceServerController:
    NSObject<
    GDServiceDelegate>
{
}

+(ServiceServerController*)sharedInstance;
-(void)updateServices;

@end
