library(ggplot2)
library(viridis)
library(wesanderson)
library(MASS)
#матожидание
E<- function(A){#n-количество признаков (x и у в данном случае)
  n<-dim(A)[2]
  ans<-c()
  for (i in 1:n){
    ans[i]<-mean(A[,i]) #равномерное распределение
  }
  
  return (ans) 
}
### work
#e<-E(iris[,3:4])
#e 

D<- function(A,N){ #N-количество всех элементов в классе
  n<-dim(A)[2]
  p<-1/N
  a1<-c()
  a2<-c()
  ans<-c()

    for (i in 1:N){
      a1[i]<-(A[i,1])^2*p
      a2[i]<-(A[i,1]*p)
    }
  ans[1]<-sum(a1)-(sum(a2))^2
  for (i in 1:N){
    a1[i]<-(A[i,2])^2*p
    a2[i]<-(A[i,2]*p)
  }
  ans[2]<-sum(a1)-(sum(a2))^2
  return (ans) 
}
Bayes<-function(data,E,D){#n-количество признаков (x и у в данном случае)
  
  ans<-c()
  data_new<-sqrt((data[1])^2+(data[2])^2)
  D_new<-c()
  E_new<-c()
  for (i in 1:3){
    D_new[i]<-sqrt((D[i,1])^2+(D[i,2])^2)
    E_new[i]<-sqrt((E[i,1])^2+(E[i,2])^2)
  }
  for (j in 1:3){
    
      ans[j]<-1/sqrt(2*pi*D_new[j])*(exp(-(data_new-E_new[j])^2/(2*D_new[j])))
    
  }
  return (ans) 
}
NN<-function(lambda, p){
  lnp1<-0
  lnp2<-0
  answer<-c(0,0,0)
 
  answer[1]<-log((1/3)*lambda[1])+log(p[1])
  answer[2]<-log((1/3)*lambda[2])+log(p[2])
  answer[3]<-log((1/3)*lambda[3])+log(p[3])
  
  return (which.max(answer))
}

colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)
im <- seq(1, 7, length.out = 100)
jm <- seq(0, 3, length.out = 50)
m<-matrix(0,3,2)
  m[1,]<-E(iris[1:50,3:4])
  m[2,]<-E(iris[51:100,3:4])
  m[3,]<-E(iris[101:150,3:4])
d<-matrix(0,3,2)
  d[1,]<-D(iris[1:50,3:4],50)
  d[2,]<-D(iris[51:100,3:4],50)
  d[3,]<-D(iris[101:150,3:4],50)


p<-c()
lambda<-c(1,1,1)
colo <- c("1" = "coral1", "2" = "chartreuse", "3" = "deepskyblue")
  for (i in 1:100){# 100
     for (j in 1:50){#50
     z <- c(im[i], jm[j])
     p<-Bayes(z,m,d)
     color<-NN(lambda,p)
    color
     #print(class1)
     #asd[i,] <- c(im[i], jm[j], class1)
     points(im[i], jm[j], asp = 1,bg = colo[color], col=colo[color]) 
     }
 }


