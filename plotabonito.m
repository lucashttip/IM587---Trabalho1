function plotabonito(x,y,yl,xl,r,c,filename)

  n = size(y,2)
  
  if n != size(yl,2)
    error("Tamanhos de y e yl errados");
    return;
  endif

  f = figure;
  set (f,'defaultaxesfontsize', 13);
  set (f,'position',[300 150 500 500]);
  
  for i = 1:n
    sp = subplot(r,c,i);
    plot(sp,x,y{i},"linewidth",2);
    set(sp, "linewidth", 1.5, "labelfontsizemultiplier",1.2);
    ylabel(sp,yl{i});
    xlabel(sp,xl);
  endfor
  
  set (f,'position',[300 150 500 500]);
  print (f, filename)
##  print -dpng -color plot1.png

end