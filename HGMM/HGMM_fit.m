function [Par]=HGMM_fit(PointSample,N,R)
%--------------------------------------------------------
%Robust ellipse fitting by HGMM
% HGMM contains two layers, the first layer fits data points from the
% growing region, while the innr layer fits all data points
%----------------------------
%Inputs:
%----------------------------
%PointSample:    Nx2    input data points
%N               the number of points in region growing 
%R               the neighborhood distance in region growing
%----------------------------
%Output:
%----------------------------
%Par:            1x5    [X0 Y0 a b theta] elliptic parameters
%--------------------------------------------------------

%% compute point density
[SampleDensity]=point_density(PointSample,1);

%% region growing
[Pouter,Pouter_density]=region_grow(PointSample,SampleDensity,N,R);

%{
figure
plot(Pouter(:,1),Pouter(:,2),'r.');
axis equal;
hold on;
title("Region growing");
%}


%% HGMM fitting
[Par]=HGMM_outer_inner(Pouter,Pouter_density,PointSample,SampleDensity);