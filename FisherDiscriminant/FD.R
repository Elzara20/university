library(ggplot2)
library(viridis)
library(wesanderson)
library(MASS)
col<-2
row<-1000
mu <- c(6, 4);
sigma <- matrix(c(9,0,0,1),2,2)
solve(sigma)
df <- data.frame(mvrnorm(row, mu = mu, Sigma = sigma))/3;
colnames(df) <- c("x", "y");
mu1 <- c(2, 1);
sigma1 <- matrix(c(2,0,0,3),2,2)
solve(sigma1)
solve(sigma1)-solve(sigma)
det(solve(sigma1)-solve(sigma))
df1 <- data.frame(mvrnorm(row, mu = mu1, Sigma = sigma1))/4+2.05;
colnames(df1) <- c("x1", "y1");



mu_1<-matrix(0,col,1)
mu_1<-colMeans(df)
mu_2<-matrix(0,col,1)
mu_2<-colMeans(df1)


s<-matrix(0,col,col)
df<-as.matrix(df)
for (i in 1:row){  
  s <- s + ((df[i,]- mu_1) %*% t(df[i,] - mu_1))     
}

df1<-as.matrix(df1)
for (i in 1:row){         
  s<- s + ((df1[i,] - mu_2) %*% t(df1[i,] - mu_2))     
}
s<-s/(row-col)






x <- seq(-10, 10, by = 0.1)
y <- seq(-10, 10, by = 0.1)
inv_s<-solve(s)
a<-solve(s)%*%(mu_2-mu_1)
b<-log(0.5)-0.5*t((mu_2-mu_1))%*%solve(s)%*%(mu_2-mu_1)



grid <- outer(
  x,
  y,
  function(x, y) 
    
    (a[2]*y+a[1]*x)+b[1]
   
  
)
headline<-paste0("Линейный дискриминант Фишера")
plot(df,pch = 22,bg = "yellow",main=headline)
points(df1,asp = 1,pch = 21,bg = "green")
contour(x,y,grid, levels=0, drawlabels=FALSE, lwd = 3, col = "red", add = TRUE,  main =headline) 

