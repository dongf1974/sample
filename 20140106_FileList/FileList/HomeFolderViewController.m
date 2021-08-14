//
//  HomeFolderViewController.m
//  FileList
//
//  Created by Dong Fang (dongf@live.com) on 2013/12/31.
//  Copyright (c) 2013 Dong Fang. All rights reserved.
//

#import "HomeFolderViewController.h"
#import <GD/GDFileSystem.h>

@interface HomeFolderViewController ()

+(void)initSampleFiles;
+(void)copyFile:(NSString*)source to:(NSString*)destination;
+(BOOL)containFiles;
+(NSString*)sampleFolderPath;
+(NSString*)documentFolderPath;

@end

@implementation HomeFolderViewController

#pragma mark - UIViewController overriding

-(void)viewDidLoad
{
    [HomeFolderViewController initSampleFiles];

    NSString* documentFolderPath = [HomeFolderViewController documentFolderPath];
    self.path = documentFolderPath;

    [super viewDidLoad];
}

#pragma mark - HomeFolderViewController private

+(void)initSampleFiles
{
    if (![HomeFolderViewController containFiles])
    {
        NSLog(@"copy sample files to Good Dynamic Secure File System");

        NSString* documentFolderPath = [HomeFolderViewController documentFolderPath];

        NSString* sampleFolderPath = [HomeFolderViewController sampleFolderPath];
        
        NSFileManager* manager = [NSFileManager defaultManager];
        __autoreleasing NSError* error;
        NSArray* files = [manager contentsOfDirectoryAtPath:sampleFolderPath error:&error];
        if (error!=nil)
        {
            NSLog(@"Error: get file list fail, %@ (%d), %@", error.domain, (int)error.code, error.localizedDescription);
        }

        for (NSString* file in files)
        {
            NSString* source = [sampleFolderPath stringByAppendingPathComponent:file];
            NSString* destination = [documentFolderPath stringByAppendingPathComponent:file];
            [HomeFolderViewController copyFile:source to:destination];
        }
    }
}

+(void)copyFile:(NSString*)source to:(NSString*)destination
{
    NSFileManager* manager = [NSFileManager defaultManager];
    BOOL isFolder = FALSE;
    BOOL exist = [manager fileExistsAtPath:source isDirectory:&isFolder];
    NSAssert(exist, @"source file does not exist, file: %@", source);

    if (!isFolder)
    {
        NSData* data = [NSData dataWithContentsOfFile:source];

        __autoreleasing NSError* error;
        [GDFileSystem writeToFile:data name:destination error:&error];
        if (error!=nil)
        {
            NSLog(@"Error: save to secure file system fail, file: %@, %@ (%d), %@", destination, error.domain, (int)error.code, error.localizedDescription);
        }
    }
}

+(BOOL)containFiles
{
    NSString* documentFolderPath = [HomeFolderViewController documentFolderPath];

    __autoreleasing NSError* error;
    NSArray* files = [GDFileSystem contentsOfDirectoryAtPath:documentFolderPath error:&error];
    if (error!=nil)
    {
        NSLog(@"Error: get file list fail, %@ (%d), %@", error.domain, (int)error.code, error.localizedDescription);
    }

    return files.count>0;
}

+(NSString*)sampleFolderPath
{
    NSString* resourceFolderPath = [[NSBundle mainBundle] resourcePath];
    NSString* sampleFolderPath = [resourceFolderPath stringByAppendingPathComponent:@"SampleFile"];
    return sampleFolderPath;
}

+(NSString*)documentFolderPath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = paths[0];
    return path;
}

@end
