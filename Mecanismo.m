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
##C3 = 35;

### ====== Resolvendo o problema com simbolico ======
pkg load symbolic
syms l1 l2 L1 L2 C2 C3 A B q Aq(q) Bq(q) Kb Kbq(q) Lb Lbq(q) qp qpp;

### Equações de loop
f1 = l1*cos(q) + C2*sin(A) + l2*cos(B) - L1;
f2 = l1*sin(q) - C2*cos(A) - l2*sin(B) - L2;

F = [f1; f2];

# jacobiano
J = jacobian(F,[A B]);

# Inversa do jacobiano
iJ = simplify(inv(J));

# Vetor b
b = -jacobian(F,q);

# Coeficientes de velocidade das secundárias
K = simplify(iJ*b);

# Calculando os coeficientes de aceleração das secundárias
Kq = subs(K,{A,B},{Aq,Bq});
JL = jacobian(Kq,q);

# Coeficientes de aceleração das secundárias
L = subs(subs(JL,{diff(Aq,q),diff(Bq,q)},{K(1),K(2)}),{Aq,Bq},{A,B});
L = simplify(L);

### Equações do ponto de interesse:
xp = C3*cos(Bq);
yp = C3*sin(Bq);
P = [subs(xp,Bq,B); subs(yp,Bq,B)];

# coeficientes de velocidade do ponto de interese
Kxpq = subs(diff(xp,q),diff(Bq,q),Kbq);
Kypq = subs(diff(yp,q),diff(Bq,q),Kbq);

# Coeficiente de aceleração do ponto de interesse
Lxpq = subs(diff(Kxpq,q),{diff(Kbq,q),diff(Bq,q)},{Lbq,Kbq});
Lypq = subs(diff(Kypq,q),{diff(Kbq,q),diff(Bq,q)},{Lbq,Kbq});

# Simplificando
Kxp = simplify(subs(Kxpq,{Aq,Bq,Kbq,Lbq},{A,B,Kb,Lb}));
Kyp = simplify(subs(Kypq,{Aq,Bq,Kbq,Lbq},{A,B,Kb,Lb}));
Kp = [Kxp; Kyp];

Lxp = simplify(subs(Lxpq,{Aq,Bq,Kbq,Lbq},{A,B,Kb,Lb}));
Lyp = simplify(subs(Lypq,{Aq,Bq,Kbq,Lbq},{A,B,Kb,Lb}));
Lp = [Lxp; Lyp];

### Transformando as expressões simbolicas em funções
# Expressões para calculo da posição:
iJf1 = function_handle(iJ,'vars', [A B C2 l2]);
Ff1 = function_handle(F,'vars', [A B q C2 L1 L2 l1 l2]);

# Expressões para calculo da velocidade e aceleração das secundárias
Kf1 = function_handle(K,'vars', [A B q C2 l1 l2]);
Lf1 = function_handle(L,'vars', [A B q C2 l1 l2]);

# Expressões para calculo da posição, velocidade e aceleração do ponto de interesse
Pf1 = function_handle(P,'vars', [B C3]);
Kpf1 = function_handle(Kp,'vars', [B Kb C3]);
Lpf1 = function_handle(Lp,'vars', [B Kb Lb C3]);

# Funções com os valores das constantes geométricas para facilidade
iJf = @(A,B) iJf1(A, B, 45, 1.5);
Ff = @(A,B,q) Ff1(A, B, q, 45, L1r, L2r,12.5,1.5);

Kf = @(A, B, q) Kf1(A, B, q, 45, 12.5, 1.5);
Lf = @(A, B, q) Lf1(A, B, q, 45, 12.5, 1.5);

Pf = @(B) Pf1(B,35);
Kpf = @(A, B, q) Kpf1(B, Kf(A,B,q)(2), 35);
Lpf = @(A, B, q) Lpf1(B, Kf(A,B,q)(2), Lf(A,B,q)(2), 35);

save functions.mat iJf1 Ff1 Kf1 Lf1 Pf1 Kpf1 Lpf1 iJf Ff Kf Lf Pf Kpf Lpf