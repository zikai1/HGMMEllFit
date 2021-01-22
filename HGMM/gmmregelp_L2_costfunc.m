function [cost,g] = gmmregelp_L2_costfunc(parms, N, h, wf, gmm_f_mu, gmm_f_var, f2_L2)

% visualize the optimization process
%{
global temp_parms h_parms final_cost;

temp_parms = [temp_parms;parms];
 if ~isempty(h_parms)
     delete(h_parms);
 end
[x,y] = GenerateElpData(parms);
 h_parms = plot(x,y,'-b','linewidth',1);
 drawnow;
%}
 

%% Ellipsoid model
[wg, gmm_g_mu, gmm_g_var, ori_p] = transform_g_pointset(N, h, parms);

%% Errors and gradients of the objective function
[cost, grad_fg] = ellipse_costfunc(wg, gmm_g_mu, gmm_g_var, ...
    wf, gmm_f_mu, gmm_f_var, f2_L2);
%final_cost=[final_cost,cost];
g_p = zeros(1,5);

% Center gradient
g_p(1) = sum(grad_fg(:,1));
g_p(2) = sum(grad_fg(:,2));

% Semi-axis gradient
theta = parms(5);
g_p(3) = [cos(theta), sin(theta)] * grad_fg' * ori_p(:,1);
g_p(4) = [-sin(theta), cos(theta)] * grad_fg' * ori_p(:,2);

% Rotation angle gradient
r = [-sin(theta) -cos(theta);
    cos(theta)  -sin(theta)];
grad_t = grad_fg' * (ori_p * [parms(3), 0; 0, parms(4)]);
g_p(5) = sum(sum(grad_t.*r));
g = g_p;


%% Results
% disp(num2str(g));
% fprintf('Params: [%.4f, %.4f, %.4f, %.4f, %.4f], Cost: %.5f, Grad: [%.3f, %.3f, %.3f, %.3f, %.3f]\n', ...
%     parms(1),parms(2),parms(4),parms(3),parms(5),cost,...
%     g(1),g(2),g(3),g(4),g(5))
