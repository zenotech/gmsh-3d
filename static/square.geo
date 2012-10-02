
nb = 1;
wall = 0.9;

D = 1.0;
r = 0.5*D;
pert = (0.0/100.0)*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../bubbleShape/sphere.geo';
EndFor

sideFactorY = 1.0;
sideFactorZ = 1.0;

wallLength = 2*D;

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
Point(k+1) = { -wallLength, -wallLength, -wallLength, wall};
Point(k+2) = { wallLength, -wallLength, -wallLength, wall};
Point(k+3) = { -wallLength, wallLength, -wallLength, wall};
Point(k+4) = { wallLength, wallLength, -wallLength, wall};
Line(k+1) = {k+1, k+2};
Line(k+2) = {k+2, k+4};
Line(k+3) = {k+4, k+3};
Line(k+4) = {k+3, k+1};
Line Loop(k+5) = {k+2, k+3, k+4, k+1};
Plane Surface(k+6) = {k+5};
Extrude {0, 0, 2*wallLength} {
  Surface{k+6};
}

Physical Surface('wallNoSlip') = {-(k+06), k+28, k+19, k+27, k+23, k+15};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+10, j+40, j+49, j+25, j+13, j+37, j+52, j+22, j+16, j+34, j+43, j+46, j+31, j+19, j+7, j+28};
 j=200*t;
EndFor
