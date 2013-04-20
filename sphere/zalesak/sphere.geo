Merge "sphere.brep";

bubble = 0.1;
wall = 0.5;
wallLength = 3.0;
Characteristic Length {4, 1, 2, 3} = bubble;

Point(1000) = { -wallLength/2.0, -wallLength/2.0, -wallLength/2.0, wall};
Point(1001) = { wallLength/2.0, -wallLength/2.0, -wallLength/2.0, wall};
Point(1002) = { -wallLength/2.0, wallLength/2.0, -wallLength/2.0, wall};
Point(1003) = { wallLength/2.0, wallLength/2.0, -wallLength/2.0, wall};
Line(1000) = {1000, 1001};
Line(1001) = {1001, 1003};
Line(1002) = {1003, 1002};
Line(1003) = {1002, 1000};

Line Loop(1004) = {1002, 1003, 1000, 1001};
Plane Surface(1005) = {1004};
Extrude {0, 0, wallLength} {
  Surface{1005};
}
Physical Surface('wallNoSlip') = {1027, 1026, 1014, -1005, 1018, 1022};
Physical Surface('bubble1') = {2, 1, 4, 3};
