/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              Phrases.h

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

#import <Foundation/Foundation.h>

@interface Phrases: NSObject
{
    NSArray* phrases;
    size_t charCount;
}
@property (nonatomic, readonly) NSArray* phrases;
@property (nonatomic, readonly) size_t count;
@property (nonatomic, readonly) size_t charCount;
-(id)initWithFile:(NSString*)path;
-(NSString*)phrase:(size_t)index;
@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of Phrases.h

\*_________________________________________________________*/
