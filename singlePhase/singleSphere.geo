// Gmsh project created on Mon Oct  5 20:56:07 2009

// refinamento
sphere = 0.09;
wall = 0.8;
D = 1.0;
r = D/2.0;
wallLength = 25*D;
xCenter = 5.0*D;
yCenter = 5.0*D;
zCenter = 5.0*D;

// SPHERE
Point(1) = {xCenter,yCenter,zCenter,sphere};
Point(2) = {xCenter+r,yCenter,zCenter,sphere};
Point(3) = {xCenter,yCenter+r,zCenter,sphere};
Point(4) = {xCenter-r,yCenter,zCenter,sphere};
Point(5) = {xCenter,yCenter-r,zCenter,sphere};
Point(6) = {xCenter,yCenter,zCenter-r,sphere};
Point(7) = {xCenter,yCenter,zCenter+r,sphere};
Circle(1) = {2,1,3};
Circle(2) = {3,1,4};
Circle(3) = {4,1,5};
Circle(4) = {5,1,2};
Circle(5) = {3,1,6};
Circle(6) = {6,1,5};
Circle(7) = {5,1,7};
Circle(8) = {7,1,3};
Circle(9) = {2,1,7};
Circle(10) = {7,1,4};
Circle(11) = {4,1,6};
Circle(12) = {6,1,2};
Line Loop(13) = {2,8,-10};
Ruled Surface(14) = {13};
Line Loop(15) = {10,3,7};
Ruled Surface(16) = {15};
Line Loop(17) = {-8,-9,1};
Ruled Surface(18) = {17};
Line Loop(19) = {-11,-2,5};
Ruled Surface(20) = {19};
Line Loop(21) = {-5,-12,-1};
Ruled Surface(22) = {21};
Line Loop(23) = {-3,11,6};
Ruled Surface(24) = {23};
Line Loop(25) = {-7,4,9};
Ruled Surface(26) = {25};
Line Loop(27) = {-4,12,-6};
Ruled Surface(28) = {27};
Surface Loop(29) = {28,26,16,14,20,24,22,18};

Point(8) = {0, 0, 0,wall};
Point(9) = {10*D, 0, 0,wall};
Point(10) = {10*D, 10*D, 0,wall};
Point(11) = {0, 10*D, 0,wall};
Line(30) = {8, 9};
Line(31) = {9, 10};
Line(32) = {10, 11};
Line(33) = {11, 8};
Line Loop(34) = {32, 33, 30, 31};
Plane Surface(35) = {34};
Extrude {0, 0, wallLength} {
  Surface{35};
}
Physical Surface('wallInflowW') = {-35};
Physical Surface('wallOutflow') = {57};
Physical Surface('wallNoSlip') = {48, 56, 52, 44};
Physical Surface('wallNoSlipConcentration') = {-20, -28, -24, -16, -26, -14, -18, -22};
