
nb = 3;
b1 = 0.09;
wall = 0.08;

D = 1.0;
r = 0.2*D;
body = 1*r;
slug = 1.0*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 Include '../bubbleShape/taylor.geo';
EndFor

wallLength = D+nb*(body+3*r/2.0)+(nb-1)*slug+D;
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
Point(k+1) = {-D,     side/2.0,   -height/3.0, wall}; // bottom right
Point(k+2) = {-D,-1.0*side/2.0,   -height/3.0, wall}; // bottom left
Point(k+3) = {-D,          0.0,  2*height/3.0, wall}; // top
Line(k+1) = {k+1, k+3};
Line(k+2) = {k+3, k+2};
Line(k+3) = {k+2, k+1};
Line Loop(k+4) = {k+1, k+2, k+3};
Plane Surface(k+5) = {k+4};
Extrude {wallLength, 0, 0} {
  Surface{k+5};
}

Physical Surface('wallInflowZeroU') = {k+22};
Physical Surface('wallOutflow') = {k+05};
Physical Surface('wallInvU') = {k+21, k+17, k+13};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40, j+10, j+30, j+20, j+36, j+16, j+33, j+13, j+26, j+43, j+23, j+46};
 j=200*t;
EndFor
