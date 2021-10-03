function [A, B] = newtonR2(F,iJ,q,A0,B0,tolmax, maxiter)
  tol = norm(F(A0,B0,q));
  x0 = [A0;B0];
  
  iter = 1;
  
  while tol > tolmax && iter <= maxiter
    
    x = x0 - iJ(x0(1),x0(2))*F(x0(1),x0(2),q);
    tol = norm(F(x(1),x(2),q));
    iter = iter + 1;
    x0 = x;
  endwhile
  
  A = x0(1);
  B = x0(2);
end