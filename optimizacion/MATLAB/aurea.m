%PASO 0
%SE INGRESA LA FUNCION A CALCULAR Y EL INTERVALO EN EL QUE SE ENCUENTRA
%x^ 2 2x
bk=5 
%constante
alpha=0,618;
k=0;

lambda= ak+(1-alpha)(bk-ak)
miu= ak+alpha(bk-ak)

flambda= (lambda)^2+2*lambda;
fmiu= (miu)^2+2*miu;

%PASO 1
if bk-ak<lambda
    break;
    disp('el valor de lambda pertenece al intervalo')
else
    %PASO 2
    if flambda>fmiu
        ak=lambda;
        lambda=miuk;
        flambda=fmiu;
        miu= ak+alpha(bk-ak);
        fmiu= (miu)^2+2*miu;
    %PASO 3
    elseif flambda<fmiu
        bk=miu;
        miu=lambda;
        fmiu=flambda;
        lambda= ak+(1-alpha)(bk-ak);
        flambda= (lambda)^2+2*lambda;
    end
end








