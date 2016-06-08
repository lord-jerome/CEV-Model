## Black-Scholes Function
BS <-function(S, K, t, r, sig){
  d1 <- (log(S/K) + (r + sig^2/2)*T) / (sig*sqrt(T))
  d2 <- d1 - sig*sqrt(T)
  value <- S*pnorm(d1) - K*exp(-r*T)*pnorm(d2)
  return(value)
}

Implied_Volatility <- function(Market_Price, S, K, t, r){
  sig <- 0.2
  sig.up <- 2
  sig.down <- 0.0001
  count <- 0
  err <- BS(S, K, t, r, sig) - Market_Price 
  while(abs(err) > 0.00001 && count<100000){
    if(err < 0){
      sig.down <- sig
      sig <- (sig.up + sig)/2
    }
    else{
      sig.up <- sig
      sig <- (sig.down + sig)/2
    }
    err <- BS(S, K, T, r, sig) - Market_Price
    count <- count + 1
  }
  
  ## return NA if counter hit 1000
  if(count==100000){
    return(NA)
  }
  else{
    return(sig)
  }
}

