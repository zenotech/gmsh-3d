
droplet = 0.05;
wall = 0.9;
wallLength = 4;
wallHeight=2.5*wallLength;
r = 0.5;
xc = 0.0;
yc = 0.0;
zc = 7*r;
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

Point(11) = { -wallLength, -wallLength, -wallLength, wall};
Point(12) = { wallLength, -wallLength, -wallLength, wall};
Point(13) = { -wallLength, wallLength, -wallLength, wall};
Point(14) = { wallLength, wallLength, -wallLength, wall};
Line(29) = {11, 12};
Line(30) = {12, 14};
Line(31) = {14, 13};
Line(32) = {13, 11};
Line Loop(33) = {30, 31, 32, 29};
Plane Surface(34) = {33};
Extrude {0, 0, wallHeight} {
  Surface{34};
}
Physical Surface('wallNoSlip') = {34, 51, 47, 56, 43, 55};
Physical Surface('bubble1') = {13, 25, 28, 19, 7, 16, 22, 10};
