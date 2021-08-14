/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              DFDrawView.h

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

#import <UIKit/UIKit.h>

@protocol DFDrawViewDelegate;

@interface DFDrawView: UIView
{
    bool enabled;
    draw::stroke* dots;
    id<DFDrawViewDelegate> delegate;
    CGMutablePathRef path;
}
@property (nonatomic, assign) bool enabled;
@property (nonatomic, assign) draw::stroke* dots;
@property (nonatomic, assign) id<DFDrawViewDelegate> delegate;
-(void)clear;
@end

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of DFDrawView.h

\*_________________________________________________________*/
