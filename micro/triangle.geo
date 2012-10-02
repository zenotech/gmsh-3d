
nb = 1;
b1 = 0.06;
wall = 0.07;

D = 1.0;
r = 0.35*D;
body = 1*D;
slug = 0.7*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../bubbleShape/taylor.geo';
EndFor

wallLength = D+(body+3*r/2.0)+D;
side=D*Sqrt(3);
height=side*Sqrt(3)/2.0;


/* 
 *                   19
 *                   o
 *                  / \          Y
 *                 /   \         ^
 *                /     \        |
 *               /       \       |
 *              o ------- o       ------> Z
 *             18         17
 *
 * */

k=10000;
Point(k+1) = {xc-D,     side/2.0,   -height/3.0, wall}; // bottom right
Point(k+2) = {xc-D,-1.0*side/2.0,   -height/3.0, wall}; // bottom left
Point(k+3) = {xc-D,          0.0,  2*height/3.0, wall}; // top
Line(k+04) = {k+03, k+01};
Line(k+05) = {k+01, k+02};
Line(k+06) = {k+02, k+03};
Line Loop(k+07) = {k+04, k+05, k+06};
Plane Surface(k+08) = {k+07};
Extrude {wallLength, 0, 0} {
  Surface{k+8};
}

Physical Surface('wallInflowUParabolic') = {k+08,k+25};
Physical Surface('wallNoSlipPressure') = {k+16, k+20, k+24};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40,-(j+10), -(j+30), j+20,
 j+36, j+16, -(j+33), -(j+13), -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor
