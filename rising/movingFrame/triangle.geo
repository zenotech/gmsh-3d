

nb = 1;
b1 = 0.06;
wall = 0.2;

D = 1.0;
r = 0.35*D;
body = 2.0*D;
slug = 1.0*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 Include '../../bubbleShape/taylor.geo';
EndFor

wallLength1 = 3.0*D;
wallLength2 = nb*(body+3*r/2.0)+(nb-1)*slug;
wallLength3 = 2.0*D;

// side defined as equivalent diamenter D_eq of a circular channel with
// D = 1
// D_eq = 4*area/perimeter
side=3*D/Sqrt(3.0); 
height=side*Sqrt(3)/2.0;

/* 
 *                   19
 *                   o
 *                  / \          Z
 *                 /   \         ^
 *                /     \        |
 *               /       \       |
 *              o ------- o       ------> Y
 *             18         17
 *
 * */

k=10000;
Point(k+1)  = {0.0*D,     side/2.0,   -height/3.0, wall}; // bottom right
Point(k+2)  = {0.0*D,-1.0*side/2.0,   -height/3.0, wall}; // bottom left
Point(k+3)  = {0.0*D,          0.0,  2*height/3.0, wall}; // top
Point(k+4)  = {0.0*D, 1.0*side/3.0,           0.0, wall}; 
Point(k+5)  = {0.0*D,-1.0*side/3.0,           0.0, wall}; 
Point(k+6)  = {0.0*D, 1.0*side/6.0,    height/3.0, wall}; 
Point(k+7)  = {0.0*D,-1.0*side/6.0,    height/3.0, wall}; 
Point(k+8)  = {0.0*D, 1.0*side/6.0,   -height/3.0, wall}; // bottom right
Point(k+9)  = {0.0*D,-1.0*side/6.0,   -height/3.0, wall}; // bottom right

Line(k+1) = {k+1, k+8};
Line(k+2) = {k+8, k+9};
Line(k+3) = {k+9, k+2};
Line(k+4) = {k+2, k+5};
Line(k+5) = {k+5, k+7};
Line(k+6) = {k+7, k+3};
Line(k+7) = {k+3, k+6};
Line(k+8) = {k+6, k+4};
Line(k+9) = {k+4, k+1};

Extrude {wallLength2, 0, 0} {
  Line{k+01, k+02, k+03, k+04, k+05, k+06, k+07, k+08, k+09};
}
Extrude {wallLength3, 0, 0} {
  Line{k+42, k+38, k+34, k+30, k+26, k+22, k+18, k+14, k+10};
}
Extrude {-wallLength1, 0, 0} {
  Line{k+01, k+02, k+03, k+04, k+05, k+06, k+07, k+08, k+09};
}
Line Loop(k+118) = {k+86, k+90, k+94, k+98, 
                    k+102, k+106, k+110, k+114, k+82};
Plane Surface(k+119) = {k+118};
Line Loop(k+120) = {k+46, k+78, k+74, k+70, 
                    k+66, k+62, k+58, k+54, k+50};
Plane Surface(k+121) = {k+120};

Physical Surface('wallInflowZeroU') = {k+117, k+113, k+109, k+105,
                                       k+101, k+97, k+93, k+89, 
                                       k+85, -(k+45), -(k+41), -(k+37), 
                                       -(k+33), -(k+29),-(k+25),-(k+21),
                                       -(k+17),-(k+13), -(k+73), -(k+77), 
                                       -(k+81),-(k+49),-(k+53), -(k+57), 
                                       -(k+61), -(k+65), -(k+69), -(k+121), 
                                       k+119};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40, -(j+10), -(j+30), j+20,
                                            j+36, j+16, -(j+33), -(j+13), 
                                            -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

Transfinite Line {k+40, k+36, k+28, k+24, 
                  k+16, k+12} = 40 Using Progression 1;
Transfinite Line {k+02, k+08, k+05, k+38, 
                  k+14, k+26} = 10 Using Progression 1;
