Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}

Sorted <- function(xl, z){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 #  столбцы
    dist <-c()

    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z))
    }
   
    return(dist)
    
}
RectK <- function(dist) {
  if (abs(dist) <= 1) {
    return (0.5)
  } else {
    return (0.0)
  }
}
SquareK <- function(dist) {
  if (abs(dist) <= 1) {
    return ((15/16)*(1-dist^2)^2)
  } else {
    return (0)
  }
}
EpanechnikovK <- function(dist) {
  if (abs(dist) <= 1) {
    return ((3/4)*(1-dist^2))
  } else {
    return (0)
  }
}
TriangleK <- function(dist) {
  if (abs(dist) <= 1) {
    return (1-abs(dist))
  } else {
    return (0)
  }
}
GaussK <- function(dist) {
  return ((2*pi)^(-0.5)*exp(-0.5*(dist^2)))
}
Potetial <- function(xl, z, h,p){
    len <- dim(xl)[1]
    n <- dim(xl)[2]
    w <- c()
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    qw <- Sorted(xl[,1:3], z)
    for (i in 1:len){ 
        r<-qw[i,1]/h
        colors[qw[i,2]] <- colors[qw[i,2]]+p[i]*GaussK(r) # взвешенная сумма для k ближайших соседей
                      
    }     
    
    return(names(which.max(colors)))  

}
LOO <- function(a){
    colo <- c("setosa" = "coral1", "versicolor" = "chartreuse", "virginica" = "deepskyblue")
    len <- dim(a)[1]
    n <- dim(a)[2]
  
    err<-1
    h<-0.1#оптимальное значение
    
    p<-c()
    for (i in 1:len){
        p[i]<-0
    }
    qw<- c()
    
    while (err<30){ #!! нужно ограничение для err
      while(TRUE){
        #до тех пор пока находим ошибочные классы 
        z <- sample(1:len, 1)
        qw <- Sorted(a[,1:3], z)
                        
        colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
        for (i in 1:len){
          r<-qw[i]/h             
          colors[z] <- colors[z]+p[i]*GaussK(r) # взвешенная сумма   
        }
          
        if (a[z, 3] != names(which.max(colors))){  
          p[z] <- p[z]+1 
          break               
        }
      }
        z <- sample(1:len, 1)
        qw <- Sorted(a[,1:3], z)
        
            
        colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
        for (i in 1:len){
            r<-qw[i]/h             
            colors[z] <- colors[z]+p[i]*GaussK(r) # взвешенная сумма   
        }
        if (a[z, 3] != names(which.max(colors)) ){  
            err<-err+1                                                        
        }
           
    } 
    print(p)
    cnt<-0
    for (i in 1:len){
        if (p[i]>=2){
            cnt<-cnt+1
        }
    }
    message <- paste0("Потенциалы для Гауссовского ядра с ошибкой = ",round(cnt/len,5))
    plot(iris[, 3:4], pch = 21, bg = colo[iris$Species], col = colo[iris$Species], asp = 1, main =message)
    for(i in 1:len){
        if (p[i]!=0){
            points(iris[i,3],iris[i,4],bg=colo[iris[i,5]], col=colo[iris[i,5]], asp = 1, cex=p[i]+7)
        }
    }

}

a <- iris[, 3:5]
LOO(a)

