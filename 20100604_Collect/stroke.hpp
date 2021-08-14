/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    File Name:              stroke.hpp

    Comment:                stroke

    Class Name:             draw::stroke

    Version:                1.0

    Build:                  1

    Author:                 Dong Fang (Walter Dong)

    Contact:                dongfang@ustc.edu
                            dongf@live.com

    Time:                   2010/06/11-2010/06/11 (1.0)

    Notice:
    Copyright (C) 2010, Dong Fang (Walter Dong).
    All rights reserved.

\*_________________________________________________________*/
#ifndef STROKE_HPP
#define STROKE_HPP

namespace draw
{
    
//The definition of point
struct point
{
    unsigned int m_nX;
    unsigned int m_nY;
};

//The definition of stroke
typedef dsal::simple_vector<point> stroke;

}

#endif
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\

    End of stroke.hpp

\*_________________________________________________________*/
