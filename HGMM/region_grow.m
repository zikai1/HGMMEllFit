function [Pouter,PouterDensity]=region_grow(Sample,SampleDensity,N,R)
%------------------------------
% region growing based on the distance and density
%Inputs:
%----------------------------
%Sample           Nx2 array [x,y]
%SampleDensity    Nx1 array  
%R                the neighborhood radius
%----------------------------
%Outputs
%----------------------------
%Pouter            Mx2 array [x,y] the points in the growing region
%PouterDensity     Mx1 array 
%-----------------------------

%the point with the highest density
[Maxdenty,indx]=max(SampleDensity);
Pstart=Sample(indx,:);
Pouter=[];
PouterDensity=[];


%start growing
while 1
    if(size(Pouter,1)>=N) %can be adaptive?
        break 
    else
        [point_sim,point_sim_den,next_pt,next_start,next_start_density,next_den]=point_region_growth(Sample,SampleDensity,Pstart,Maxdenty,R);%R=10
        %cannot grow
        if(isempty(point_sim))
            break;
        end
    end
    
    Pouter=[Pouter;point_sim];
    PouterDensity=[PouterDensity;point_sim_den];
    Sample=next_pt;
    SampleDensity=next_den;
    Pstart=next_start;
    Maxdenty=next_start_density;
end
end
