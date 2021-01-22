function [w, gmm_f_mu, gmm_f_var] = model_f_pixel(p,h)


A = [
    h^2, 0; 
    0, h^2];


gmm_f_mu = p;

n = size(p,1);
w = ones(n,1)/n;



gmm_f_var=repmat(A,1,1,n);



end