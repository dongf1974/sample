/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              Task.mm

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

#import "Task.h"
#include <dal.h>
#include <simple_vector.hpp>
#include "stroke.hpp"

using namespace draw;

@interface Task ()
-(size_t)readCount;
-(void)writeUserName:(NSString*)userName age:(NSString*)age gender:(NSString*)gender education:(NSString*)education profession:(NSString*)profession device:(NSString*)device;
-(void)writePhrase:(NSString*)phrase withStroke:(const stroke*)dots;
-(void)write:(NSString*)line;
+(NSString*)fileNameWithUserName:(NSString*)userName;
+(NSString*) phraseTohex:(NSString*)phrase;
@end

static BOOL findLine(FILE* file, const char* start);

@implementation Task

@synthesize count;
@synthesize user;

-(bool)open
{
    return file!=(FILE*)NULL;
}

-(id)init
{
    self = [super init];
    if( self!=nil )
    {
        file = (FILE*)NULL;
        user = nil;
        count = 0;
    }
    return self;
}

-(void)dealloc
{
    if( file!=(FILE*)NULL )
    {
        fclose(file);
        ASSERT( user!=nil );
        [user release];
#if (defined _DEBUG)
        file = (FILE*)NULL;
        count = 0;
#endif
    }
    else
    {
        ASSERT( user==nil );
        ASSERT( count==0 );
    }
    [super dealloc];
    DEBUG_MESSAGE(TRUE, ("dealloc task\n"));
}

-(TaskResult)openTaskWithUserName:(NSString*)userName
{
    ASSERT( userName!=nil );
    ASSERT( [userName length]>0 );
    ASSERT( file==(FILE*)NULL );
    ASSERT( user==nil );
    ASSERT( count==0 );
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* taskFileName = [Task fileNameWithUserName:userName];
    TaskResult result;
    BOOL isDirectory = NO;
    if( [fileManager fileExistsAtPath:taskFileName isDirectory:&isDirectory] )
    {
        if( !isDirectory )
        {
            if( [fileManager isReadableFileAtPath:taskFileName] )
            {
                if( [fileManager isWritableFileAtPath:taskFileName] )
                {
                    const char* fileName = [taskFileName cStringUsingEncoding:NSUTF8StringEncoding];
                    file = fopen(fileName, "rt+");
                    if( file!=(FILE*)NULL )
                    {
                        result = taskOpend;
                        user = userName;
                        [user retain];
                        count = [self readCount];
                        DEBUG_MESSAGE_O(TRUE, @"open task \"%@\"\n", user);
                    }
                    else
                    {
                        result = taskOpenFail;
                    }
                }
                else
                {
                    result = taskNotWritable;
                }
            }
            else
            {
                result = taskNotReadable;
            }
        }
        else
        {
            result = taskNotExists;
        }
    }
    else
    {
        result = taskNotExists;
    }
    return result;
}

-(TaskResult)newTaskWithUserName:(NSString*)userName age:(NSString*)age gender:(NSString*)gender education:(NSString*)education profession:(NSString*)profession device:(NSString*)device
{
    ASSERT( userName!=nil );
    ASSERT( age!=nil );
    ASSERT( gender!=nil );
    ASSERT( education!=nil );
    ASSERT( profession!=nil );
    ASSERT( device!=nil );
    ASSERT( [userName length]>0 );
    ASSERT( file==(FILE*)NULL );
    ASSERT( user==nil );
    ASSERT( count==0 );
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* taskFileName = [Task fileNameWithUserName:userName];
    TaskResult result;
    BOOL isDirectory = NO;
    if( ![fileManager fileExistsAtPath:taskFileName isDirectory:&isDirectory] )
    {
        const char* fileName = [taskFileName cStringUsingEncoding:NSUTF8StringEncoding];
        file = fopen(fileName, "wt");
        if( file!=(FILE*)NULL )
        {
            result = taskOpend;
            user = userName;
            [user retain];
            count = 0;
            [self writeUserName:userName age:age gender:gender education:education profession:profession device:device];
            DEBUG_MESSAGE_O(TRUE, @"new task \"%@\"\n", user);
        }
        else
        {
            result = taskOpenFail;
        }
    }
    else
    {
        if( !isDirectory )
        {
            result = taskExists;
        }
        else
        {
            result = taskIsFolder;
        }
    }
    return result;
}

-(void)closeTask
{
    ASSERT( file!=(FILE*)NULL );
    fclose(file);
    file = (FILE*)NULL;
    count = 0;
    [user release];
    user = nil;
    DEBUG_MESSAGE(TRUE, ("close task\n"));
}

-(void)addPhrase:(NSString*)phrase withStroke:(const void*)dots
{
    ASSERT( phrase!=nil );
    ASSERT( [phrase length]>0 );
    ASSERT( dots!=(const void*)NULL );
    ASSERT( file!=(FILE*)NULL );
    const stroke* strokeToSave = (const stroke*)dots;
    [self writePhrase:phrase withStroke:strokeToSave];
    count++;
}

-(size_t)readCount
{
    ASSERT( file!=(FILE*)NULL );
    VERIFY( fseek(file, 0, SEEK_SET)==0 );
    size_t phraseCount = 0;
    while( findLine(file, ".END_SEG LINE") )
    {
        phraseCount++;
    }
    return phraseCount;
}

-(void)writeUserName:(NSString*)userName age:(NSString*)age gender:(NSString*)gender education:(NSString*)education profession:(NSString*)profession device:(NSString*)device
{
    ASSERT( userName!=nil );
    ASSERT( age!=nil );
    ASSERT( gender!=nil );
    ASSERT( education!=nil );
    ASSERT( profession!=nil );
    ASSERT( device!=nil );
    ASSERT( [userName length]>0 );
    ASSERT( file!=(FILE*)NULL );
    VERIFY( fseek(file, 0, SEEK_SET)==0 );
    NSString* line;
    line = [NSString stringWithFormat:@".WRITER_ID %@\n", userName];
    [self write:line];
    line = [NSString stringWithFormat:@".EDUCATION %@\n", education];
    [self write:line];
    line = [NSString stringWithFormat:@".PROFESSION %@\n", profession];
    [self write:line];
    line = [NSString stringWithFormat:@".AGE %@\n", age];
    [self write:line];
    line = [NSString stringWithFormat:@".SEX %@\n", gender];
    [self write:line];
    line = [NSString stringWithFormat:@".DEVICE %@\n", device];
    [self write:line];
}

-(void)writePhrase:(NSString*)phrase withStroke:(const stroke*)dots
{
    ASSERT( phrase!=nil );
    ASSERT( [phrase length]>0 );
    ASSERT( dots!=(const stroke*)NULL );
    ASSERT( file!=(FILE*)NULL );
    VERIFY( fseek(file, 0, SEEK_END)==0 );
    NSString* hexPhrase = [Task phraseTohex:phrase];
    NSString* line;
    line = [NSString stringWithFormat:@".SEGMENT LINE ? ? \"%@\"\n", hexPhrase];
    [self write:line];
    point beginDot;
    beginDot.m_nX = (unsigned int)-1;
    beginDot.m_nY = (unsigned int)-1;
    stroke::const_iterator beginIterator = dots->begin();
    stroke::const_iterator endIterator = dots->end();
    stroke::const_iterator iterator = beginIterator;
    line = [NSString stringWithFormat:@".PEN_DOWN\n"];
    [self write:line];
    for(; iterator!=endIterator; ++iterator)
    {
        point dot = *iterator;
        if( dot.m_nX!=beginDot.m_nX || dot.m_nY!=beginDot.m_nY )
        {
            line = [NSString stringWithFormat:@"%u -%u\n", dot.m_nX, dot.m_nY];
            [self write:line];
        }
        else
        {
            if( iterator!=beginIterator )
            {
                line = [NSString stringWithFormat:@".PEN_UP\n"];
                [self write:line];
                line = [NSString stringWithFormat:@".PEN_DOWN\n"];
                [self write:line];
            }
        }
    }
    line = [NSString stringWithFormat:@".PEN_UP\n"];
    [self write:line];
    line = [NSString stringWithFormat:@".END_SEG LINE ? ? \"%@\"\n", hexPhrase];
    [self write:line];
}

-(void)write:(NSString*)line
{
    ASSERT( line!=nil );
    ASSERT( [line length]>0 );
    ASSERT( file!=(FILE*)NULL );
    NSStringEncoding encoding = (NSStringEncoding)CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    const char* text = [line cStringUsingEncoding:encoding];
    if( text!=(const char*)NULL )
    {
        fprintf(file, "%s", text);
    }
}

+(NSString*)fileNameWithUserName:(NSString*)userName
{
    ASSERT( userName!=nil );
    ASSERT( [userName length]>0 );
    NSString* home = NSHomeDirectory();
    NSString* fileName = [NSString stringWithFormat:@"%@/Documents/%@.uni", home, userName];
    return fileName;
}

+(NSString*) phraseTohex:(NSString*)phrase
{
    ASSERT( phrase!=nil );
    ASSERT( [phrase length]>0 );
    const size_t maxPhraseLength = 20;
    const size_t hexPerCharacter = 6;
    size_t phraseLength = [phrase length];
    char hexBuffer[maxPhraseLength*(hexPerCharacter+1)];
    size_t index = 0;
    char* buffer = hexBuffer;
    for(; index<phraseLength && index<maxPhraseLength; index++)
    {
        unichar charactor = [phrase characterAtIndex:index];
        sprintf(buffer, "0x%04X ", (unsigned int)charactor);
        buffer += hexPerCharacter+1;
    }
    buffer--;
    *buffer = '\0';
    NSString* hex = [NSString stringWithCString:hexBuffer encoding:NSASCIIStringEncoding];
    return hex;
}

@end

static BOOL findLine(FILE* file, const char* start)
{
    ASSERT( file!=(FILE*)NULL );
    ASSERT( start!=(const char*)NULL );
    ASSERT( strlen(start)>0 );
    ASSERT( start[0]!='\n' );
    char read;
    while( read=fgetc(file), read!=EOF )
    {
        if( read==start[0] )
        {
            const char* current = start+1;
            while( *current!='\0' )
            {
                ASSERT( *current!='\n' );
                read = fgetc(file);
                if( read!=*current || read=='\n' || read==EOF )
                {
                    break;
                }
                current++;
            }
            if( *current=='\0' )
            {
                while( read!='\n' && read!=EOF )
                {
                    read = fgetc(file);
                }
                return TRUE;
            }
        }
        while( read!='\n' && read!=EOF )
        {
            read = fgetc(file);
        }
    }
    return FALSE;
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of Task.mm

\*_________________________________________________________*/
