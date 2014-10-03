
/*
 *            2
 *            o 
 *          / 1`,     
 *       5 o  o  o 4    
 *          \  ,'
 *            o 
 *            3
 *
 * */

// ellipse 1

// variables
xc=0.0;
yc=0.0;
zc=0.0;
r=100;
pert=0.0;
b1 = 30.0;

i=100;
j=200;
Point(i+1) = {xc, yc, zc, b1}; // center
Point(i+2) = {xc+r+pert, yc, zc, b1}; // right
Point(i+3) = {xc-r-pert, yc, zc, b1}; // left
Point(i+4) = {xc, yc, zc+r-pert, b1}; // up

Ellipse(j+1) = {i+3, i+1, i+1, i+4};
Ellipse(j+2) = {i+4, i+1, i+1, i+2};
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} {
  Line{j+2, j+1};
}
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} {
  Line{j+3, j+6};
}

// ellipse 2

// variables
xc=0.0;
yc=0.0;
zc=0.0;
r=r+100;
pert=0.0;
b1 = 30.0;

i=400;
j=500;
Point(i+1) = {xc, yc, zc, b1}; // center
Point(i+2) = {xc+r+pert, yc, zc, b1}; // right
Point(i+3) = {xc-r-pert, yc, zc, b1}; // left
Point(i+4) = {xc, yc, zc+r-pert, b1}; // up

Ellipse(j+1) = {i+3, i+1, i+1, i+4};
Ellipse(j+2) = {i+4, i+1, i+1, i+2};
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} {
  Line{j+2, j+1};
}
Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} {
  Line{j+3, j+6};
}

Line Loop(515) = {504, 510, 507, 513};
Line Loop(516) = {204, 210, 207, 213};
Plane Surface(517) = {515, 516};

Physical Surface('wallOutflow') = {505, 511, -508, -514};
Physical Surface('wallRotating') = {214, 208, -211, -205};
Physical Surface('wallNormalW') = {-517};

