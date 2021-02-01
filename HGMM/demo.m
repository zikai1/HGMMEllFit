function []=demo()
%-----------------------------------------------------------------
% Robust ellipse fitting using Hierarchical Gaussian Mixture Models
% E  1x8  [X0 Y0 a b theta noise pt_num outlier]
%         [X0 Y0 a b theta] is the geometric parameter of an ellipse
%         noise: Gaussian noise with zero meand and 'noise' level std.dev
%         pt_num: the number of points on the generated ellipse 
%         outlier: 1 with outliers; 0 without outliers

% To get better performance, you maybe need to slightly tune three parameters in 
% the function HGMM_fit, ie, bandwidth h, point number in the growing
% region N, and neighborhood radius R. Informations are provided in the READ.m

% For very large ellipses and very sparse input data points, larger N and R
% are suggested.

% The suggested scope of h is [4,1] for the outer fitting, and [0.9,0.6]
% for the inner fitting
%-----------------------------------------------------------------
clc;
clear;
close all;

%parameter setting
N=50;
R=10;

% elliptic paramters
E=[60,0,35,35,pi/4,0.5,120,1];% E(8)=0: no outlirs; E(8)=1: outlirs

%generated elliptic points including noise & outliers
[nx,ny,~,~]=gen_elp(E);
PointSample=[nx' ny'];
figure
plot(PointSample(:,1),PointSample(:,2),'k.');
axis equal;
title('Input data points');

%start ellipse fitting by HGMM
[FittedEllipse]=HGMM_fit(PointSample,N,R);

figure
plot(PointSample(:,1),PointSample(:,2),'k.');
axis equal;
hold on;
title("HGMM-ellipse fitting");
[~,~,tx,ty]=gen_elp([FittedEllipse 0 60 0]);
plot(tx',ty','r-','Linewidth',2);




