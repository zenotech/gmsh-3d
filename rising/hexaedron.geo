
nb = 5;
b1 = 0.06;
wall = 0.2;

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

wallLength1 = 2.0*D;
wallLength2 = nb*(body+3*r/2.0)+(nb-1)*slug;
wallLength3 = 1.0*D;

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
Point(k+1) = {-2*D,  side,        0.0, wall}; // right
Point(k+2) = {-2*D, -side,        0.0, wall}; // left
Point(k+3) = {-2*D,  side/2.0, height/2.0, wall}; // right top
Point(k+4) = {-2*D, -side/2.0, height/2.0, wall}; // left top
Point(k+5) = {-2*D,  side/2.0,-height/2.0, wall}; // right bottom
Point(k+6) = {-2*D, -side/2.0,-height/2.0, wall}; // left bottom
Line(k+1) = {k+3, k+1};
Line(k+2) = {k+1, k+5};
Line(k+3) = {k+5, k+6};
Line(k+4) = {k+6, k+2};
Line(k+5) = {k+2, k+4};
Line(k+6) = {k+4, k+3};

Extrude {wallLength1, 0, 0} {
  Line{k+01, k+02, k+03, k+04, k+05, k+06};
}
Extrude {wallLength2, 0, 0} {
  Line{k+11, k+15, k+19, k+23, k+27, k+07};
}
Extrude {wallLength3, 0, 0} {
  Line{k+31, k+35, k+39, k+43, k+47, k+51};
}
Line Loop(k+79) = {k+01, k+02, k+03, k+04, k+05, k+06};
Plane Surface(k+80) = {k+79};
Line Loop(k+81) = {k+75, k+55, k+59, k+63, k+67, k+71};
Plane Surface(k+82) = {k+81};
Physical Surface('wallInflowZeroU') = {-(k+30), -(k+10), -(k+14), -(k+18),
-(k+22), -(k+26), -(k+54), -(k+34), -(k+38), -(k+42), -(k+62), -(k+50), -(k+58),
-(k+46), -(k+70), -(k+74), -(k+66), -(k+78), -(k+82), k+80};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40, -(j+10), -(j+30), j+20,
 j+36, j+16, -(j+33), -(j+13), -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

Transfinite Line {k+33, k+32, k+49, k+37, k+45, k+41} = 4*wallLength2/wall Using Progression 1;
Transfinite Line {k+39, k+43, k+47, k+35, k+31, k+51, k+07,
k+11, k+15, k+19, k+23, k+27} = 3*D/wall Using Progression 1;
