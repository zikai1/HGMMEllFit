function [nx,ny,tx1,ty1]=gen_elp(E)  
%--------------------------------------------
%generate elliptic points according to E
%Inputs
%--------------------------------------------
%E:        1x8 array [X0 Y0 a b theta sigma N outlier]
%sigma:    the noise level
%N:        the number of points on the ellipse E
%outlier:  1/0    1(0) means (not) existing outliers
%-----------------------------------------------
%Outputs:
%-----------------------------------------------
%[nx ny]:     Nx2 array points, may have noise or outliers
%[tx ty]:     Nx2 array   true elliptic points do not have noise, outliers
%-----------------------------------------------
  
  randn('seed',2);
  N=E(7);
  t= linspace(0,2*pi,N+1); 
  t1= linspace(0,2*pi,60);
  t(end)=[];
  
  
  Cx = E(1);
  Cy = E(2);
  Rx = E(3);
  Ry = E(4);
  Rotation =E(5);
  NoiseLevel =E(6); % add Gaussian noise of std.dev.to points
      

  x=Rx*cos(t);
  y=Ry*sin(t);
  
  x1=Rx*cos(t1);
  y1=Ry*sin(t1);

  tx= x*cos(Rotation)-y*sin(Rotation) + Cx;
  ty = x*sin(Rotation)+y*cos(Rotation) + Cy; 
  
  tx1 = x1*cos(Rotation)-y1*sin(Rotation) + Cx;
  ty1 = x1*sin(Rotation)+y1*cos(Rotation) + Cy; 
  nx=tx+normrnd(0,NoiseLevel,size(t));
  ny=ty+normrnd(0,NoiseLevel,size(t));
  
  nx_out=[];
  ny_out=[];
  
  
  
  if E(8)==1
      nx_out=60*normrnd(0,0.5,1,50);
      ny_out=60*normrnd(0,0.5,1,50);
  end

  nx=[nx,nx_out];
  ny=[ny,ny_out];
  
  

end