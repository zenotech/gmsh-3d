
nb = 1;
wall = 1.0;

D = 4.0;
r = 0.5*D;
slug = 0.7*r;
pert = (0.0/100.0)*r;
wallLength = 6.0;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0;
 yc = 0.0;
 zc = 0.0+(slug+r+r+r/2.0)*t;

 // include torus.geo file
 Include '../../bubbleShape/sphere.geo';
EndFor

k=10000;
Point(k+1) = { -wallLength/2.0, -wallLength/2.0, -wallLength/2.0, wall};
Point(k+2) = {  wallLength/2.0, -wallLength/2.0, -wallLength/2.0, wall};
Point(k+3) = { -wallLength/2.0,  wallLength/2.0, -wallLength/2.0, wall};
Point(k+4) = {  wallLength/2.0,  wallLength/2.0, -wallLength/2.0, wall};
Line(k+1) = {k+1, k+2};
Line(k+2) = {k+2, k+4};
Line(k+3) = {k+4, k+3};
Line(k+4) = {k+3, k+1};

Line Loop(k+5) = {k+3, k+4, k+1, k+2};
Plane Surface(k+6) = {k+5};
Extrude {0, 0, wallLength} {
  Surface{k+6};
}

Physical Surface('wallNoSlip') = {k+28, k+27, k+15, -(k+6), k+19, k+23};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+10, j+40, j+49, j+25, j+13, j+37, j+52, j+22, j+16, j+34, j+43, j+46, j+31, j+19, j+7, j+28};
 j=200*t;

EndFor

 Transfinite Surface {34};
 Transfinite Surface {46};
 Transfinite Surface {7};
 Transfinite Surface {19};
 Transfinite Surface {31};
 Transfinite Surface {43};
 Transfinite Surface {16};
 Transfinite Surface {22};
 Transfinite Surface {37};
 Transfinite Surface {49};
 Transfinite Surface {10};
 Transfinite Surface {28};
 Transfinite Surface {40};
 Transfinite Surface {52};
 Transfinite Surface {13};
 Transfinite Surface {25};

