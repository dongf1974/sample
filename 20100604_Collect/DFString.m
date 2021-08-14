/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              DFString.m

    Comment:                extension of NSString

    Version:                1.1

    Build:                  3

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/09-2010/06/10 (1.0)
                            2010/06/14-2010/06/14 (1.1)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.
    This file is part of Dong Fang's Objective-C Extension.

    This software is published under the terms of FreeBSD-style license.
    To get license other than FreeBSD-style, contact Dong Fang (Walter Dong).

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY DONG FANG (WALTER DONG) "AS IS" AND ANY
    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL DONG FANG (WALTER DONG) BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

\*_________________________________________________________*/
#import "DFString.h"
#include <dal.h>

@implementation NSString (DFExtension)

+(id)stringWithContentsOfFile:(NSString*)path withEncoding:(CFStringEncoding)encoding error:(NSError**)error
{
    ASSERT( path!=nil );
    ASSERT( [path length]>0 );
    NSStringEncoding nsEncoding = (NSStringEncoding)CFStringConvertEncodingToNSStringEncoding(encoding);
    return [NSString stringWithContentsOfFile:path encoding:nsEncoding error:error];
}

+(id)stringWithContentsOfFile:(NSString*)path withNonUnicodeEncoding:(CFStringEncoding)encoding error:(NSError**)error
{
    ASSERT( path!=nil );
    ASSERT( [path length]>0 );
    NSError* Error = nil;
    NSString* string = [NSString stringWithContentsOfFile:path usedEncoding:NULL error:&Error];
    if( Error!=nil )
    {
        ASSERT( string==nil );
        Error = nil;
        string = [NSString stringWithContentsOfFile:path withEncoding:encoding error:&Error];
        if( Error!=nil )
        {
            ASSERT( string==nil );
        }
        else
        {
            ASSERT( string!=nil );
        }
    }
    else
    {
        ASSERT( string!=nil );
    }
    if( error!=nil )
    {
        *error = Error;
    }
    return string;
}

-(NSArray*)componentsSeparatedByLine
{
    NSMutableArray* returnLines = [[NSMutableArray alloc] init];
    NSCharacterSet* newlineCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSArray* segments = [self componentsSeparatedByString:@"\r\n"];
    for(NSString* segment in segments)
    {
        NSArray* lines = [segment componentsSeparatedByCharactersInSet:newlineCharacterSet];
        for(NSString* line in lines)
        {
            [returnLines addObject:line];
        }
    }
    return returnLines;
}

@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of DFStrings.m

\*_________________________________________________________*/
