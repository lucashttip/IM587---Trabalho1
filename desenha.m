function [x,y] = desenha(q,A,B)
  C1 = 30;
  C2 = 45;
  C3 = 35;
  l1 = 12.5;
  l2 = 1.5;
  L1 = 12.5*cosd(6.5) + 1.5;
  L2 = 45 - 12.5*sind(6.5);
  
  h = 2;
  
  O = [0,0];
  p1 = [-(C1-l1)*cos(q),-(C1-l1)*sin(q)];
  p2 = [l1*cos(q), l1*sin(q)];
  p3 = [L1,L2];
##  t1 = (1/16:1/8:1)' * 2*pi;
##  t2 = ((1/16:1/8:1)' + 1/32) * 2*pi;
##  x1 = sin (t1) - 0.8;
##  y1 = cos (t1);
##  x2 = sin (t2) + 0.8;
##  y2 = cos (t2);
##  h = patch ([x1,x2], [y1,y2], cat (3, [0,0],[1,0],[0,1]));
##  h = patch ([-C1/2; -C1/2; C1/2; C1/2],[1; -1; -1; 1], "g");
  [x1,y1] = desenha_barra(p1,C1,h,q);
  [x2,y2] = desenha_barra(p2,C2,h,A-pi/2);
  [x3,y3] = desenha_barra(p3,C3,h,pi - B);
##  set (h, "FaceColor", "r");
##  title ("teste");

  x = [x1, x2, x3];
  y = [y1, y2, y3];

end