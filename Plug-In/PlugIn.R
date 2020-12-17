library(ggplot2)
library(viridis)
library(wesanderson)
library(MASS)
# это метод Бокса—Мюллера для образования нормированной выборки, смысла почти не имеет, есть встроенная функция
Method <-function(){
  x<-c()
  y<-c()
  x1<-c()
  y1<-c()
  #s<-c()
  for (i in 1:200){
    x[i]<--2*log(runif(1, 0.0001, 1.0))*cos(2*pi*(runif(1, 0.0001, 1.0)))
    y[i]<--2*log(runif(1, 0.0001, 1.0))*sin(2*pi*(runif(1, 0.0001, 1.0)))
  }
  for (i in 1:200){
    
    x_rand<-runif(1, -1.0, 1.0)
    y_rand<-runif(1, -1.0, 1.0)
    s<-x_rand^2+y_rand^2
    while (s>1 || s==0){
      x_rand<-runif(1, -1.0, 1.0)
      y_rand<-runif(1, -1.0, 1.0)
      s<-x_rand^2+y_rand^2
    }
    x1[i]<-(x_rand)*sqrt((-2*log(s))/s)
    y1[i]<-(y_rand)*sqrt((-2*log(s))/s)
  }
  log(s)
  mu <- c(5, 5);
  sigma <- diag(c(2, 2));
  df <- as.data.frame(mvrnorm(1000, mu = mu, Sigma = sigma));
  colnames(df) <- c("x", "y");
  mu1 <- c(1, 1);
  sigma1 <- diag(c(4, 4));
  df1 <- as.data.frame(mvrnorm(1000, mu = mu1, Sigma = sigma1));
  colnames(df1) <- c("x1", "y1");
  #plot(df/2+1)
  #points(df1/4,asp = 1, col="green")
  plot(x1+6, y1+6, col = "red", asp = 1)
  points(df, asp = 1, col="green") 
}
Method()


# сфера - определитель ковариационной матрицы равен 1, а коэффициент корреляции r=0
A<-matrix(c(16,0,0,16),2,2)

NormalDistribution(A)
# наклоненный эллипс - определитель ковариационной матрицы>1, коэффициент корреляции r!=0
A1<-matrix(c(9,1,1,6),2,2)
NormalDistribution(A1)
#эллипс - определитель ковариационной матрицы>1, коэффициент корреляции r=0
A2<-matrix(c(11,0,0,7),2,2)
NormalDistribution(A2)

col<-2
row<-1000
mu <- c(10, 5);
sigma <- matrix(c(9,0,0,6),2,2)
solve(sigma)
df <- data.frame(mvrnorm(row, mu = mu, Sigma = sigma))/3;
colnames(df) <- c("x", "y");
mu1 <- c(4, 5);
sigma1 <- matrix(c(14,0,0,14),2,2)
solve(sigma1)
solve(sigma1)-solve(sigma)
det(solve(sigma1)-solve(sigma))
df1 <- data.frame(mvrnorm(row, mu = mu1, Sigma = sigma1))/4+2.05;
colnames(df1) <- c("x1", "y1");



mu_1<-matrix(0,1,col)
mu_1<-colMeans(df)
mu_2<-matrix(0,1,col)
mu_2<-colMeans(df1)


s_1<-matrix(0,col,col)
df<-as.matrix(df)
for (i in 1:row){  
  s_1 <- s_1 + ((df[i,]- mu_1) %*% t(df[i,] - mu_1))     
}
s_1<-s_1/(row)

s_2<-matrix(0,col,col)
df1<-as.matrix(df1)
for (i in 1:row){         
  s_2 <- s_2 + ((df1[i,] - mu_2) %*% t(df1[i,] - mu_2))     
}
s_2<-s_2/(row)






x <- seq(-10, 10, by = 0.1)
y <- seq(-10, 10, by = 0.1)


solve(s_2)
solve(s_1)
final<-matrix(0,col,col)
final<-solve(s_2)-solve(s_1)
discriminant<-det(final)
final2<-matrix(0,col,1)
t(mu_2)%*%s_2
final2<-solve(s_2)%*%mu_2-solve(s_1)%*%mu_1

f <- log(abs(det(s_2))) - log(abs(det(s_1))) + t(mu_2) %*% solve(s_2) %*% mu_2 - t(mu_1) %*% solve(s_1) %*% mu_1  
if (discriminant>0){
  str<-"эллипса"
} else if (discriminant<0){
  str<-"гиперболы"
} else{
  str<-"параболы"
}
grid <- outer(
  x,
  y,
  function(x, y) 
    final[1,1]*x^2+final[2,2]*y^2+2*final[1,2]*x*y-2*final2[1,1]*x-2*final2[2,1]*y+f[1]
  
)
headline<-paste0("Кривая имеет вид ", str)
plot(df,main=headline)
points(df1,asp = 1, col="green")
contour(x,y,grid, levels=0, drawlabels=FALSE, lwd = 3, col = "red", add = TRUE,  main =headline) 


