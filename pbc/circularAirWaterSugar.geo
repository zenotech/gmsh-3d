

nb = 1;
b1 = 0.06;
wall = 0.8;
wallhd = 0.1;

D = 1.0;
r = 0.5*D;
slug = 0.7*r;
pert = (0.0/100.0)*D/2.0;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0 + 1.0*D +(slug+r+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 //Include '../bubble-shapes/rabello-sphere.geo';
 Include '/Users/gustavo/projects/db/gmsh/3d/bubbleShape/sphere.geo';
EndFor

wallLength = D+D;

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

k=10000;
Point(k+1) = { 0.0*D,  1.5*D-pert,  0.0, wallhd}; // up
Point(k+2) = { 0.0*D,  5.0*D-pert,  0.0, wall}; // up

Point(k+3) = { wallLength*D,         0.0,  0.0, wall}; // center
Point(k+4) = { wallLength*D,  1.5*D-pert,  0.0, wallhd}; // up
Point(k+5) = { wallLength*D,  5.0*D-pert,  0.0, wall}; // up
Line(k+29) = {k+02, k+05};
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+29};
}
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+30};
}
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+34};
}
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+38};
}
Point(k+16) = { 0.0*D,  1.5*D-pert,  0.0, wallhd}; // up
Point(k+17) = { 0.0*D,         0.0,  1.5*D+pert, wallhd}; // right
Point(k+18) = { 0.0*D,         0.0, -D*1.5-pert, wallhd}; // left
Point(k+19) = { 0.0*D, -D*1.5+pert,         0.0, wallhd}; // down

Point(k+20) = { wallLength*D,  1.5*D-pert,  0.0, wallhd}; // up
Point(k+21) = { wallLength*D,         0.0,  1.5*D+pert, wallhd}; // right
Point(k+22) = { wallLength*D,         0.0, -D*1.5-pert, wallhd}; // left
Point(k+23) = { wallLength*D, -D*1.5+pert,         0.0, wallhd}; // down

Ellipse(k+46) = {k+01, k+11, k+11, k+17};
Ellipse(k+47) = {k+17, k+11, k+11, k+19};
Ellipse(k+48) = {k+19, k+11, k+11, k+18};
Ellipse(k+49) = {k+18, k+11, k+11, k+01};
Ellipse(k+50) = {k+04, k+03, k+03, k+21};
Ellipse(k+51) = {k+21, k+03, k+03, k+23};
Ellipse(k+52) = {k+23, k+03, k+03, k+22};
Ellipse(k+53) = {k+22, k+03, k+03, k+04};
Line Loop(k+54) = {k+43, k+31, k+35, k+39};
Line Loop(k+55) = {k+49, k+46, k+47, k+48};
Plane Surface(k+56) = {k+54, k+55};
Plane Surface(k+57) = {-(k+55)};
Line Loop(k+58) = {k+44, k+32, k+36, k+40};
Line Loop(k+59) = {k+52, k+53, k+50, k+51};
Plane Surface(k+60) = {-(k+58), -(k+59)};
Plane Surface(k+61) = {k+59};

// PERIODIC MESHING
// For periodic surfaces, the line tangents of the two periodic planes
// (slave and master) must have the same orientation.
Periodic Surface k+57 {k+49,k+46,k+47,k+48} = k+61 {k+53,k+50,k+51,k+52};
Periodic Surface k+56 {k+43,k+39,k+35,k+31,k+46,k+47,k+48,k+49} = k+60 {k+44,k+40,k+36,k+32,k+50,k+51,k+52,k+53};

// For correct orientation, the normal vectors must be pointed outward.
Physical Surface('wallLeft') = {k+56, k+57};
Physical Surface('wallRight') = {k+61, k+60};
Physical Surface('wallInflowZeroU') = {k+45, k+41, k+37, k+33};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+10, j+40, j+49, j+25, j+13, j+37, j+52, j+22, j+16, j+34, j+43, j+46, j+31, j+19, j+7, j+28};
 j=200*t;
EndFor
