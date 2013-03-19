
wall = 0.3;
wallLength = 2;
xc = 0.0;
yc = 0.0;
zc = 0.0;
r = 0.5;
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
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/4} {
  Line{1, 2, 3, 4};
}
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/4} {
  Line{5, 14, 11, 8};
}
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/4} {
  Line{17, 20, 23, 26};
}
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/4} {
  Line{29, 32, 35, 38};
}

Point(27) = { -wallLength, -wallLength, -wallLength, wall};
Point(28) = { wallLength, -wallLength, -wallLength, wall};
Point(29) = { -wallLength, wallLength, -wallLength, wall};
Point(30) = { wallLength, wallLength, -wallLength, wall};
Line(53) = {27, 28};
Line(54) = {28, 30};
Line(55) = {30, 29};
Line(56) = {29, 27};
Line Loop(57) = {54, 55, 56, 53};
Plane Surface(58) = {57};
Extrude {0, 0, 2*wallLength} {
  Surface{58};
}
Physical Surface('wallNoSlip') = {67, 71, 75, 80, 79, 58};
Physical Surface('bubble1') = {46, 34, 7, 22, 19, 16, 31, 43, 37, 25, 49, 10, 28, 13, 40, 52};
