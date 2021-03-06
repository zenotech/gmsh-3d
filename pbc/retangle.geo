
wall = 0.3;

L = 1.0;

/* 
 *              3               2
 *              o ------------- o    Y           
 *              |               |    ^
 *          L   |               |    |
 *              |               |    |
 *              o ------------- o     ------> X
 *              0      3*L      1
 *
 * */

Point(0) = {0.0, 0.0, 0.0,  wall}; // p0
Point(1) = {L,   0.0, 0.0,  wall}; // p1
Point(2) = {L,     L, 0.0,  wall}; // p2
Point(3) = {0.0,   L, 0.0,  wall}; // p3

Line(1) = {0, 1};
Line(2) = {1, 2};
Line(3) = {2, 3};
Line(4) = {3, 0};
Line Loop(5) = {2, 3, 4, 1};
Plane Surface(6) = {5};
Extrude {0, 0, L} {
  Surface{6};
}

// PERIODIC MESHING
// For periodic surfaces, the line tangents of the two periodic planes
// (slave and master) must have the same orientation.
Periodic Surface 6 {2,3,4,1} = 28 {8,9,10,11};

// For correct orientation, the normal vectors must be pointed outward.
Physical Surface('wallInflowU') = {23};
Physical Surface('wallOutflow') = {15};
Physical Surface('wallNoSlip') = {19,27};
Physical Surface('wallSymmetryMaster') = {-6};
Physical Surface('wallSymmetrySlave') = {28};

