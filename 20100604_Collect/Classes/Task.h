/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              Task.h

    Comment:                task

    Version:                1.0

    Build:                  7

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/10-2010/06/12 (1.0.5)
                            2010/06/20-2010/06/20 (1.0.6)
                            2010/09/25-2010/09/25 (1.0.7)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/

#import <Foundation/Foundation.h>

typedef enum
{
    taskOpend,
    taskNotExists,
    taskNotReadable,
    taskNotWritable,
    taskOpenFail,
    taskExists,
    taskIsFolder,
}
TaskResult;

@interface Task: NSObject
{
    FILE* file;
    NSString* user;
    size_t count;
}
@property (nonatomic, readonly) bool open;
@property (nonatomic, readonly, retain) NSString* user;
@property (nonatomic, readonly) size_t count;
-(id)init;
-(TaskResult)openTaskWithUserName:(NSString*)userName;
-(TaskResult)newTaskWithUserName:(NSString*)userName age:(NSString*)age gender:(NSString*)gender education:(NSString*)education profession:(NSString*)profession device:(NSString*)device;
-(void)closeTask;
-(void)addPhrase:(NSString*)phrase withStroke:(const void*)dots;
@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of Task.h

\*_________________________________________________________*/
