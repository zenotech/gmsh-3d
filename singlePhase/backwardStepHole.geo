
wall = 0.1;
bubble = 0.05;

L = 1.0;


/* 
 *              5         L+9L                4
 *         o -------------------------------- o         
 *         |                                  |       
 *    L    |                       _    _     |       
 *         |                      / \    | L  |       Y         
 *         o ---------- o         \_/   _|    | 2L    ^
 *         0          1 |                     |       |
 *              2*L     |                     |       |
 *         x(0,0)       o ------------------- o       o -----> X
 *                      2          9L         3
 * */

xCenter=1*L+9*L/3.0;
yCenter=L;
radius=0.5;
pert=(0.0/100)*radius;
Point(1) = {xCenter, yCenter, 0,bubble}; // center
Point(2) = {xCenter, yCenter+radius-pert, 0,bubble}; // up
Point(3) = {xCenter, yCenter-radius+pert, 0,bubble}; // down
Point(4) = {xCenter-radius-pert, yCenter, 0,bubble}; // left
Point(5) = {xCenter+radius+pert, yCenter, 0,bubble}; // right
Ellipse(1) = {2, 1, 1, 5};
Ellipse(2) = {5, 1, 1, 3};
Ellipse(3) = {3, 1, 1, 4};
Ellipse(4) = {4, 1, 1, 2};

Point(6)  = {0.0,     L, 0.0,  wall}; // p0
Point(7)  = {2*L,     L, 0.0,  wall}; // p1
Point(8)  = {2*L,   0.0, 0.0,  wall}; // p2
Point(9)  = {L+9*L, 0.0, 0.0,  wall}; // p3
Point(10)  = {L+9*L, 2*L, 0.0,  wall}; // p4
Point(11)  = {0.0  , 2*L, 0.0,  wall}; // p5


Line(5) = {6, 7};
Line(6) = {7, 8};
Line(7) = {8, 9};
Line(8) = {9, 10};
Line(9) = {10, 11};
Line(10) = {11, 6};
Line Loop(11) = {9, 10, 5, 6, 7, 8};
Line Loop(12) = {4, 1, 2, 3};
Plane Surface(13) = {11, 12};
Extrude {0, 0, 0.4*L} {
  Surface{13};
}
Physical Surface('wallInflowU') = {32};
Physical Surface('wallOutflow') = {48};
Physical Surface('wallNoSlip') = {36, 40, 44, 28};
Physical Surface('wallNoSlipConcentration') = {-64, -52, -56, -60};
Physical Surface('wallNormalW') = {65, -13};
