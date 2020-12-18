function [mmm] Newton(f, xA)
    syms x1 x2 x3 x4 x5 x6 x7 x8
    mmm = 0
    gradientef = gradient(f)
    hessianaf = hessian(f)
    k = 0;
    nx = 1;
    x1A = xA(1)
    x2A = xA(2)
    x3A = xA(3)
    x4A = xA(4)
    x5A = xA(5)
    x6A = xA(6)   
    x7A = xA(7)
    x8A = xA(8) 
    while k < nx
        nx = 8
        gradienteX = subs(gradientef, [x1, x2, x3, x4, x5, x6, x7, x8], [x1A, x2A, x3A, x4A, x5A, x6A, x7A, x8A])
        hessianaX = subs(hessianaf, [x1, x2, x3, x4, x5, x6, x7, x8], [x1A, x2A, x3A, x4A, x5A, x6A, x7A, x8A])
        xk = xA - inv(hessianaX) * gradienteX
        x1A = xk(1)
        x2A = xk(2)
        x3A = xk(3)
        x4A = xk(4)
        x5A = xk(5)
        x6A = xk(6)   
        x7A = xk(7)
        x8A = xk(8)
        xA = xk
        k = k + 1
    end
    xk1
end