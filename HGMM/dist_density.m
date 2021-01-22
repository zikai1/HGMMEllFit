%===============
function [Performance]=dist_densty(param,point1,point_density)
%--------------------------------------
% Using distance and density metrics decides the correct ellipses
%Inputs:
%-------------------------
%param           1x6 elliptic parameters [X0 Y0 a b theta]
%point           Nx2 array 
%point_density   Nx1 array
%--------------------------
%Outputs:
%Performance     the value of the distance/density ratio
%---------------------------------------


L=size(point1,1);
cx=param(1);
cy=param(2);
a=max(param(3),param(4));
b=min(param(3),param(4));
r=b;
theta=param(5);
RotMat=[cos(theta) -sin(theta);sin(theta) cos(theta)];


%implicit -> parametric
A=cos(theta)^2/(a^2)+sin(theta)^2/(b^2);
B=2*sin(theta)*cos(theta)*(1/a^2-1/b^2);
C=sin(theta)^2/(a^2)+cos(theta)^2/(b^2);
D=(-2*cx*cos(theta)^2-2*cy*sin(theta)*cos(theta))/(a^2)+...
    (-2*cx*sin(theta)^2+2*cy*sin(theta)*cos(theta))/(b^2);
E=(-2*cx*sin(theta)*cos(theta)-2*cy*sin(theta)^2)/(a^2)+...
   (2*cx*sin(theta)*cos(theta)-2*cy*cos(theta)^2)/(b^2);
F=((cx*cos(theta)+cy*sin(theta))/a)^2+((cx*sin(theta)-cy*cos(theta))/b)^2-1;
X=[point1(:,1).^2 point1(:,1).*point1(:,2) point1(:,2).^2 point1(:,1) point1(:,2) ones(L,1)];
Y=X*[A B C D E F]';


% Tansform the ellipse to the canonical form
TransPoint=point1-repmat([cx,cy],L,1);
NewPoint=TransPoint*RotMat;


EuDistance=zeros(L,1);
EllDensity=zeros(L,1);
DisRecord=zeros(L,1);

%The distance from points to an ellipse
%Disntance tolerance
T=2;%3
for k=1:L  
       if Y(k)<0
           EuDistance(k)=r*(1-sqrt((NewPoint(k,1)/a)^2+(NewPoint(k,2)/b)^2));
           if EuDistance(k)<T^2
              EllDensity(k)=point_density(k);
              DisRecord(k)=EuDistance(k); 
           end
       else %Y(k)>0
           EuDistance(k)=sqrt(NewPoint(k,1)^2+NewPoint(k,2)^2)*...
           (1-1/(sqrt((NewPoint(k,1)/a)^2+(NewPoint(k,2)/b)^2)));
           if EuDistance(k)<T^2
                  EllDensity(k)=point_density(k);
                  DisRecord(k)=EuDistance(k); 
           end

       end
end

% performance computatio
EllipseDensity=exp(sum(EllDensity));
EllipseDistance=sum(DisRecord);
Performance=EllipseDistance/EllipseDensity;

end