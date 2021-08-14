//
//  FolderViewController.h
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceClientController.h"

@interface FolderViewController:
    UITableViewController<
    ServiceClientControllerDelegate>
{
}

@property (strong, nonatomic) NSString* path;

@end
