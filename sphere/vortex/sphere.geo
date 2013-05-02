
wall = 0.09;
droplet = 0.03;

wallLength = 1.0;
xc = 0.35;
yc = 0.35;
zc = 0.35;
r = 0.15;
pert = (0.0/100.0)*r;

Point(1) = {xc, yc, zc, droplet}; // center
Point(2) = {xc+r+pert, yc, zc, droplet}; // right
Point(3) = {xc-r-pert, yc, zc, droplet}; // left
Point(4) = {xc, yc, zc+r-pert, droplet}; // up
Point(5) = {xc, yc, zc-r+pert, droplet}; // down
Ellipse(1) = {4, 1, 1, 2};
Ellipse(2) = {2, 1, 1, 5};
Ellipse(3) = {3, 1, 1, 5};
Ellipse(4) = {4, 1, 1, 3};
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{1, 2, 3, 4};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{5, 14, 11, 8};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{17, 20, 23, 26};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{29, 32, 35, 38};
}

Point(27) = { 0.0, 0.0, 0.0, wall};
Point(28) = { wallLength, 0.0, 0.0, wall};
Point(29) = { 0.0, wallLength, 0.0, wall};
Point(30) = { wallLength, wallLength, 0.0, wall};
Line(53) = {27, 28};
Line(54) = {28, 30};
Line(55) = {30, 29};
Line(56) = {29, 27};
Line Loop(57) = {54, 55, 56, 53};
Plane Surface(58) = {57};
Extrude {0, 0, wallLength} {
  Surface{58};
}

Physical Surface('wallNoSlip') = {67, 71, 75, 80, 79, -58};
Physical Surface('bubble1') = {46, 34, 7, 22, 19, 16, 31, 43, 37, 25, 49, 10, 28, 13, 40, 52};
