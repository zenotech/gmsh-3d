

nb = 1;
b1 = 0.05;
wall = 0.2;

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
 Include '../../bubbleShape/taylor.geo';
EndFor

wallLength1 = 3.5*D;
wallLength2 = nb*(body+3*r/2.0)+(nb-1)*slug;
wallLength3 = 2.0*D;

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
Point(k+1) = {0.0*D,         0.0,         0.0, wall}; // center
Point(k+2) = {0.0*D,         0.0,  D/2.0+pert, wall}; // right
Point(k+3) = {0.0*D,         0.0, -D/2.0-pert, wall}; // left
Point(k+4) = {0.0*D,  D/2.0-pert,         0.0, wall}; // up
Point(k+5) = {0.0*D, -D/2.0+pert,         0.0, wall}; // down
Ellipse(k+1) = {k+4, k+1, k+1, k+2};
Ellipse(k+2) = {k+2, k+1, k+1, k+5};
Ellipse(k+3) = {k+5, k+1, k+1, k+3};
Ellipse(k+4) = {k+3, k+1, k+1, k+4};
Line Loop(k+5) = {k+1, k+2, k+3, k+4};

Extrude {wallLength2, 0, 0} {
  Line{k+01, k+04, k+02, k+03};
}
Extrude {wallLength3, 0, 0} {
  Line{k+10, k+06, k+14, k+18};
}
Extrude {-wallLength1, 0, 0} {
  Line{k+01, k+04, k+03, k+02};
}

Line Loop(k+54) = {k+42, k+38, k+50, k+46};
Plane Surface(k+55) = {k+54};
Line Loop(k+56) = {k+26, k+30, k+34, k+22};
Plane Surface(k+57) = {k+56};

Physical Surface('wallInflowZeroU') = {-(k+41), -(k+45), -(k+49), -(k+53), k+13,
k+09, k+17, k+21, k+29, k+25, k+37, k+33, k+57, -(k+55)};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40, -(j+10), -(j+30), j+20,
 j+36, j+16, -(j+33), -(j+13), -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

Transfinite Line {k+07, k+11, k+16, k+08} = 5*wallLength2/wall Using Progression 1;
Transfinite Line {k+01, k+04, k+03, k+02, k+18, k+14, k+06, k+10} = 3*D/wall Using Progression 1;
