library(ggplot2)
library(kernlab)
library(e1071)
library(MASS)
c<-100
n<-50
mu <- c(9,3)
mu1 <- c(7, 0.1)
sigma <- matrix(c(3,0,0,0.1),2,2)
sigma1 <- matrix(c(1,0,0,6),2,2)
xl1 <- mvrnorm(n, mu, sigma)
xl2 <- mvrnorm(n, mu1, sigma1)
xl <- rbind(cbind(xl1, 1), cbind(xl2, -1))
plot(xl)

model_svm<- ksvm(x = xl[,1:2],y = xl[,3], type="C-svc", kernel = "vanilladot", C = c,prob.model=TRUE)
print(model_svm)
b <- b(model_svm)
coef(model_svm)
alphaindex(model_svm)
SVindex(model_svm)
w <- colSums(coef(model_svm)[[1]] * xl[alphaindex(model_svm)[[1]],-3])  
margins <- sapply(1:nrow(xl[,1:2]), function(i) (w %*% xl[i,1:2] - b) * xl[i,3])
margins
min_margin_index <- which.min(margins)
min_margin_index

norm <- sqrt(w%*%w)
color<-c()
#for (i in 1:200){
  #if (xl[i,3]==1){
   # color[i]<-"red"
 # }else{
   # color[i]<-"black"
 # }
#}
headline<-paste0("C = ", c)
plot(model_svm, data = xl[,1:2], main=headline)
y<-c()
y1<-c()
x <- seq(-100, 100, by = 0.1)
y<-b/w[1]*x-w[2]/w[1]
y<-w[2]/w[1]*x-b/w[1]
points(x/5,y/5,asp = 1,pch = 21,bg = "red")
points(-x/5,-y/5,asp = 1,pch = 21,bg = "red")
abline(b/w[1],-w[2]/w[1], lwd = 3)
