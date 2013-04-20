
droplet = 0.1;
wall = 0.7;
wr = droplet; // wall refined
xc = 0.0;
yc = 0.0;
zc = 0.0;
D = 1.0;
r = D/2.0;
pertz = (0.0/100.0)*r;
pertxy = r - Sqrt( (r*r*r)/(r+pertz) );

Point(1) = {xc, yc, zc, droplet}; // center
Point(2) = {xc+r-pertxy, yc, zc, droplet}; // right
Point(3) = {xc-r+pertxy, yc, zc, droplet}; // left
Point(4) = {xc, yc, zc+r+pertz, droplet}; // up
Point(5) = {xc, yc, zc-r-pertz, droplet}; // down
Ellipse(1) = {4, 1, 1, 2};
Ellipse(2) = {2, 1, 1, 5};
Ellipse(3) = {3, 1, 1, 5};
Ellipse(4) = {4, 1, 1, 3};

Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/2} {
  Line{1, 2, 3, 4};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/2} {
  Line{5, 14, 11, 8};
}

Point(11) = {-4*D,-4*D, -0.3*4*D, wall};
Point(12) = { 4*D,-4*D, -0.3*4*D, wall};
Point(13) = {-4*D, 4*D, -0.3*4*D, wall};
Point(14) = { 4*D, 4*D, -0.3*4*D, wall};
Line(29) = {13, 11};
Line(30) = {11, 12};
Line(31) = {12, 14};
Line(32) = {14, 13};
Line Loop(33) = {30, 31, 32, 29};

// refined zone
Point(15) = {-4*D/4.0,-4*D/4.0, -0.3*4*D,wr};
Point(16) = { 4*D/4.0,-4*D/4.0, -0.3*4*D,wr};
Point(17) = {-4*D/4.0, 4*D/4.0, -0.3*4*D,wr};
Point(18) = { 4*D/4.0, 4*D/4.0, -0.3*4*D,wr};
Line(34) = {15, 16};
Line(35) = {16, 18};
Line(36) = {18, 17};
Line(37) = {17, 15};
Line Loop(38) = {36, 37, 34, 35};
Plane Surface(39) = {38};
Plane Surface(40) = {33, 38};
Extrude {0, 0, 1.5*(4*D)} {
  Line{30, 31, 32, 29};
}
Line Loop(57) = {41, 45, 49, 53};
Plane Surface(58) = {57};

Physical Surface('wallNoSlip') = {-39, -40, 48, 56, 44, 52, 58};
Physical Surface('bubble1') = {19, 28, 7, 10, 25, 22, 13, 16};
