
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
 zc = -0.5;

 // include cylinder.geo file
 Include '../../bubbleShape/cylinder.geo';
EndFor

j=200*0;
For t In {1:nb}
 Physical Surface('bubble1') = {-(j+24), j+22, -(j+8), j+20, j+16, -(j+12)};
 j=200*t;
EndFor

//Transfinite Surface {22};
//Transfinite Surface {24};
//Transfinite Surface {20};
//Transfinite Surface {16};
//Transfinite Surface {12};
//Transfinite Surface {8};

