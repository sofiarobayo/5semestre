

function [alpha1]=seccionAurea(f,x0,Fgrad,bk,Max) 
 ak=-5;   
tol=0.02;
alpha=0.618;                         

lamdak=alpha*ak+(1-alpha)*bk;        
miuk=(1-alpha)*ak+alpha*bk;          
fl=f(x0(1,1)+lamdak*Fgrad(1,1),x0(2,1)+lamdak*Fgrad(2,1));                      
fm=f(x0(1,1)+miuk*Fgrad(1,1),x0(2,1)+miuk*Fgrad(2,1));                          

iter=0;                              
while abs(bk-ak) >= tol              
    iter=iter+1;                    
  if Max==0
    if fl>fm                      
       ak=lamdak;                    
       lamdak=miuk;                
       fl=fm;                       
       miuk=(1-alpha)*ak+alpha*bk;   
       fm=f(x0(1,1)+miuk*Fgrad(1,1),x0(2,1)+miuk*Fgrad(2,1));                 
    elseif fl<fm                    
       bk=miuk                
       miuk=lamdak;                  
       fm=fl;                    
       lamdak=alpha*ak+(1-alpha)*bk; 
       fl=f(x0(1,1)+lamdak*Fgrad(1,1),x0(2,1)+lamdak*Fgrad(2,1));                 
    end
  end
  if Max==1
      if fl>fm                         
       bk=miuk
       miuk=lamdak;                  
       fm=fl;                       
       lamdak=alpha*ak+(1-alpha)*bk; 
       fl=f(x0(1,1)+lamdak*Fgrad(1,1),x0(2,1)+lamdak*Fgrad(2,1));                 
          
    elseif fl<fm                    
      ak=lamdak;                    
       lamdak=miuk;                  
       fl=fm;                        
       miuk=(1-alpha)*ak+alpha*bk;   
       fm=f(x0(1,1)+miuk*Fgrad(1,1),x0(2,1)+miuk*Fgrad(2,1));                   
    end   
  end
      
    D(iter,:)=[ak lamdak miuk bk]; 
%     figure(iter)
%     plot(lamdak,fl,'*b',miuk,fm,'*r')  
%     hold on
    
    
end 
alpha1=(lamdak+miuk)/2;
