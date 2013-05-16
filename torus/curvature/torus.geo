
nb = 1;
wall = 1.0;

wallLength = 6;
D = 1.0;
r = 0.5*D;
pert = (0.0/100.0)*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../../bubbleShape/torus.geo';
EndFor

j=200*0;
For t In {1:nb}
 Physical Surface('bubble1') = {j+20, j+12, j+8, j+40, j+48, j+44, j+28, j+24, j+36, j+32, j+16, j+52};
 j=200*t;
EndFor

//Transfinite Line {15, 47, 31} = 10/(b1/0.20) Using Progression 1;
//Transfinite Line {6, 22, 38, 27, 11, 43} = 16/(b1/0.20) Using Progression 1;
//Transfinite Line {23, 7, 39} = 20/(b1/0.20) Using Progression 1;
//Transfinite Line {5, 9, 13, 17, 4, 1, 3, 2, 29, 25, 21, 33} = 4/(b1/0.20) Using Progression 1;
