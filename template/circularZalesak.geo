

Merge "../bubbleShape/zalesak.brep";

b1 = 0.1;
wall = 0.5;
wallLength = 6.0;
D = 3.0;
Characteristic Length {4, 1, 2, 3} = b1;

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
Point(k+1) = {        0.0,         0.0, -0.5*wallLength, wall}; // center
Point(k+2) = { D/1.0+pert,         0.0, -0.5*wallLength, wall}; // right
Point(k+3) = {-D/1.0-pert,         0.0, -0.5*wallLength, wall}; // left
Point(k+4) = {        0.0,  D/1.0-pert, -0.5*wallLength, wall}; // up
Point(k+5) = {        0.0, -D/1.0+pert, -0.5*wallLength, wall}; // down
Ellipse(k+1) = {k+4, k+1, k+1, k+2};
Ellipse(k+2) = {k+2, k+1, k+1, k+5};
Ellipse(k+3) = {k+5, k+1, k+1, k+3};
Ellipse(k+4) = {k+3, k+1, k+1, k+4};
Line Loop(k+5) = {k+1, k+2, k+3, k+4};

Extrude { 0, 0, wallLength} {
  Line{k+01, k+04, k+03, k+02};
}

Plane Surface(k+22) = {k+05};
Line Loop(k+23) = {k+06, k+18, k+14, k+10};
Plane Surface(k+24) = {k+23};
Physical Surface('wallNoSlip') = {k+09, k+13, k+17, k+21, -(k+22), k+24};

Physical Surface('bubble1') = {2, 1, 4, 3};
