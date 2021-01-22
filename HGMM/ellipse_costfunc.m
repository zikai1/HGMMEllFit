function [cost, grad] = ellipse_costfunc(wg, gmm_g_mu, gmm_g_var, wf, gmm_f_mu, gmm_f_var, varargin)

[c1, g1] = mexGaussTransformForEllipse(wg, gmm_g_mu, gmm_g_var, wg, gmm_g_mu, gmm_g_var);
[c2, g2] = mexGaussTransformForEllipse(wg, gmm_g_mu, gmm_g_var, wf, gmm_f_mu, gmm_f_var);

% [c1t, ~] = mexGaussTransformForEllipse(wg, gmm_g_mu, gmm_g_var, wg, gmm_g_mu, gmm_g_var);
% [c2t, ~] = mexGaussTransformForEllipse(wg, gmm_g_mu, gmm_g_var, wf, gmm_f_mu, gmm_f_var);
% 
% disp([num2str(c1-c1t),', ',num2str(c2-c2t),', ',num2str(c1),', ',num2str(c1t),', ',num2str(c2),', ',num2str(c2t)]);

other_num = size(varargin,2);
if other_num == 0
    c3 = mexGaussTransformForEllipse(wg, gmm_g_mu, gmm_g_var, wf, gmm_f_mu, gmm_f_var);
elseif other_num == 1
    c3 = varargin{1};
else
    error('Wrong inputs');
end

cost = c1 - 2 * c2 + c3;
grad = 2 * g1 - 2 * g2;

end



