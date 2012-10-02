

nb = 2;
b1 = 0.06;
wall = 0.2;

D = 1.0;
r = 0.5*D;
slug = 0.7*r;
pert = (0.0/100.0)*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+(slug+r+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../bubbles/sphere.geo';
EndFor

wallLength = 10.0*D;

/*
 *              6           2
 *              o --------- o 
 *
 *
 *
 *              o --------- o 
 *              5           3
 *
 * */

pert = (0.0/100.0)*D/2.0;

k=10000;
Point(k+1) = {-3.0*D,         0.0,         0.0, wall}; // center
Point(k+2) = {-3.0*D,         0.0,  D/1.0+pert, wall}; // right
Point(k+3) = {-3.0*D,         0.0, -D/1.0-pert, wall}; // left
Point(k+4) = {-3.0*D,  D/1.0-pert,         0.0, wall}; // up
Point(k+5) = {-3.0*D, -D/1.0+pert,         0.0, wall}; // down
Ellipse(k+1) = {k+4, k+1, k+1, k+2};
Ellipse(k+2) = {k+2, k+1, k+1, k+5};
Ellipse(k+3) = {k+5, k+1, k+1, k+3};
Ellipse(k+4) = {k+3, k+1, k+1, k+4};
Line Loop(k+5) = {k+1, k+2, k+3, k+4};

Extrude {wallLength, 0, 0} {
  Line{k+01, k+04, k+03, k+02};
}

Plane Surface(k+22) = {k+05};
Line Loop(k+23) = {k+06, k+18, k+14, k+10};
Plane Surface(k+24) = {k+23};
Physical Surface('wallNoSlip') = {k+09, k+13, k+17, k+21, -(k+22), k+24};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+10, j+40, j+49, j+25, j+13, j+37, j+52, j+22, j+16, j+34, j+43, j+46, j+31, j+19, j+7, j+28};
 j=200*t;
EndFor
