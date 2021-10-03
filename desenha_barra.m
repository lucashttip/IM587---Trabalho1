function [x, y] = desenha_barra(ponto,l,h,t)
  
  x0 = ponto(1);
  y0 = ponto(2);
  
  x1 = x0 - (h/2)*sin(t);
  x2 = x0+(h/2)*sin(t);
  x3 = x2 + l*cos(t);
  x4 = x3 - h*sin(t);
  
  y1 = y0 + (h/2)*cos(t);
  y2 = y0 - (h/2)*cos(t);
  y3 = y2 + l*sin(t);
  y4 = y3 + h*cos(t);
  
  x = [x1;x2;x3;x4];
  y = [y1;y2;y3;y4];
  
##  p = patch(x,y,[0.8,0.8,0.8])
end
  