library(ggplot2)
library(viridis)
library(wesanderson)
library(MASS)

E<- function(A){
  return (mean(A))
}
Cov<- function(A, m1, m2){
  ans<-c()
  for (i in 1:(dim(A)[1])){
    ans[i]<-(A[i,1]-m1)*(A[i,2]-m2)
  }
  
  
  return(sum(ans, na.rm=TRUE))
}
Density<- function(A, m1,m2, d1,d2, d12,r){
 
  
  
  
  ans<-(1/(2*pi*d12*sqrt(1-r^2))*exp(-1/2*((A[1]-m1)^2/(d1*(1-r^2))-(2*r*(A[1]-m1)*(A[2]-m2))/(d12*(1-r^2))+(A[2]-m2)^2/(d2*(1-r^2)))))
  
  print('ans')
  print(ans)
  #print("+++++++++++++++++++++++++++++++++++")
  return(ans)
}
Expectation<- function(A, u, n1,n2){
  N<-n1+n2 #всего точек
  mu1 <- c(5,6)
  mu2 <- c(-5,-6)
  Sigma1 <- matrix(c(15,1,1,15),2)
  Sigma2 <- matrix(c(51,9,9,54),2)
  bivn1 <- mvrnorm(n1, mu = mu1, Sigma = Sigma1 )    #многомерное распределение точек классов
  bivn2 <- mvrnorm(n2, mu = mu2, Sigma = Sigma2 )
  #print(xl1)
  plot(bivn1, col="red",asp=1)
  points(bivn2, col="green",asp=1)
  #print("______________________________________")
  m1<-E(bivn1[,1]) #матожидание х
  m2<-E(bivn1[,2]) #матожидание y
  m1_2<-E(bivn2[,1]) #матожидание х
  m2_2<-E(bivn2[,2]) #матожидание y
  #print("m1, m2")
  #print(m1)
  #print(m2)
  d_1<-c()
  d_2<-c()
  
  for (i in 1:(dim(bivn1)[1])){
    d_1[i]<-(bivn1[i,1]-m1)^2 # дисперсия х
    d_2[i]<-(bivn1[i,2]-m2)^2 # дисперсия у
  }
  d_12<-c()
  d_22<-c()
  
  for (i in 1:(dim(bivn1)[1])){
    d_12[i]<-(bivn2[i,1]-m1_2)^2 # дисперсия х
    d_22[i]<-(bivn2[i,2]-m2_2)^2 # дисперсия у
  }
  #print("d_1")
  #print(d_1)
  #print(d_2)
  d1<-E(d_1)
  d2<-E(d_2)
  d12<-Cov(bivn1,m1, m2)
  r<-d12/(d1*d2)
  d1_2<-E(d_12)
  d2_2<-E(d_22)
  d12_2<-Cov(bivn2,m1_2, m2_2)
  r_2<-d12_2/(d1_2*d2_2)
  P1<-n1/N
  P2<-n2/N
  x <- seq(-10, 10, by = 0.1)
  y <- seq(-10, 10, by = 0.1)
  XY<-cbind(x,y)
  grid1<-c()
  grid2<-c()
  for (j in 1:(dim(XY)[1])){
  p1<-Density(XY[j,],m1,m2,d1,d2,d12,r)
  p2<-Density(XY[j,],m1_2,m2_2,d1_2,d2_2,d12_2,r_2)
  print("p1")
  print(p1)
  l_p<-c()
  l_p2<-c()
  for (i in 1:(dim(bivn1)[1])){
    l_p2[i]<-log(p2[i])
    l_p[i]<-log(p1[i])
   
  }
  grid1[j] <- log(P1)+sum(l_p, na.rm=TRUE)
  grid2[j] <- log(P2)+sum(l_p2, na.rm=TRUE)
  
}
  print(grid1)
  print(grid2)
  points(grid2,grid1, col=viridis(30),asp=1)
  
}
A<-matrix(c(3,1,1,1),2,2)
u<-c(1,2)

Expectation(A,u,200,200)

