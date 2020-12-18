f= inline('exp(-x)+x^2+5')
a0=-1
b0=5
k=0
bk=5
ak=-1
I = [-1,5]
alpha = 0.618
lamdak = a0+(1-alpha)*(b0-a0)
miuk = a0 + alpha*(b0-a0)
Tolerancia=0.1

flamda = f(lamdak)
fmiu = f(miuk)

while bk-ak >= Tolerancia 
 
    if flamda > fmiu
        ak = lamdak
        bk = bk
        lamdak = miuk
        flamda = fmiu
        miuk = ak+alpha*(bk-ak)
        fmiu = f(miuk)
        k = k+1
    else
        if flamda < fmiu
            bk = miuk
            ak = ak
            miuk = lamdak
            fmiu = flamda
            lamdak = ak+(1-alpha)*(bk-ak)
            flamda = f(lamdak)
            k = k+1
        end  
   
    end
    plot(lamdak, flamda, '*r', miuk, fmiu, '*g')
    hold on
end
x = -1:0.1:5
y = exp(-x)+x.^2+5
title('Mín exp(-x)+x^2+5, -1 <= x <= 5 ')
plot(x,y,'b')
hold on

    

