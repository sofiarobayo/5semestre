
function GradienteOptimo(f,Fgrad,x0,bk)
Max=0;                                
Tol=0.09;                               
MaxIter=100;                         
   
if Max==1
   Fgrad=Fgrad;                        
else
   Fgrad=-Fgrad;                      
end
iter=1;

while norm(Fgrad)>=Tol               
   [alpha]=seccionAurea(f,x0,Fgrad,bk,Max)     
    D(iter,:)={iter,x0,Fgrad,alpha}
    x0=x0+alpha*Fgrad;                           
   
    Fgrad=[grad{1}(x0(1,1),x0(2,1))              
          grad{2}(x0(1,1),x0(2,1))];
    if Max==1
       Fgrad=Fgrad;                       
    else
       Fgrad=-Fgrad;                       
     end
    iter=iter+1;
    D(iter,:)={iter,x0,Fgrad,alpha}
end
end


