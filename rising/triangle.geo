

nb = 1;
b1 = 0.06;
wall = 0.2;

D = 1.0;
r = 0.35*D;
body = 2*D;
slug = 1.0*r;

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
side=D*Sqrt(3);
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
Point(k+1) = {0.0*D,     side/2.0,   -height/3.0, wall}; // bottom right
Point(k+2) = {0.0*D,-1.0*side/2.0,   -height/3.0, wall}; // bottom left
Point(k+3) = {0.0*D,          0.0,  2*height/3.0, wall}; // top
Line(k+1) = {k+1, k+3};
Line(k+2) = {k+3, k+2};
Line(k+3) = {k+2, k+1};

Extrude {wallLength2, 0, 0} {
  Line{k+01, k+03, k+02};
}
Extrude {wallLength3, 0, 0} {
  Line{k+04, k+08, k+12};
}
Extrude {-wallLength1, 0, 0} {
  Line{k+01, k+03, k+02};
}

Line Loop(k+40) = {k+28, k+36, k+32};
Plane Surface(k+41) = {k+40};
Line Loop(k+42) = {k+16, k+24, k+20};
Plane Surface(k+43) = {k+42};

Physical Surface('wallInflowZeroU') = {k+41, k+31, k+39, k+35, k+15, k+07, k+11, k+19, k+23, k+27, k+43};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40, -(j+10), -(j+30), j+20,
 j+36, j+16, -(j+33), -(j+13), -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

//Printf("%g",wallLength1/wall);
Transfinite Line {k+01, k+03, k+02, k+04, k+08, k+12} = 15 Using Progression 1;
Transfinite Line {k+05, k+06, k+09} = 30 Using Progression 1;

