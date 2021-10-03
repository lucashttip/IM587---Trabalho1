clc
clear

### ====== Constantes =======
##l1 = 12.5
##l2 = 1.5;
L1r = 12.5*cosd(6.5) + 1.5;
L2r = 45 - 12.5*sind(6.5);
##L1 = 13.9;
##L2 = 46.4;
##C2 = 45;

### ====== Resolvendo o problema com simbolico ======
pkg load symbolic
syms l1 l2 L1 L2 C2 q A B Aq(q) Bq(q) qp qpp

f1 = l1*cos(q) + C2*sin(A) + l2*cos(B) - L1;
f2 = l1*sin(q) - C2*cos(A) - l2*sin(B) - L2;

F = [f1; f2];

J = jacobian(F,[A B]);

iJ = simplify(inv(J));

b = -jacobian(F,q);

K = simplify(iJ*b);

Kq = subs(K,{A,B},{Aq,Bq});

JL = jacobian(Kq,q);\
L = simplify(subs(JL,{diff(Aq,q),diff(Bq,q)},{K(1),K(2)}));

#### ======= Analise da posição
##
#### Transformando as expressões simbolicas em funções
##
##iJf1 = function_handle(iJ,'vars', [A B C2 l2]);
##
##Ff1 = function_handle(F,'vars', [A B q C2 L1 L2 l1 l2]);
##
##iJf = @(A,B) iJf1(A, B, 45, 1.5);
##
##Ff = @(A,B,q) Ff1(A, B, q, 45, L1r, L2r,12.5,1.5);
##
##
#### Resolvendo o problema com Newton-Raphson
##N = 100;
##
##q0 = linspace(-6.5,0.5,N);
##q0rad = deg2rad(q0);
##
##A0rad = zeros(N,1);
##B0rad = zeros(N,1);
##
##x0 = [pi,0];
##
##for i = 1:N
##  [A0rad(i), B0rad(i)] = newtonR2(Ff,iJf,q0rad(i),x0(1),x0(2),1e-5,15);
##  x0 = [A0rad(i), B0rad(i)];
## endfor
##
##A0 = rad2deg(A0rad);
##B0 = rad2deg(B0rad);
##
##f = figure;
##sp1 = subplot(3,1,1);
##plot(sp1,q0);
##ylabel(sp1,"q");
##
##sp2 = subplot(3,1,2);
##plot(sp2,A0);
##ylabel(sp2,"A");
##
##sp3 = subplot(3,1,3);
##plot(sp3,B0);
##ylabel(sp3,"B");
