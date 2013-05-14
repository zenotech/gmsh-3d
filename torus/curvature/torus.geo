
nb = 1;
wall = 1.0;

wallLength = 6;
D = 1.0;
r = 0.5*D;
pert = (0.0/100.0)*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+3*r;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../../bubbleShape/torus.geo';
EndFor

k=10000;
Point(k+1) = { -wallLength/2.0, -wallLength/2.0, -wallLength/4.0, wall};
Point(k+2) = {  wallLength/2.0, -wallLength/2.0, -wallLength/4.0, wall};
Point(k+3) = { -wallLength/2.0,  wallLength/2.0, -wallLength/4.0, wall};
Point(k+4) = {  wallLength/2.0,  wallLength/2.0, -wallLength/4.0, wall};
Line(k+1) = {k+1, k+2};
Line(k+2) = {k+2, k+4};
Line(k+3) = {k+4, k+3};
Line(k+4) = {k+3, k+1};

Line Loop(k+5) = {k+3, k+4, k+1, k+2};
Plane Surface(k+6) = {k+5};
Extrude {0, 0, wallLength/2.0} {
  Surface{k+6};
}

Physical Surface('wallNoSlip') = {k+28, k+27, k+15, -(k+6), k+19, k+23};

j=200*0;
For t In {1:nb}
 Physical Surface('bubble1') = {j+20, j+12, j+8, j+40, j+48, j+44, j+28, j+24, j+36, j+32, j+16, j+52};
 j=200*t;
EndFor

