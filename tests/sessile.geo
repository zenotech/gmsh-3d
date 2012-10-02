
droplet = 0.1;
wall = 0.7;
wallLength = 4;
xc = 0.0;
yc = 0.0;
zc = 0.0;
r = 0.5;
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

Point(11) = { -wallLength, -wallLength, -0.3*wallLength, wall};
Point(12) = { wallLength, -wallLength, -0.3*wallLength, wall};
Point(13) = { -wallLength, wallLength, -0.3*wallLength, wall};
Point(14) = { wallLength, wallLength, -0.3*wallLength, wall};
Line(29) = {13, 11};
Line(30) = {11, 12};
Line(31) = {12, 14};
Line(32) = {14, 13};
Line Loop(33) = {30, 31, 32, 29};
Plane Surface(34) = {33};
Extrude {0, 0, 1.5*wallLength} {
  Surface{34};
}
Physical Surface('wallNoSlip') = {56, 55, 51, 47, 34, 43};
Physical Surface('bubble1') = {19, 28, 7, 10, 25, 22, 13, 16};
