

nb = 2;
b1 = 0.08;
wall = 0.9;

D = 1.0;
r = 0.40*D;
slug = 0.7*r;
pert = (0.0/100.0)*r;

ycPlus = 0.0;
For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0;
 yc = -0.75+ycPlus;
 zc = 0.0;

 // include torus.geo file
 Include '../bubbleShape/sphere.geo';
 ycPlus=1.5;
EndFor

sideFactorY = 1.0;
sideFactorZ = 1.0;

wallLength = 6*D;


/* 
 *              20         19
 *              o -------- o    Z           
 *              |          |    ^
 *              |          |    |
 *              |          |    |
 *              o -------- o     ------> Y
 *              17         18
 *
 * */

k=10000;
Point(k+1) = {-wallLength/1.0, 
               wallLength/2.0, 
              -wallLength/2.0, 
              wall}; // p1
Point(k+2) = { wallLength/1.0,
               wallLength/2.0,
              -wallLength/2.0,
              wall}; // p2
Point(k+3) = { wallLength/1.0,
              -wallLength/2.0, 
              -wallLength/2.0,
              wall}; // p3
Point(k+4) = {-wallLength/1.0,
              -wallLength/2.0,
              -wallLength/2.0, 
              wall}; // p4

Line(k+1) = {k+4, k+3};
Line(k+2) = {k+3, k+2};
Line(k+3) = {k+2, k+1};
Line(k+4) = {k+1, k+4};

Line Loop(k+05) = {k+03, k+04, k+01, k+02};
Plane Surface(k+06) = {k+05};
Extrude {0, 0, wallLength} {
  Surface{k+06};
}

Physical Surface('wallInflow2Bubbles') = {k+15, k+23};
Physical Surface('wallNormalW') = {k+28, k+06};
Physical Surface('wallOutflow') = {k+19, k+27};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+10, j+40, j+49, j+25, j+13, j+37, j+52, j+22, j+16, j+34, j+43, j+46, j+31, j+19, j+7, j+28};
 j=200*t;
EndFor


