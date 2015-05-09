
b1=0.1;
wall=0.1;
wallLength = 4.0;
xc = 0.0;
yc = 0.0;
zc = 0.0;
r = 0.5;
pert = (0.0/100.0)*r;

// center 1
Point(1) = {0, 0, 0, b1}; // center

// center 2
Point(10) = {0, 0, 0+wallLength, b1}; // center

// inner 1
Point(2) = {xc+r+pert, yc, zc, b1}; // right
Point(3) = {xc-r-pert, yc, zc, b1}; // left
Point(4) = {xc, yc+r-pert, zc, b1}; // up
Point(5) = {xc, yc-r+pert, zc, b1}; // down
Ellipse(1) = {2, 1, 1, 4};
Ellipse(2) = {5, 1, 1, 2};
Ellipse(3) = {3, 1, 1, 5};
Ellipse(4) = {4, 1, 1, 3};

// inner 2
Point(11) = {xc+r+pert, yc, zc+wallLength, b1}; // right
Point(12) = {xc-r-pert, yc, zc+wallLength, b1}; // left
Point(13) = {xc, yc+r-pert, zc+wallLength, b1}; // up
Point(14) = {xc, yc-r+pert, zc+wallLength, b1}; // down
Ellipse(9) = {13, 10, 10, 12};
Ellipse(10) = {12, 10, 10, 14};
Ellipse(11) = {14, 10, 10, 11};
Ellipse(12) = {11, 10, 10, 13};

xc = 0.0;
yc = 0.0;
zc = 0.0;
r = 1.0;
pert = (0.0/100.0)*r;

// outer 1
Point(6) = {xc+r+pert, yc, zc, wall}; // right
Point(7) = {xc-r-pert, yc, zc, wall}; // left
Point(8) = {xc, yc+r-pert, zc, wall}; // up
Point(9) = {xc, yc-r+pert, zc, wall}; // down
Ellipse(5) = {8, 1, 1, 7};
Ellipse(6) = {7, 1, 1, 9};
Ellipse(7) = {9, 1, 1, 6};
Ellipse(8) = {6, 1, 1, 8};

// outer 2
xc = 0.0;
yc = 0.0;
zc = 0.0;
r = 1.0;
pert = (0.0/100.0)*r;
Point(15) = {xc+r+pert, yc, zc+wallLength, wall}; // right
Point(16) = {xc-r-pert, yc, zc+wallLength, wall}; // left
Point(17) = {xc, yc+r-pert, zc+wallLength, wall}; // up
Point(18) = {xc, yc-r+pert, zc+wallLength, wall}; // down
Ellipse(13) = {17, 10, 10, 16};
Ellipse(14) = {16, 10, 10, 18};
Ellipse(15) = {18, 10, 10, 15};
Ellipse(16) = {15, 10, 10, 17};

Line(17) = {17, 8};
Line(18) = {15, 6};
Line(19) = {18, 9};
Line(20) = {16, 7};
Line(21) = {13, 4};
Line(22) = {11, 2};
Line(23) = {14, 5};
Line(24) = {12, 3};

Line Loop(25) = {5, -20, -13, 17};
Ruled Surface(26) = {25};
Line Loop(27) = {17, -8, -18, 16};
Ruled Surface(28) = {-27};
Line Loop(29) = {18, -7, -19, 15};
Ruled Surface(30) = {-29};
Line Loop(31) = {19, -6, -20, 14};
Ruled Surface(32) = {-31};
Line Loop(33) = {21, -1, -22, 12};
Ruled Surface(34) = {-33};
Line Loop(35) = {22, -2, -23, 11};
Ruled Surface(36) = {-35};
Line Loop(37) = {10, 23, -3, -24};
Ruled Surface(38) = {-37};
Line Loop(39) = {4, -24, -9, 21};
Ruled Surface(40) = {39};
Line Loop(41) = {12, 9, 10, 11};
Plane Surface(42) = {41};
Line Loop(43) = {16, 13, 14, 15};
Plane Surface(44) = {-41, -43};
Line Loop(45) = {8, 5, 6, 7};
Line Loop(46) = {1, 4, 3, 2};
Plane Surface(47) = {-46};
Plane Surface(48) = {-45, -46};

// PERIODIC MESHING
// For periodic surfaces, the line tangents of the two periodic planes
// (slave and master) must have the same orientation.
Periodic Surface 42 {12,11,10,9} = 47 {1,2,3,4};
Periodic Surface 44 {16,15,14,13,12,11,10,9} = 48 {8,7,6,5,1,2,3,4};

// For correct orientation, the normal vectors must be pointed outward.
Physical Surface('wallNoSlip') = {26, 28, 30, 32};
Physical Surface('wallLeft') = {48, 47};
Physical Surface('wallRight') = {44, 42};
Physical Surface('bubble1') = {34, 36, 38, 40};

