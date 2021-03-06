// Gmsh project created on Thu Jun  4 09:24:57 2009

nb = 1;
b1 = 0.08;
wall = 0.1;

D = 1.0;
r = 0.3*D;
body = 1*D;
slug = 0.7*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 4.0+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../../bubbleShape/taylor.geo';
EndFor


// sin wall config
A = 0.05;
k = 1;
stretch=10;
phase = 0;
nCycles = 4;
nPoints = 40;
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

// avoid zero coordinate on the boundary
Rotate {{1, 0, 0}, {0, 0, 0}, Pi/30.0} {
  Point{k+1:k+nPoints};
}

j = 1+k;
// lines
For i In {1:nPoints-1}
 Line(j) = {j, j+1};
 j = j + 1;
EndFor

j = 1+k;
// 1st nThetaation
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


Physical Surface('wallInflowZeroU') = {-1*(s1+1),s2+1};
Physical Surface('wallMovingYZ') = {-((nPoints-1)+4+k):
                            -((nPoints-1)+4+((nPoints-1)*nTheta-1)*4+k):
                            -4};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40,-(j+10), -(j+30), j+20,
                                            j+36, j+16, -(j+33), -(j+13), 
                                            -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

Transfinite Line {10256, 10260, 10264, 10268, 10272, 10276, 10280,
10412, 10416, 10420, 10424, 10428, 10432, 10436, 10100, 10104, 10108,
10112, 10116, 10120, 10124, 10016, 10017, 10018, 10019, 10020, 10021,
10022} = 20 Using Progression 1;
Transfinite Line {10410, 10566, 10254, 10098, 10414, 10570, 10258,
10102, 10418, 10574, 10262, 10106, 10422, 10578, 10266, 10110, 10426,
10582, 10270, 10114, 10430, 10586, 10274, 10118, 10434, 10590, 10278,
10122, 10438, 10594, 10282, 10126} = 20 Using Progression 1;
