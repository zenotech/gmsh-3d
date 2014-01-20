// Gmsh project created on Thu Jun  4 09:24:57 2009

wall = 0.1;

A = 0.05;
k = 1;
phase = 0;
omega = 2*Pi;
nPoints = 10;
nTheta = 19;

j = 1;
shift = 0;
// top line
For i In {1:nPoints}
 X = (i-1)/(nPoints-1);
 Y = -0.5 + A*Sin(omega*k*X-phase);
 Point(j) = {X, Y, 0, wall};
 j = j + 1;
EndFor

// lines
For i In {1:nPoints-1}
 Line(i) = {i, i+1};
EndFor

// 1st nThetaation
For i In {1:nPoints-1}
Extrude {{1, 0, 0}, {0, 0, 0}, 2*Pi/nTheta} {
  Line{i};
}
EndFor

// 2nd to last rotation
j = nPoints;
For i In {1:(nPoints-1)*(nTheta-1)}
Extrude {{1, 0, 0}, {0, 0, 0}, 2*Pi/nTheta} {
  Line{j};
}
j = j + 4;
EndFor

s1=newreg;
Line Loop(s1) = {nPoints+1:
                 4*(nPoints-1)*(nTheta-1)+nPoints+1:
                 4*(nPoints-1)};
Plane Surface(s1+1) = {s1};
s2=newreg;
Line Loop(s2) = {(nPoints+2)+4*(nPoints-2):
                 4*(nPoints-1)*(nTheta-1)+(nPoints+2)+4*(nPoints-2):
                 4*(nPoints-1)};
Plane Surface(s2+1) = {s2};


Physical Surface('wall') = {(nPoints-1)+4:
                            (nPoints-1)+4+((nPoints-1)*nTheta-1)*4:
                            4};
Physical Surface('inflow') = {s1+1};
Physical Surface('outflow') = {s2+1};

