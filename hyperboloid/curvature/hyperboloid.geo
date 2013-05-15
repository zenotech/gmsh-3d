
nb = 1;
wall = 1.0;

wallLength = 2;
D = 1.0;
r = 0.5*D;
pert = (0.0/100.0)*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../../bubbleShape/hyperboloid.geo';
EndFor

j=200*0;
For t In {1:nb}
 Physical Surface('bubble1') = {j+30, j+6, j+14, j+22, j+34, j+10, j+18,
                                j+26, -(j+38), j+36};
 j=200*t;
EndFor

