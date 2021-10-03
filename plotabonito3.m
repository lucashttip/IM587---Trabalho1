function plotabonito3(x,y1,y2,y3,yl1,yl2,yl3,xl,t,nome)

  f = figure;
  set (f,'defaultaxesfontsize', 16);
  set (f,'position',[300 150 800 600]);

  sp1 = subplot(3,1,1);
  plot(sp1,x,y1,"linewidth",2);
  set(sp1, "linewidth", 1.5, "labelfontsizemultiplier",1.2);
  ylabel(sp1,yl1);
  xlabel(sp1,xl);

  sp2 = subplot(3,1,2);
  plot(sp2,y2,"linewidth",2);
  set(sp2, "linewidth", 1.5, "labelfontsizemultiplier",1.2);
  ylabel(sp2,yl2);
  xlabel(sp2,xl);
  
  sp3 = subplot(3,1,3);
  plot(sp3,y3,"linewidth",2);
  set(sp3, "linewidth", 1.5, "labelfontsizemultiplier",1.2);
  ylabel(sp3,yl3);
  xlabel(sp3,xl);
  
  set (f,'position',[300 150 800 600]);
end