
b1=0.1;
wall=0.1;
wallLength = 8.0;
xc = 0.0;
yc = 0.0;
zc = 0.0;
r = 0.5;
pert = (0.0/100.0)*r;

// center
Point(1) = {0, 0, 0, b1}; // center

// inner
Point(2) = {xc+r+pert, yc, zc, b1}; // right
Point(3) = {xc-r-pert, yc, zc, b1}; // left
Point(4) = {xc, yc+r-pert, zc, b1}; // up
Point(5) = {xc, yc-r+pert, zc, b1}; // down
Ellipse(1) = {4, 1, 1, 2};
Ellipse(2) = {2, 1, 1, 5};
Ellipse(3) = {3, 1, 1, 5};
Ellipse(4) = {4, 1, 1, 3};

// outer
xc = 0.0;
yc = 0.0;
zc = 0.0;
r = 1.0;
pert = (0.0/100.0)*r;
Point(6) = {xc+r+pert, yc, zc, wall}; // right
Point(7) = {xc-r-pert, yc, zc, wall}; // left
Point(8) = {xc, yc+r-pert, zc, wall}; // up
Point(9) = {xc, yc-r+pert, zc, wall}; // down

Ellipse(5) = {8, 1, 1, 6};
Ellipse(6) = {6, 1, 1, 9};
Ellipse(7) = {9, 1, 1, 7};
Ellipse(8) = {7, 1, 1, 8};
Line Loop(9) = {1, 2, -3, -4};
Plane Surface(10) = {9};
Line Loop(11) = {5, 6, 7, 8};
Plane Surface(12) = {9, 11};
Extrude {0, 0, wallLength} {
  Surface{10, 12};
}
Physical Surface('wall') = {75, 63, 67, 71, 76, 12, 34, 10};
Physical Surface('bubble') = {33, 29, 25, 21};
