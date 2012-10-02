Merge "../bubbles/zalesak.brep";

bubble = 0.1;
wall = 0.5;
wallLength = 6.0;
Characteristic Length {4, 1, 2, 3} = bubble;

k=10000;
Point(k+1) = { -wallLength/2.0, -wallLength/2.0, -wallLength/2.0, wall};
Point(k+2) = {  wallLength/2.0, -wallLength/2.0, -wallLength/2.0, wall};
Point(k+3) = { -wallLength/2.0,  wallLength/2.0, -wallLength/2.0, wall};
Point(k+4) = {  wallLength/2.0,  wallLength/2.0, -wallLength/2.0, wall};
Line(k+1) = {k+1, k+2};
Line(k+2) = {k+2, k+4};
Line(k+3) = {k+4, k+3};
Line(k+4) = {k+3, k+1};

Line Loop(k+5) = {k+3, k+4, k+1, k+2};
Plane Surface(k+6) = {k+5};
Extrude {0, 0, wallLength} {
  Surface{k+6};
}

Physical Surface('wallNoSlip') = {k+28, k+27, k+15, k+6, k+19, k+23};
Physical Surface('bubble1') = {2, 1, 4, 3};
