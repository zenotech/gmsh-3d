
// variables

i=100*t;
j=200*t;

/*
 *            2
 *            o --------- o
 *          / 1`,          `, 
 *       5 o  o  o 4         o
 *          \  ,'          ,'
 *            o --------- o 
 *            3
 *
 * */

Point(i+1) = {xc, yc, zc, b1}; // center
Point(i+2) = {xc+r+pert, yc, zc, b1}; // right
Point(i+3) = {xc-r-pert, yc, zc, b1}; // left
Point(i+4) = {xc, yc+r-pert, zc,b1}; // up
Point(i+5) = {xc, yc-r+pert, zc,b1}; // down
Ellipse(j+1) = {i+4, i+1, i+1, i+2};
Ellipse(j+2) = {i+2, i+1, i+1, i+5};
Ellipse(j+3) = {i+3, i+1, i+1, i+5};
Ellipse(j+4) = {i+4, i+1, i+1, i+3};

Extrude {0, 0, 1} {
  Line{j+1, j+2, j+3, j+4};
}
Line Loop(j+21) = {i+1, i+2, i-3, i-4};
Plane Surface(j+22) = {j+21};
Line Loop(j+23) = {i+5, i+9, i-13, i-17};
Plane Surface(j+24) = {j+23};

