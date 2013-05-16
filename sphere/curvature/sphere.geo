
nb = 1;
wall = 1.0;

D = 1.0;
r = 0.5*D;
slug = 0.7*r;
pert = (0.0/100.0)*r;
wallLength = 6.0;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../../bubbleShape/sphere.geo';
EndFor

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+22, j+7, j+19, j+16, j+25, j+10, j+28, j+13};
 j=200*t;

EndFor

Transfinite Surface {22};
Transfinite Surface {7};
Transfinite Surface {19};
Transfinite Surface {16};
Transfinite Surface {25};
Transfinite Surface {10};
Transfinite Surface {28};
Transfinite Surface {13};


