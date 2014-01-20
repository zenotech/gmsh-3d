// Gmsh project created on Thu Jun  4 09:24:57 2009

nb = 1;
b1 = 0.08;
wall = 0.1;

D = 1.0;
r = 0.30*D;
body = 1*D;
slug = 0.7*r;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.5+(slug+body+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;

 // include torus.geo file
 Include '../bubbleShape/taylor.geo';
EndFor


// sin wall config
A = 0.05;
k = 1;
stretch=5;
phase = 1.5;
omega = 2*Pi;
nPoints = 30;
nTheta = 4;

k = 10000;
j = 1+k;
shift = 0;
// top line
For i In {1:nPoints}
 X = stretch*( (i-1)/(nPoints-1) );
 Y = +0.5 + A*Sin(omega*k*X-phase);
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


Physical Surface('wallNoSlip') = {-((nPoints-1)+4+k):
                            -((nPoints-1)+4+((nPoints-1)*nTheta-1)*4+k):
                            -4};
Physical Surface('wallInflowUParabolic') = {-1*(s1+1)};
Physical Surface('wallOutflow') = {s2+1};

j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+40,-(j+10), -(j+30), j+20,
                                            j+36, j+16, -(j+33), -(j+13), 
                                            -(j+26), j+43, j+23, -(j+46)};
 j=200*t;
EndFor

