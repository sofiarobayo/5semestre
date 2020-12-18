function [theta] = gradientDescent(X, y, theta, alpha, iterations)
         m = length(y);
         delta=zeros(2,1);
         for iter =1:1:iterations
             for i=1:1:m
                 delta(1,1)= delta(1,1)+( X(i,:)*theta - y(i,1))  ;
                 delta(2,1)=delta(2,1)+ (( X(i,:)*theta - y(i,1))*X(i,2)) ;
             end
             theta= theta-( delta*(alpha/m) );
           MetodoAurea(X,y,theta)
         end
end
