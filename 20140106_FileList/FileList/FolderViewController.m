//
//  FolderViewController.m
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import "FolderViewController.h"
#import <GD/GDFileSystem.h>
#import "EditFileServiceProxy.h"

@class GDAppDetail;

@interface FolderViewController ()

-(void)editFile:(NSString*)path;
-(GDAppDetail*)findEditFileProviderFor:(NSString*)path;
-(void)alert:(NSString*)message withTitle:(NSString*)title;

@property (strong, nonatomic) NSArray* files;

@end

@implementation FolderViewController

#pragma mark - UIViewController overriding

-(void)viewDidLoad
{
    [super viewDidLoad];

    __autoreleasing NSError* error;
    self.files = [GDFileSystem contentsOfDirectoryAtPath:_path error:&error];
    if (error!=nil)
    {
        NSLog(@"Error: get file list fail, %@ (%d), %@", error.domain, (int)error.code, error.localizedDescription);
    }

    NSString* title = [_path lastPathComponent];
    self.title = title;
}

#pragma mark - Table View data source (UITableViewDataSource)

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)_files.count;

    #pragma unused(tableView)
    #pragma unused(section)
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellID = @"Cell";

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSInteger index = indexPath.row;
    NSString* file = _files[(NSUInteger)index];
    cell.textLabel.text = file;

    return cell;
}

#pragma mark - Table View delegate (UITableViewDelegate)

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSInteger index = indexPath.row;
    NSString* file = _files[(NSUInteger)index];
    NSString* filePath = [_path stringByAppendingPathComponent:file];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSLog(@"select file %@", filePath);

    [self editFile:filePath];
}

#pragma mark - ServiceClientController delegate (ServiceClientControllerDelegate)

-(void)request:(NSString*)requestID returnError:(NSError*)error from:(NSString*)application
{
    NSLog(@"Error: call 'editFile' of 'Edit File Service' return error, %@ (%d), %@", error.domain, (int)error.code, error.localizedDescription);
    [self alert:error.localizedDescription withTitle:@"Error"];

    ServiceClientController* client = [ServiceClientController sharedInstance];
    NSAssert(client!=nil, @"no ServiceClientController instance");

    #pragma unused(requestID)
    #pragma unused(application)
}

-(void)request:(NSString*)requestID returnWithParams:(id)parameters withAttachments:(NSArray*)attachments from:(NSString*)application
{
    if (parameters!=nil)
    {
        NSLog(@"Error: call 'editFile' of 'Edit File Service' on %@, return unexpected parameter, %@", application, parameters);
        [self alert:@"Server return unexpected parameter" withTitle:@"Server Error"];
    }

    if (attachments!=nil)
    {
        NSLog(@"Error: call 'editFile' of 'Edit File Service' on %@, return unexpected attachments, %@", application, attachments);
        [self alert:@"Server return unexpected attachments" withTitle:@"Server Error"];
    }

    #pragma unused(requestID)
    #pragma unused(application)
}

#pragma mark - FolderViewController private

-(void)editFile:(NSString*)path
{
    NSAssert(path!=nil, @"nil file name");
    NSAssert(path.length>0, @"empty file name");

    GDAppDetail* provider = [self findEditFileProviderFor:path];
    if (provider!=nil)
    {
        EditFileServiceProxy* service = [[EditFileServiceProxy alloc] initWithProvider:provider];

        __autoreleasing NSError* error;
        __autoreleasing NSString* requestID;
        BOOL accepted = [service editFile:path requestID:&requestID error:&error];

        if (accepted)
        {
            NSAssert(requestID!=nil, @"nil request ID");
            NSAssert(requestID.length>0, @"empty request ID");

            ServiceClientController* client = [ServiceClientController sharedInstance];
            NSAssert(client!=nil, @"no ServiceClientController instance");

            [client setDelegate:self forRequest:requestID];
        }
        else
        {
            NSLog(@"Error: call 'editFile' of 'Edit File Service' fail, %@ (%d), %@", error.domain, (int)error.code, error.localizedDescription);
            [self alert:error.localizedDescription withTitle:@"Error"];
        }
    }
    else
    {
        NSLog(@"Error: no 'Edit File Service' find");
        [self alert:@"No 'Edit File Service' find" withTitle:@"Error"];
    }
}

-(GDAppDetail*)findEditFileProviderFor:(NSString*)path
{
    NSAssert(path!=nil, @"nil file name");
    NSAssert(path.length>0, @"empty file name");

    NSArray* providers = [EditFileServiceProxy getProviders];
    if (providers.count>0)
    {
        return providers[0];
    }
    return nil;

    #pragma unused(path)
}

-(void)alert:(NSString*)message withTitle:(NSString*)title
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
