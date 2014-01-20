

wall = 0.1;
D = 1.0;
wallLength = 3*D;

// side defined as equivalent diamenter D_eq of a circular channel with
// D = 1
// D_eq = 4*area/perimeter
side=3*D/Sqrt(3.0); 
height=side*Sqrt(3)/2.0;

/* 
 *                   19
 *                   o
 *                  / \          Z
 *                 /   \         ^
 *                /     \        |
 *               /       \       |
 *              o ------- o       ------> Y
 *             18         17
 *
 * */

k=10000;
Point(k+1)  = {0.0*D,     side/2.0,   -height/3.0, wall}; // bottom right
Point(k+2)  = {0.0*D,-1.0*side/2.0,   -height/3.0, wall}; // bottom left
Point(k+3)  = {0.0*D,          0.0,  2*height/3.0, wall}; // top



Line(k+1) = {k+02, k+03};
Line(k+2) = {k+03, k+01};
Line(k+3) = {k+01, k+02};
Extrude {wallLength, 0, 0} {
  Line{k+3, k+1, k+2};
}
Line Loop(k+16) = {k+2, k+3, k+1};
Plane Surface(k+17) = {k+16};
Line Loop(k+18) = {k+12, k+4, k+8};
Plane Surface(k+19) = {k+18};
Physical Surface('wallInflowU') = {k+17};
Physical Surface('wallOutflow') = {k+19};
Physical Surface('wallNoSlip') = {k+15, k+07, k+11};
