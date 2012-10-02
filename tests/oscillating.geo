// Gmsh project created on Mon Oct  5 20:56:07 2009

// refinamento
droplet = 0.1;
wall = 0.5;
wallLength = 4.0;
radius = 0.5;
xCenter = 0.0;
yCenter = 0.0;
zCenter = 0.0;
pert = (2.5/100.0)*radius;

// center
Point(1)  = {xCenter, yCenter, zCenter, droplet}; // center

// plane XY
Point(2) = {xCenter, yCenter+radius-pert, zCenter, droplet}; // up
Point(3) = {xCenter+radius+pert, yCenter, zCenter, droplet}; // right
Point(4) = {xCenter, yCenter-radius+pert, zCenter, droplet}; //down


Ellipse(1) = {2, 1, 4, 3};
Ellipse(2) = {4, 1, 2, 3};
Line(3) = {4, 1};
Line(4) = {2, 1};
Line Loop(5) = {1, -2, 3, -4};
Plane Surface(6) = {5};
Extrude {{0, 1, 0}, {xCenter, yCenter, zCenter}, Pi/2} {
  Surface{6};
}
Extrude {{0, 1, 0}, {xCenter, yCenter, zCenter}, Pi/2} {
  Surface{20};
}
Extrude {{0, 1, 0}, {xCenter, yCenter, zCenter}, Pi/2} {
  Surface{34};
}
Extrude {{0, 1, 0}, {xCenter, yCenter, zCenter}, Pi/2} {
  Surface{48};
}

// wall
Point(17) = {-2, -2, -2, wall};
Point(18) = { 2, -2, -2, wall};
Point(19) = { 2,  2, -2, wall};
Point(20) = {-2,  2, -2, wall};
Line(60) = {17, 18};
Line(61) = {18, 19};
Line(62) = {19, 20};
Line(63) = {20, 17};
Line Loop(64) = {61, 62, 63, 60};
Plane Surface(65) = {64};
Extrude {0, 0, wallLength} {
  Surface{65};
}
Physical Surface('wallNoSlip') = {65, 74, 87, 86, 82, 78};
Physical Surface('bubble1') = {17, 31, 14, 56, 28, 42, 59, 45};
