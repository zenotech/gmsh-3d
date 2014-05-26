

nb = 1;
b1 = 0.08;
wall = 0.08;

D = 1.0;
r = 0.35*D;
body = 1.5*D;
slug = 0.7*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../bubbleShape/taylor.geo';
EndFor

wallLength = D+nb*(body+3*r/2.0)+(nb-1)*slug+5*D;

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
Point(k+1) = {-1.5*D,         0.0,         0.0, wall}; // center
Point(k+2) = {-1.5*D,         0.0,  D/2.0+pert, wall}; // right
Point(k+3) = {-1.5*D,         0.0, -D/2.0-pert, wall}; // left
Point(k+4) = {-1.5*D,  D/2.0-pert,         0.0, wall}; // up
Point(k+5) = {-1.5*D, -D/2.0+pert,         0.0, wall}; // down
Ellipse(k+1) = {k+4, k+1, k+1, k+2};
Ellipse(k+2) = {k+2, k+1, k+1, k+5};
Ellipse(k+3) = {k+5, k+1, k+1, k+3};
Ellipse(k+4) = {k+3, k+1, k+1, k+4};
Line Loop(k+5) = {k+1, k+2, k+3, k+4};
Plane Surface(k+6) = {k+5};
Extrude {wallLength, 0, 0} {
  Surface{k+6};
}
Physical Surface('wallNoSlip') = {k+28,-(k+6),k+27, k+23, k+19, k+15};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40,-(j+10), -(j+30), j+20,
 j+36, j+16, -(j+33), -(j+13), -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor
