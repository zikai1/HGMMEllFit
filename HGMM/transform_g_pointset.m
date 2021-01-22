function [w, gmm_g_mu, gmm_g_var, ori_p] = transform_g_pointset(N, h, parms)


ellipse_center = [parms(1); parms(2)];
A = parms(3); 
B = parms(4); 
gamma = parms(5);

tau = linspace(0,2*pi,N+1); 
tau(end) = [];


%% Generate elliptic coordinates
cos_x=cos(tau);
sin_y=sin(tau);

cos_x1=cos_x(:,2:end);
sin_y1=sin_y(:,2:end);
cos_x1(end+1)=cos(tau(1));
sin_y1(end+1)=sin(tau(1));

ori_p=[
    0.5*(cos_x+cos_x1);
    0.5*(sin_y+sin_y1)]';

%% Tansform the elliptic coordinates
ut = [A * cos(tau); B * sin(tau)];
R = [cos(gamma), -sin(gamma); sin(gamma), cos(gamma)];
u = R * ut + repmat(ellipse_center,1,N);
u = u';
u1 = u; 
u2 = [u(2:end,:);u(1,:)];
n = u2 - u1;
gmm_g_mu = (u1+u2)/2;

gmm_g_var = zeros(2,2,N);
htj = zeros(1,N);

A=zeros(2,2);
A(1,1)=h^2;
Q=zeros(2,2);

for i = 1:N
    n2 = n(i,:);
    htj(i) = norm(n2);
    n2 = n2/htj(i);
    
    Q = [
        -n2(2), n2(1); 
        n2(1), n2(2)];
    A(2,2) = htj(i)^2;
    gmm_g_var(:,:,i) = Q'*A*Q;
end
w = htj'/sum(htj);







