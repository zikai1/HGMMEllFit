function [par_inner]=HGMM_outer_inner(Pouter,Pouter_density,Sample,SampleDensity)
%--------------------------------
%Outer fitting by HGMM
%Inputs:
%--------------------------------
%Pouter                Mx2  data points in the growing region
%Pouter_density        Mx1  data density
%--------------------------------
%Outputs
%--------------------------------
%par_inner   1x5       the fitted ellipse with its geometric parameter
%---------------------------------
%% optimization settings
options = optimset('LargeScale','off','GradObj', 'off', 'TolFun', 1e-010, ...
    'TolX', 1e-010, 'TolCon', 1e-10, 'MaxFunEvals', 1000);
lb = [-100,-100,1,1,-pi];
rb = [500,500,400, 400, pi];

% visualize the optimization process
%{
%% Global variables
global temp_parms h_parms final_cost;
temp_parms = [];
h_parms = [];
final_cost=[];
%}

%{ 
figure
plot(Pouter(:,1),Pouter(:,2),'r.');
axis equal;
title('Iteration-outer');
hold on;
%}
 
%% Outer fitting of HGMM
hmin =3; hmax =4; beta = 0.8;
h=hmax;
fix=1000;
IniPat=[mean(Pouter,1),1,1,0];
N=20;
while h>hmin
    %h
    [wf, gmm_f_mu, gmm_f_var] = model_f_pixel(Pouter,h);
    [f2_L2, ~] = mexGaussTransformForEllipse(wf, gmm_f_mu, gmm_f_var, wf, gmm_f_mu, gmm_f_var);
    [parms,~] = fmincon(@gmmregelp_L2_costfunc,IniPat, [], [], [], [], lb, rb, [], options, ...
        N, h, wf, gmm_f_mu, gmm_f_var, f2_L2);
    
    %compute the metrics of distance and density
    [perf]=dist_density(parms,Pouter,Pouter_density);
    if (perf<fix)
        fix=perf;
        par_outer=parms;
    end
    h=h*beta;
end

%% Inner fitting of HGMM
if (par_outer(1,3)/par_outer(1.,4)>5||par_outer(1,3)/par_outer(1.,4)<1/5)
    IniPat=[par_outer(:,1:2),1,1,0];
else
    IniPat=par_outer;
end


hmin =0.7; hmax =0.9; beta = 0.8;
h=hmax;
fix=1000;
while h>hmin
    %h
    [wf, gmm_f_mu, gmm_f_var] = model_f_pixel(Sample,h);
    [f2_L2, ~] = mexGaussTransformForEllipse(wf, gmm_f_mu, gmm_f_var, wf, gmm_f_mu, gmm_f_var);
    [parms,~] = fmincon(@gmmregelp_L2_costfunc,IniPat, [], [], [], [], lb, rb, [], options, ...
        N, h, wf, gmm_f_mu, gmm_f_var, f2_L2);

    %compute the metrics of distance and density
    [perf]=dist_density(parms,Sample,SampleDensity);
    if (perf<fix)
        fix=perf;
        par_inner=parms;
    end
    h=h*beta;
end

end
