/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              DFDrawView.mm

    Comment:                draw view

    Version:                1.0

    Build:                  2

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/11-2010/06/12 (1.0)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/

#include <dal.h>
#include <simple_vector.hpp>
#include "stroke.hpp"
#import "DFDrawView.h"
#import "DFDrawViewDelegate.h"

using namespace draw;

@implementation DFDrawView

@synthesize enabled;
@synthesize dots;
@synthesize delegate;

-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if( self!=nil )
    {
        enabled = YES;
        path = CGPathCreateMutable();
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self!=nil )
    {
        enabled = YES;
        path = CGPathCreateMutable();
    }
    return self;
}

-(void)dealloc
{
    CGPathRelease(path);
#if (defined _DEBUG)
    enabled = NO;
    dots = (stroke*)NULL;
    path = nil;
#endif
    [super dealloc];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 6);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBStrokeColor(context, 0, 0, 255, 1);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if( enabled )
    {
        UITouch* touch = [touches anyObject];
        CGPoint location = [touch locationInView:self];
        DEBUG_MESSAGE(TRUE, ("touch begin at (%d, %d)\n", (int)location.x, (int)location.y));
        point dot;
        dot.m_nX = location.x;
        dot.m_nY = location.y;
        if( dots!=(void*)NULL )
        {
            point beginDot;
            beginDot.m_nX = (unsigned int)-1;
            beginDot.m_nY = (unsigned int)-1;
            dots->push_back(beginDot);
            dots->push_back(dot);
        }
        CGPathMoveToPoint(path, NULL, location.x, location.y);
        [self setNeedsDisplay];
        if( delegate!=nil )
        {
            [delegate drawViewBeganTouch:self];
        }
    }
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    if( enabled )
    {
        UITouch* touch = [touches anyObject];
        CGPoint location = [touch locationInView:self];
        DEBUG_MESSAGE(TRUE, ("touch end at (%d, %d)\n", (int)location.x, (int)location.y));
        point dot;
        dot.m_nX = location.x;
        dot.m_nY = location.y;
        if( dots!=(stroke*)NULL )
        {
            dots->push_back(dot);
        }
        CGPathAddLineToPoint(path, NULL, location.x, location.y);
        [self setNeedsDisplay];
    }
}

-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    if( enabled )
    {
        UITouch* touch = [touches anyObject];
        CGPoint location = [touch locationInView:self];
        DEBUG_MESSAGE(TRUE, ("touch moved to (%d, %d)\n", (int)location.x, (int)location.y));
        point dot;
        dot.m_nX = location.x;
        dot.m_nY = location.y;
        if( dots!=(stroke*)NULL )
        {
            dots->push_back(dot);
        }
        CGPathAddLineToPoint(path, NULL, location.x, location.y);
        [self setNeedsDisplay];
    }
}

-(void)clear
{
    dots->clear();
    CGPathRelease(path);
    path = CGPathCreateMutable();
    [self setNeedsDisplay];
}

@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of DFDrawView.mm

\*_________________________________________________________*/
