Merge "zalesak.step";

wall = 10.0;
wallLength = 4.0;

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
Physical Surface('wallNoSlip') = {1018, 1005, 1022, 1026, 1027, 1014};
Physical Surface('bubble1') = {1, 4, 2, 3};
