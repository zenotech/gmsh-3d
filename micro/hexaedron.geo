
nb = 1;
b1 = 0.09;
wall = 0.3;

D = 1.0;
r = 0.35*D;
body = 2*D;
slug = 0.7*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 Include '../bubbleShape/taylor.geo';
EndFor

wallLength1 = 3.0*D;
wallLength2 = nb*(body+3*r/2.0)+(nb-1)*slug;
wallLength3 = 2.0*D;

height=D;
side=(D/Sqrt(3));


/*              20        19
 *               o ------ o   
 *              /          \        
 *             /            \              
 *         18 o      x       o 17       Z  ^
 *             \            /              |
 *              \          /               |
 *              o ------- o                 ------> Y
 *             22         21
 *
 * */

k=10000;
Point(k+1) = {-wallLength1,  side,        0.0, wall}; // right
Point(k+2) = {-wallLength1, -side,        0.0, wall}; // left
Point(k+3) = {-wallLength1,  side/2.0, height/2.0, wall}; // right top
Point(k+4) = {-wallLength1, -side/2.0, height/2.0, wall}; // left top
Point(k+5) = {-wallLength1,  side/2.0,-height/2.0, wall}; // right bottom
Point(k+6) = {-wallLength1, -side/2.0,-height/2.0, wall}; // left bottom
Line(k+1) = {k+3, k+1};
Line(k+2) = {k+1, k+5};
Line(k+3) = {k+5, k+6};
Line(k+4) = {k+6, k+2};
Line(k+5) = {k+2, k+4};
Line(k+6) = {k+4, k+3};
Line Loop(k+7) = {k+3, k+4, k+5, k+6, k+1, k+2};

Extrude {wallLength1, 0, 0} {
  Line{k+01, k+02, k+03, k+04, k+05, k+06};
}
Extrude {wallLength2, 0, 0} {
  Line{k+08, k+12, k+16, k+20, k+24, k+28};
}
Extrude {wallLength3, 0, 0} {
  Line{k+32, k+36, k+40, k+44, k+48, k+52};
}
Plane Surface(k+80) = {k+07};
Line Loop(k+81) = {k+60, k+64, k+68, k+72, k+76, k+56};
Plane Surface(k+82) = {k+81};
Physical Surface('wallInflowUParabolic') = {k+80, k+82};
Physical Surface('wallNoSlipPressure') = {k+23, k+47, k+71, k+27, k+19, k+31, k+15, k+11, k+35, k+67, k+55, k+51, k+63, k+39, k+43, k+59, k+79, k+75};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40,-(j+10), -(j+30), j+20,
 j+36, j+16, -(j+33), -(j+13), -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

Transfinite Line {k+46, k+50, k+33, k+34, k+38, k+42} = 5*wallLength2/wall Using Progression 1;
Transfinite Line {k+32, k+36, k+40, k+44, k+48, k+52, k+08, k+12, k+16, k+20, k+24, k+28} = 3*D/wall Using Progression 1;

