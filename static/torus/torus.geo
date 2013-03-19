
droplet = 0.2;
wall = 1.0;
wallLength = 6;
r = 0.5;
xc = 0.0+3*r;
yc = 0.0;
zc = 0.0;
pert = (0.0/100.0)*r;

Point(1) = {xc, yc, zc, droplet}; // center
Point(2) = {xc+r+pert, yc, zc, droplet}; // right
Point(3) = {xc-r-pert, yc, zc, droplet}; // left
Point(4) = {xc, yc, zc+r-pert, droplet}; // up
Point(5) = {xc, yc, zc-r+pert, droplet}; // down
Ellipse(1) = {4, 1, 1, 2};
Ellipse(2) = {2, 1, 1, 5};
Ellipse(3) = {5, 1, 1, 3};
Ellipse(4) = {3, 1, 1, 4};

Extrude {{0, 0, 1}, {0, 0, 0}, 2*Pi/3} {
  Line{1, 2, 3, 4};
}
Extrude {{0, 0, 1}, {0, 0, 0}, 2*Pi/3} {
  Line{5, 9, 13, 17};
}
Extrude {{0, 0, 1}, {0, 0, 0}, 2*Pi/3} {
  Line{21, 25, 29, 33};
}

Point(42) = { -3, -3, -2, wall};
Point(43) = { 3, -3, -2, wall};
Point(44) = { -3, 3, -2, wall};
Point(45) = { 3, 3, -2, wall};

Line(53) = {45, 44};
Line(54) = {44, 42};
Line(55) = {42, 43};
Line(56) = {43, 45};

Line Loop(57) = {55, 56, 53, 54};
Plane Surface(58) = {57};
Extrude {0, 0, 4} {
  Surface{58};
}
Physical Surface('wall') = {80, 71, 67, 79, 75, 58};
Physical Surface('bubble') = {20, 12, 8, 40, 48, 44, 28, 24, 36, 32, 16, 52};
