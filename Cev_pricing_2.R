# shape= u
# scale = 1

Call <- function(s, K, t, r, sig){
  z = 2*r*exp(r*t)*s/(sig^2*(exp(r*t)-1))
  w = 2*r*K/(sig^2*(exp(r*t)-1))
  temp1 = 0
  temp2 = 0
  for (n in 1:100000){
    temp1 = temp1 + dgamma(z,shape=n,scale=1)*pgamma(w,shape =n+1,scale =1,lower.tail=FALSE)
    temp2 = temp2 +dgamma(z,shape=n+1,scale=1)*pgamma(w,shape =n,scale =1,lower.tail=FALSE)
  }
  temp1 = temp1*s
  temp2 = temp2*exp(-r*t)*K
  
  return(temp1 - temp2)
}
Call_strike_1 <- function(K){
  sigma = 0.2
  t = 1
  x = 100
  r = 0.001
  return(Call(x, K,t,r,sigma))
}
Call_strike_10 <- function(K){
  sigma = 0.2
  t = 10
  x = 100
  r = 0.001
  return(Call(x, K,t,r,sigma))
}
Call_strike_30 <- function(K){
  sigma = 0.2
  t = 30
  x = 100
  r = 0.001
  return(Call(x, K,t,r,sigma))
}
Call_strike_60 <- function(K){
  sigma = 0.2
  t = 60
  x = 100
  r = 0.001
  return(Call(x, K,t,r,sigma))
}
Call_strike_90 <- function(K){
  sigma = 0.2
  t = 90
  x = 100
  r = 0.001
  return(Call(x, K,t,r,sigma))
}
Call_strike_180 <- function(K){
  sigma = 0.2
  t = 180
  x = 100
  r = 0.001
  return(Call(x, K,t,r,sigma))
}
Call_strike_365 <- function(K){
  sigma = 0.2
  t = 365
  x = 100
  r = 0.001
  return(Call(x, K,t,r,sigma))
}
Implied_vol_m_1 <- function(K,Price){
  sigma = 0.2
  t = 1
  x = 100
  r = 0.001
  return(Implied_Volatility(Price, x,K, t,r))
}
Implied_vol_m_10 <- function(K,Price){
  sigma = 0.2
  t = 10
  x = 100
  r = 0.001
  return(Implied_Volatility(Price, x,K, t,r))
}
Implied_vol_m_30 <- function(K,Price){
  sigma = 0.2
  t = 30
  x = 100
  r = 0.001
  return(Implied_Volatility(Price, x,K, t,r))
}
Implied_vol_m_60 <- function(K,Price){
  sigma = 0.2
  t = 60
  x = 100
  r = 0.001
  return(Implied_Volatility(Price, x,K, t,r))
}
Implied_vol_m_90 <- function(K,Price){
  sigma = 0.2
  t = 90
  x = 100
  r = 0.001
  return(Implied_Volatility(Price, x,K, t,r))
}
Implied_vol_m_180 <- function(K,Price){
  sigma = 0.2
  t = 180
  x = 100
  r = 0.001
  return(Implied_Volatility(Price, x,K, t,r))
}
Implied_vol_m_365 <- function(K, Price){
  sigma = 0.2
  t = 365
  x = 100
  r = 0.001
  return(Implied_Volatility(Price, x,K, t,r))
}

#-0.05 <= mu <= 0.2 
#0.05 <= sigma <= 0.2
#T entre 0.25 et 1 an
#K entre 0.8S0 et 1.2S0
Strike <-  seq(0.5,2,by = 0.1)*100

Calld <- sapply(Strike, Call_strike_1)
Sigma <- mapply(Implied_vol_m_1,Strike, Calld)
Sigma_data = data.frame("1j" = Sigma)

Calld <- sapply(Strike, Call_strike_10)
Sigma <- mapply(Implied_vol_m_10,Strike, Calld)
Sigma_data = data.frame(Sigma_data,"10j" = Sigma)

Calld <- sapply(Strike, Call_strike_30)
Sigma <- mapply(Implied_vol_m_30,Strike, Calld)
Sigma_data = data.frame(Sigma_data,"1m" = Sigma)

Calld <- sapply(Strike, Call_strike_60)
Sigma <- mapply(Implied_vol_m_60,Strike, Calld)
Sigma_data = data.frame(Sigma_data, "2m" = Sigma)

Calld <- sapply(Strike, Call_strike_90)
Sigma <- mapply(Implied_vol_m_90,Strike, Calld)
Sigma_data = data.frame(Sigma_data, "3m" = Sigma)

Calld <- sapply(Strike, Call_strike_180)
Sigma <- mapply(Implied_vol_m_180,Strike, Calld)
Sigma_data = data.frame(Sigma_data, "6m" = Sigma)

Calld <- sapply(Strike, Call_strike_365)
Sigma <- mapply(Implied_vol_m_365,Strike, Calld)
Sigma_data = data.frame(Sigma_data, "1an" = Sigma)

yrange =  floor(range(Sigma_data)*10)/10
yrange[2] = yrange[2] +0.1
plot(Strike, Sigma_data$X1j, ylim = yrange, cex = 0.1, type = 'l', ylab = "Sigma")
points(Strike, Sigma_data$X10j, cex = 0.1, type = 'l', col = 'darkmagenta')
points(Strike, Sigma_data$X2m, cex = 0.1, type = 'l', col = 'red')
points(Strike, Sigma_data$X3m, cex = 0.1, type = 'l', col = 'blue')
points(Strike, Sigma_data$X6m, cex = 0.1, type = 'l', col ='green')
points(Strike, Sigma_data$X1an, cex = 0.1, type = 'l', col = 'darkgoldenrod4')
abline(v=100, lty =2, cex = 3)
legend("topright", # places a legend at the appropriate place 
       c("1j","10j","2m", "3m", "6m", "1an"), # puts text in the legend 
       lty=c(1,1,1,1,1,1), # gives the legend appropriate symbols (lines)
       cex = 0.75,
       lwd=c(2,2,2,2,2,2),col=c("black","darkmagenta", "red","blue","green","darkgoldenrod4"))

