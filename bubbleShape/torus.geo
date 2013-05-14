
// variables

i=100*t;
j=200*t;

Point(i+1) = {xc, yc, zc, b1}; // center
Point(i+2) = {xc+r+pert, yc, zc, b1}; // right
Point(i+3) = {xc-r-pert, yc, zc, b1}; // left
Point(i+4) = {xc, yc, zc+r-pert, b1}; // up
Point(i+5) = {xc, yc, zc-r+pert, b1}; // down
Ellipse(j+1) = {i+4, i+1, i+1, i+2};
Ellipse(j+2) = {i+2, i+1, i+1, i+5};
Ellipse(j+3) = {i+5, i+1, i+1, i+3};
Ellipse(j+4) = {i+3, i+1, i+1, i+4};

Extrude {{0, 0, 1}, {0, 0, 0}, 2*Pi/3} {
  Line{j+1, j+2, j+3, j+4};
}
Extrude {{0, 0, 1}, {0, 0, 0}, 2*Pi/3} {
  Line{j+5, j+9, j+13, j+17};
}
Extrude {{0, 0, 1}, {0, 0, 0}, 2*Pi/3} {
  Line{j+21, j+25, j+29, j+33};
}
