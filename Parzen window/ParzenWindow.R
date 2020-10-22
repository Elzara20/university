Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
Sorted <- function(xl, z){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 #  столбцы
    dist <-matrix(0,l,2)

    for (i in 1:l){
        dist[i, ] <- c(Euclid(xl[i, 1:n], z[1:n]), xl[i,n+1])
    }

    #сортировка выборки по расстоянию
     OrderedXl <- dist[order(dist[, 1]), ]
   
     return(OrderedXl)
    
}
RectK <- function(dist) {
  if (abs(dist) <= 1) {
    return (0.5)
  } else {
    return (0)
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

Parzen <- function(xl, z, h){
    len <- dim(xl)[1]
    n <- dim(xl)[2]
    w <- c()
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    qw <- Sorted(xl[,1:3], z)

    for (i in 1:len){ 
      r<-qw[i,2]/h
      colors[qw[i,3]] <- colors[qw[i,3]]+RectK(r) 
    }   
    return(names(which.max(colors)))
}
LOO <- function(a){
    len <- dim(a)[1]
    #n <- dim(a)[2]
    ANS <- c()
    K<-0
    
    h_seq <- seq(0.1, 2, 0.1)
    for (i in 1:length(h_seq)){
        ANS[i]<-0
    }
    
    for (j in 1:len){ # paccматриваем случайные данные из iris
        z <- a[j,1:3] # координаты
        qw <- Sorted(a[-j,1:3], z)
    
        for (hi in 1:length(h_seq)){  
        colors <- c("setosa"=0.0,"versicolor"=0.0,"virginica"=0.0)
        for (i in 1:(len-1)){
                r<-qw[i,1]/h_seq[hi]
                colors[qw[i,2]] <- colors[qw[i,2]]+GaussK(r) # взвешенная сумма для k ближайших соседей   
             }

            if (a[j, 3] != names(which.max(colors))){             
                ANS[hi] <- ANS[hi]+1                                 
            }
           
        }     
    }
   
    
    K <- which.min(ANS)    
    
    
    plot(h_seq, ANS/length(h_seq), xlab="Ширина окна", ylab="Вероятность ошибки", type="l", main ="Оптимальное h  для Гауссовского ядра")
    points (K/10,ANS[K]/length(h_seq), pch = 21, bg = "red", col = "red",asp = 1)
    label = paste0("h = ", K/10, "\n")
    text(K/10,ANS[K]/length(h_seq), labels = label, pos = 4)
}
a <- iris[, 3:5]
LOO(a)

