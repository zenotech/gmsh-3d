
nb = 1;
b1 = 0.06;
wall = 0.4;

D = 1.0;
r = 0.5*D;
slug = 0.7*r;
pert = (0.0/100.0)*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0;
 yc = 0.0;
 zc = 1.0*D+(slug+r+r+r/2.0)*t;

 // include torus.geo file
 Include '../bubbleShape/sphere.geo';
EndFor

sideFactorX = 1.0;
sideFactorY = 1.0;

wallLength = 11*D;


/* 
 *              20         19
 *              o -------- o    Y           
 *              |          |    ^
 *              |          |    |
 *              |          |    |
 *              o -------- o     ------> X
 *              17         18
 *
 * */

k=10000;
Point(k+1) = {-4.0*D*sideFactorX, 
              -4.0*D*sideFactorY, 
              -8.0*D,
              wall}; // p1
Point(k+2) = {-4.0*D*sideFactorX,  
               4.0*D*sideFactorY, 
              -8.0*D,
              wall}; // p2
Point(k+3) = { 4.0*D*sideFactorX,  
               4.0*D*sideFactorY, 
              -8.0*D,
              wall}; // p3
Point(k+4) = { 4.0*D*sideFactorX, 
              -4.0*D*sideFactorY, 
              -8.0*D,
              wall}; // p4

Line(k+1) = {k+1, k+4};
Line(k+2) = {k+4, k+3};
Line(k+3) = {k+3, k+2};
Line(k+4) = {k+2, k+1};

Line Loop(k+05) = {k+04, k+01, k+02, k+03};
Plane Surface(k+06) = {k+05};
Extrude {0, 0, wallLength} {
  Line{k+04, k+03, k+02, k+01};
}

Line Loop(k+23) = {k+11, k+07, k+19, k+15};
Plane Surface(k+24) = {k+23};
Physical Surface('wallNoSlip') = {k+24, -(k+06), k+10, k+22, k+18, k+14};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+10, j+40, j+49, j+25, j+13, j+37, j+52, j+22, j+16, j+34, j+43, j+46, j+31, j+19, j+7, j+28};
 j=200*t;
EndFor

