// variables

i=100*t;
j=200*t;

Point(i+1) = {0.3, 0,    0, b1};
Point(i+2) = {0.8, 0,  0.5, b1};
Point(i+3) = {0.8, 0, -0.5, b1};
Point(i+4) = {0.8, 0,    0, b1};
Ellipse(j+1) = {i+2, i+4, i+4, i+1};
Ellipse(j+2) = {i+1, i+4, i+4, i+3};
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/2} {
  Line{j+1, j+2};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/2} {
  Line{j+3, j+7};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/2} {
  Line{j+11, j+15};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/2} {
  Line{j+19, j+23};
}
Line Loop(j+35) = {i+4, i+12, i+20, i+28};
Plane Surface(j+36) = {j+35};
Line Loop(j+37) = {i+17, i+25, i+33, i+9};
Plane Surface(j+38) = {j+37};
