/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              Phrases.m

    Comment:                phrases

    Version:                1.0

    Build:                  4

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/09-2010/06/12 (1.0.3)
                            2010/09/25-2010/09/25 (1.0.4)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/
#import "Phrases.h"
#import "DFString.h"
#include <dal.h>

@implementation Phrases

@synthesize phrases;
@synthesize charCount;

-(size_t)count
{
    return [phrases count];
}

-(id)initWithFile:(NSString*)path
{
    ASSERT( path!=nil );
    ASSERT( [path length]>0 );
    self = [super init];
    if( self!=nil )
    {
        NSString* content = [NSString stringWithContentsOfFile:path withNonUnicodeEncoding:kCFStringEncodingGB_18030_2000 error:NULL];
        NSArray* lines = [content componentsSeparatedByLine];
        NSMutableArray* linesWithoutEmpty = [[NSMutableArray alloc] init];
        phrases = linesWithoutEmpty;
        charCount = 0;
        for(NSString* line in lines)
        {
            if( [line length]>0 )
            {
                [linesWithoutEmpty addObject:line];
                charCount += [line length];
            }
        }
    }
    return self;
}

-(void)dealloc
{
    [phrases release];
    [super dealloc];
}

-(NSString*)phrase:(size_t)index
{
    ASSERT( index<[phrases count] );
    return [phrases objectAtIndex:index];
}

@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of Phrases.m

\*_________________________________________________________*/
