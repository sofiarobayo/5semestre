clear 
clc
close all
syms x x1 x2 x3 x4 x5 x6 x7 x8


f0 = -22000* x1 + 37500* x2 - 11470* x3 + 1100* x3 * x4 + 63038
c=45678
hc = c*(4.*x1 - x6 + 0.3.*x1 - x2 + 0.95.*x4^2 + 0.25.*x7 + 0.25.*x8 - x5 + x5 + x2 - 0.25.*x1 - 14.4)
    
gc= c*(( x1 - 21)^2 +(37500*x2 + 530*x3 - 214962)^2+(0.8*x3+0.2*x2-0.25*x1-14.4)^2+(2.8-x6^2)^2+(x6^2-3.16)^2+(0.002-x7)^2+(x7-0.0025)^2+(0.015-x8)^2+(x8-0.025)^2+(x6-10*x1+18)^2)
  
q = f0 + hc + gc
grad=gradient(q)
x = [2.2520, -2.3371, -0.2384, 0.0012, 0, 0, 0, 0]
f=inline(grad,'x1','x2','x3','x4','x5','x6','x7','x8')
F=f(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8))