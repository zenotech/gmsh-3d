// Gmsh project created on Thu Jun  4 09:24:57 2009

wall = 0.1;

A = 0.05;
k = 1;
stretch=4;
phase = 0;
nCycles = 1;
nPoints = 18;
nTheta = 4;

k = 10000;
j = 1+k;
shift = 0;
// top line
For i In {1:nPoints}
 X = stretch*( (i-1)/(nPoints-1) );
 Y = 0.5 + A*Sin(nCycles*2*Pi/stretch*X-phase);
 Point(j) = {X, Y, 0, wall};
 j = j + 1;
EndFor

j = 1+k;
// lines
For i In {1:nPoints-1}
 Line(j) = {j, j+1};
 j = j + 1;
EndFor

j = 1+k;
// 1st rotation
For i In {1:nPoints-1}
Extrude {{1, 0, 0}, {0, 0, 0}, 2*Pi/nTheta} {
  Line{j};
}
 j = j + 1;
EndFor

// 2nd to last rotation
j = nPoints+k;
For i In {1:(nPoints-1)*(nTheta-1)}
Extrude {{1, 0, 0}, {0, 0, 0}, 2*Pi/nTheta} {
  Line{j};
}
j = j + 4;
EndFor

s1=newreg;
Line Loop(s1) = {nPoints+1+k:
                 4*(nPoints-1)*(nTheta-1)+nPoints+1+k:
                 4*(nPoints-1)};
Plane Surface(s1+1) = {s1};
s2=newreg;
Line Loop(s2) = {(nPoints+2)+4*(nPoints-2)+k:
                 4*(nPoints-1)*(nTheta-1)+(nPoints+2)+4*(nPoints-2)+k:
                 4*(nPoints-1)};
Plane Surface(s2+1) = {s2};


Physical Surface('wallNoSlip') = {-((nPoints-1)+4+k):
                            -((nPoints-1)+4+((nPoints-1)*nTheta-1)*4+k):
                            -4};
Physical Surface('wallInflow') = {-1*(s1+1)};
Physical Surface('wallOutflow') = {s2+1};

