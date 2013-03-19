
wall = 0.09;

L = 1.0;


/* 
 *              5         2L+5L          4
 *              o --------------------- o         
 *              |                       |       
 *         L    |                       |       
 *              |                       |       Y         
 *              o ----- o               | 2L    ^
 *              0     1 |               |       |
 *                  2L  |               |       |
 *              x(0,0)  o ------------- o       o -----> X
 *                      2      5L       3
 * */

Point(0)  = {0.0,     L, 0.0,  wall}; // p0
Point(1)  = {2*L,     L, 0.0,  wall}; // p1
Point(2)  = {2*L,   0.0, 0.0,  wall}; // p2
Point(3)  = {2*L+5*L, 0.0, 0.0,  wall}; // p3
Point(4)  = {2*L+5*L, 2*L, 0.0,  wall}; // p4
Point(5)  = {0.0  , 2*L, 0.0,  wall}; // p5


Line(1) = {0, 1};
Line(2) = {1, 2};
Line(3) = {2, 3};
Line(4) = {3, 4};
Line(5) = {4, 5};
Line(6) = {5, 0};
Line Loop(7) = {5, 6, 1, 2, 3, 4};
Plane Surface(8) = {7};
Extrude {0, 0, 0.4*L} {
  Surface{8};
}
Physical Surface('wallInflowU') = {23};
Physical Surface('wallOutflow') = {39};
Physical Surface('wallNoSlip') = {27, 31, 35, 19, 40, -8};
Physical Surface('wallNormalW') = {40, -8};
