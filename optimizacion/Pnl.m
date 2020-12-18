syms x x1 x2 x3 x4 x5 x6 x7 x8
% x(1) = x1, x(2) = x2, x(3) = x5, x(4) = x6, x(5) = x3, x(6) = x4, x(7) = x7, x(8) = x8 FUNCIÓN MULTIPLICADA POR -1
% PORQUE MAXIMIZA 
f =@(x) -22000.* x(1) + 37500.* x(2) - 11470.* x(3) + 1100.* x(3)* x(4) + 63038
f0 = -22000* x1 + 37500* x2 - 11470* x3 + 1100* x3 * x4 + 63038
gradient(f0)
x0=[0;0;0;0]
xs = fminsearch(f, x0)

%fs = f(xs)
%c = 1:100
xk1 = 50
xk = 20
epsilon = 1
c = 1
xq = [2.2520, -2.3371, -0.2384, 0.0012, 0, 0, 0, 0]
while xk1 - xk > epsilon
    epsilon = 0.000001
    hc = c*(4.*x1 - x6 + 0.3.*x1 - x2 + 0.95.*x4^2 + 0.25.*x7 + 0.25.*x8 - x5 + x5 + x2 - 0.25.*x1 - 14.4)
    
    gc= c*(( x1 - 21)^2 +(37500*x2 + 530*x3 - 214962)^2+(0.8*x3+0.2*x2-0.25*x1-14.4)^2+(2.8-x6^2)^2+(x6^2-3.16)^2+(0.002-x7)^2+(x7-0.0025)^2+(0.015-x8)^2+(x8-0.025)^2+(x6-10*x1+18)^2)
  
    q = f0 + hc + gc
    grad=gradient(q)
    x = [2.2520, -2.3371, -0.2384, 0.0012, 0, 0, 0, 0]
    f=inline(grad,'x1','x2','x3','x4','x5','x6','x7','x8')
    Fgrad=f(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8))
    
    hess=hessian(q,[x1,x2,x3,x4,x5,x6,x7,x8])
    
    bk=8
    xk1 = GradienteOptimo(q,Fgrad,x,bk)
    %xk1 = fminsearch(q,xq)
    xk = xk1
    c = c + 1
end

