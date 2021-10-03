function [as,bs,xps,yps] = analisecinematica(q,qp,qpp,t,N,Ff,iJf,Kf,Lf,Pf,Kpf,Lpf)
  
  A = zeros(N,1);
  Ap = zeros(N,1);
  App = zeros(N,1);
  B = zeros(N,1);
  Bp = zeros(N,1);
  Bpp = zeros(N,1);
  XP = zeros(N,1);
  XPp = zeros(N,1);
  XPpp = zeros(N,1);
  YP = zeros(N,1);
  YPp = zeros(N,1);
  YPpp = zeros(N,1);
  
  for i = 1:N
    # Posição das secundárias
    if i == 1
      [A(i), B(i)] = newtonR2(Ff,iJf,q(i),pi,0,1e-5,15);
    else
      [A(i), B(i)] = newtonR2(Ff,iJf,q(i),A(i-1),B(i-1),1e-5,15);
    endif
    
    # Velocidade das secundárias
    K = Kf(A(i),B(i),q(i));
    Ap(i) = K(1)*qp(i);
    Bp(i) = K(2)*qp(i);
    
    # Aceleração das secundárias
    L = Lf(A(i),B(i),q(i));
    App(i) = K(1)*qpp(i) + L(1)*(qp(i)^2);
    Bpp(i) = K(2)*qpp(i) + L(2)*(qp(i)^2);
    
    # Posição do ponto de interesse
    Ppos = Pf(B(i));
    XP(i) = Ppos(1);
    YP(i) = Ppos(2);
    
    # Velocidade do ponto de interesse
    Kp = Kpf(A(i),B(i),q(i));
    XPp(i) = Kp(1)*qp(i);
    YPp(i) = Kp(2)*qp(i);
    
    # Aceleração do ponto de interesse
    Lp = Lpf(A(i),B(i),q(i));
    XPpp(i) = Kp(1)*qpp(i) + Lp(1)*(qp(i)^2);
    YPpp(i) = Kp(2)*qpp(i) + Lp(2)*(qp(i)^2);
    
  endfor
  as = {A, Ap, App};
  bs = {B, Bp, Bpp};
  xps = {XP, XPp, XPpp};
  yps = {YP, YPp, YPpp};
end