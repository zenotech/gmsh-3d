

nb = 1;
b1 = 0.05;
wall = 0.05;

D = 1.0;
r = 0.35*D;
body = 5*r;
slug = 1.0*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../bubbleShape/taylor.geo';
EndFor

wallLength = D+nb*(body+3*r/2.0)+(nb-1)*slug+D + 7*D;
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
Point(k+1) = {-D,     side/2.0,   -height/3.0, wall}; // bottom right
Point(k+2) = {-D,-1.0*side/2.0,   -height/3.0, wall}; // bottom left
Point(k+3) = {-D,          0.0,  2*height/3.0, wall}; // top
Point(k+4) = {-D, 1.0*side/3.0,           0.0, wall}; 
Point(k+5) = {-D,-1.0*side/3.0,           0.0, wall}; 
Point(k+6) = {-D, 1.0*side/6.0,    height/3.0, wall}; 
Point(k+7) = {-D,-1.0*side/6.0,    height/3.0, wall}; 
Point(k+8) = {-D, 1.0*side/6.0,   -height/3.0, wall}; // bottom right
Point(k+9) = {-D,-1.0*side/6.0,   -height/3.0, wall}; // bottom right

Line(k+1) = {k+3, k+7};
Line(k+2) = {k+7, k+5};
Line(k+3) = {k+5, k+2};
Line(k+4) = {k+2, k+9};
Line(k+5) = {k+9, k+8};
Line(k+6) = {k+8, k+1};
Line(k+7) = {k+1, k+4};
Line(k+8) = {k+4, k+6};
Line(k+9) = {k+6, k+3};
Line Loop(k+10) = {k+1,k+2,k+3,k+4,k+5,k+6,k+7,k+8,k+9};
Plane Surface(k+11) = {k+10};
Extrude {wallLength, 0, 0} {
  Surface{k+11};
}

Transfinite Line {k+23, k+32, k+44} = 0.3*wallLength/wall Using Progression 1;
Transfinite Line {k+7, k+6, k+5, k+4, k+3, k+2, k+1, k+9, k+8, k+20, 
k+19, k+18, k+17, k+21, k+13, k+14, k+15, k+16} = 5 Using Progression 1;

Physical Surface('wallNoSlip') = {k+11, k+58, k+45, k+49, k+53, 
k+41, k+25, k+29, k+33, k+57, k+37};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40, -(j+10), -(j+30), j+20,
 j+36, j+16, -(j+33), -(j+13), -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

