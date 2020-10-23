Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
Sorted <- function(xl){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 #  столбцы
    dist <-matrix(0,l,l)

    for (i in 1:l){
        for (j in 1:l){
            dist[i,j] <- Euclid(xl[j, 1:n], xl[i,1:n])
        }
    }

    #  OrderedXl <- dist[order(dist[, 1]), ]
    # print(OrderedXl)
     #return(OrderedXl)
    return(dist)
}
RectK <- function(dist) {
  if (abs(dist) <= 1) {
    return (0.5)
  } else {
    return (0.0)
  }
}
Potetial <- function(xl, z, h,p){
    len <- dim(xl)[1]
    n <- dim(xl)[2]
    w <- c()
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    qw <- Sorted(xl[,1:3], z)
    for (i in 1:len){ 
        r<-qw[i,1]/h
        colors[qw[i,2]] <- colors[qw[i,2]]+p[i]*RectK(r) # взвешенная сумма для k ближайших соседей
                      
    }     
    
    return(names(which.max(colors)))  

}
LOO <- function(a){
    colo <- c("setosa" = "coral1", "versicolor" = "chartreuse", "virginica" = "deepskyblue")
    len <- dim(a)[1]
    n <- dim(a)[2]
    ANS <- c()
    K<-0
    eps<-10
    err<-eps+0.1
    h<-0.4 #оптимальное значение
    
    h_seq <- seq(0.1, 2, 0.1)
    for (i in 1:length(h_seq)){
        ANS[i]<-0
    }
    p<-c()
    for (i in 1:len){
        p[i]<-0
    }
    qw<- matrix(0, len, len)
    qw <- Sorted(a)
    #print(qw)
    while (err>eps && err<11){ #!! нужно ограничение для err
        
        for (j in 1:len){ # paccматриваем случайные данные из iris
            # z <- a[j,1:3] # координаты
            # qw <- Sorted(a[-j,1:3], z)
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:len){
                r<-qw[j,i]/h
                colors[a[i,3]] <- colors[a[i,3]]+p[i]*RectK(r) # взвешенная сумма   
            }
                if (a[j, 3] != names(which.max(colors)) ){  
                    p[j] <- p[j]+1          
                                            
                }
            # }
        }
                
            
                    
        
        for (j in 1:len){ # paccматриваем случайные данные из iris       
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:(len-1)){                
                r<-qw[j,i]/h
                colors[a[i,3]] <- colors[a[i,3]]+p[i]*RectK(r) # взвешенная сумма   
            }
                
            if (a[j, 3] != names(which.max(colors))){   
                err<-err+1                                
            }
        }
        
            
                  
    
    # err<-0
    # for (i in 1:len){
    #     if (a[i, n] != Potetial(a[-i,], a[i,], 0.4, p)){
    #         err<-err+1
    #     }
    # }
    }
    print(p)
    plot(iris[, 3:4], pch = 21, bg = colo[iris$Species], col = colo[iris$Species], asp = 1)
   for(i in 1:len){
        if (p[i]!=0){
            points(iris[i,3],iris[i,4],bg=colo[iris[i,5]], col=colo[iris[i,5]], asp = 1, cex=p[i]+5)
        }
}
    # points (K/10,ANS[K]/length(h_seq), pch = 21, bg = "red", col = "red",asp = 1)
    # label = paste0("h = ", K/10, "\n")
    # text(K/10,ANS[K]/length(h_seq), labels = label, pos = 4)
}

a <- iris[, 3:5]
LOO(a)

