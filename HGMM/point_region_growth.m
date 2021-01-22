function [point_sim,point_sim_den,next_pt,next_start,next_start_density,next_den]=point_region_growth(Point,Point_density,P_start,Start_density,R)
%--------------------------------------
%Outputs
%--------------------------------------
%
% point_sim             Mx2 array [x,y] near points with similar density
% point_sim_den         Mx1 array the density of point_sim
% next_pt               Kx2 array [x,y] the remaining data points
% next_start            the next start point
% next_start_density    the density of the next start point
% next_den              Kx1 array  the density of the remaining data points
%-------------------------------------


par_dis=pdist2(P_start,Point);
point_neibor=Point(par_dis<R,:);
point_neibor_density=Point_density(par_dis<R,:);
point_sim=point_neibor(point_neibor_density./Start_density>=0.1,:);% can slightly tune down if points are sparse
point_sim_den=point_neibor_density(point_neibor_density./Start_density>=0.1,:);

D=pdist2(P_start,point_sim,'Euclidean');
[~,I]=max(D);
next_start=point_sim(I,:);
next_start_density=point_sim_den(I,:);

%delete growing region from the input data points
[~,loc]=ismember(point_sim,Point,'rows');
Point(loc,:)=[];
Point_density(loc,:)=[];
next_pt=Point;
next_den=Point_density;
