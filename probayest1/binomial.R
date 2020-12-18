VariableAleatoriaBinomial<- function(n,p){
  if(p<0 | p>1){
    print('no cumple que 0<=p<=1')
    return(0)
  }
  vec=c()
  for(k in 0:n){
    Px <- (factorial(n)/factorial(k)*factorial(n-k))(p^k)*(1-p)^(n-k)
    vec[k] <- Px
  }
  return(vec)
}
