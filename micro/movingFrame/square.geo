

nb = 1;
b1 = 0.06;
wall = 0.2;

D = 1.0;
r = 0.4*D;
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

sideFactorY = 1.0;
sideFactorZ = 1.0;

wallLength1 = 2.5*D;
wallLength2 = nb*(body+3*r/2.0)+(nb-1)*slug;
wallLength3 = 1.5*D;


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
Point(k+1) = {-wallLength1, 
              -(D/2.0)*sideFactorY, 
              -(D/2.0)*sideFactorZ, 
              wall}; // p1
Point(k+2) = {-wallLength1, 
              -(D/2.0)*sideFactorY,  
              (D/2.0)*sideFactorZ, 
              wall}; // p2
Point(k+3) = {-wallLength1,  
              (D/2.0)*sideFactorY,  
              (D/2.0)*sideFactorZ, 
              wall}; // p3
Point(k+4) = {-wallLength1,  
              (D/2.0)*sideFactorY, 
              -(D/2.0)*sideFactorZ, 
              wall}; // p4

Line(k+1) = {k+1, k+4};
Line(k+2) = {k+4, k+3};
Line(k+3) = {k+3, k+2};
Line(k+4) = {k+2, k+1};

Line Loop(k+05) = {k+04, k+01, k+02, k+03};
Plane Surface(k+06) = {k+05};
Extrude {wallLength1, 0, 0} {
  Line{k+04, k+03, k+02, k+01};
}
Extrude {wallLength2, 0, 0} {
  Line{k+11, k+15, k+19, k+07};
}
Extrude {wallLength3, 0, 0} {
  Line{k+23, k+27, k+31, k+35};
}
Line Loop(k+55) = {k+51, k+47, k+43, k+39};
Plane Surface(k+56) = {k+55};

Physical Surface('wallInflowUParabolic') = {-(k+06), k+56};
Physical Surface('wallNoSlipPressure') = {k+50, k+34, k+22, k+18, 
                                          k+14, k+10, k+30, k+26, 
                                          k+38, k+54, k+42, k+46};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40,-(j+10), -(j+30), j+20,
                                            j+36, j+16, -(j+33), -(j+13), 
                                            -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

Transfinite Line {k+32, k+25, k+24, k+28} = 60 Using Progression 1;
Transfinite Line {k+23, k+27, k+31, k+35, 
                  k+07, k+11, k+15, k+19} = 10 Using Progression 1;

