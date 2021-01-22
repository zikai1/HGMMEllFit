
function PlotEllipse(Par)  
  t= linspace(0,2*pi,60);
  Rx = Par(3);
  Ry = Par(4);
  Cx = Par(1);
  Cy = Par(2);
  theta=Par(5);
  Rotation =theta;
  
  
      

  x=Rx*cos(t);
  y=Ry*sin(t);
  Ex = x*cos(Rotation)-y*sin(Rotation) + Cx;
  Ey = x*sin(Rotation)+y*cos(Rotation) + Cy; 
  
%plot(Ex,Ey,'r-','linewidth',1.5);
C=linspecer(9);
plot(Ex,Ey,'color',C(4,:),'linewidth',1.5);%2
 drawnow;
