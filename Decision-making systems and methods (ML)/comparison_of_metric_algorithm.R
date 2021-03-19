Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
KNN <- function(xl, z, k){
    l <- dim(xl)[1]  # строки
    n <- dim(xl)[2] - 1 #  столбцы 
    dist <-c(0)

    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z))
    }
    orderedXl <- xl[order(dist), ]
    counts <- table(orderedXl[1:k, n +1])
    class <- which.max(counts)
    return (names(class))
}
KwNN <- function(xl,z,k,q){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 # столбцы 
    dist <-c(0)
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
   
    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z[1:n]))
    }
    #сортировка выборки по расстоянию
    orderedXl <- xl[order(dist), ]
    
    for (c in names(colors)){ # имена классов
        for (i in 1:k){     # соседи       
            if(orderedXl[i,3]==c){
                colors[c] <- colors[c]+q^i # взвешенная сумма для k ближайших соседей
            }           
        }     
    }    
    return(names(which.max(colors)))
   
}

KwNNforSTOLP <- function(xl,z,k,q){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 # столбцы 
    dist <-c(0)
    cnt<-0
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
     for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z[1:n]))
    }
    #сортировка выборки по расстоянию
    orderedXl <- xl[order(dist), ]
    
    for (c in names(colors)){ # имена классов
        
        for (i in 1:k){     # соседи    
        #print(orderedXl[i,3])  
            if(orderedXl[i,3]==c){
                colors[c] <- colors[c]+q^i # взвешенная сумма для k ближайших соседей
            }           
        }   
    
    }
    for (c in names(colors)){ # имена классов
         
        if(z[n+1]==c){
            return (colors[c])
        }           
            
    }  
}
KwNN1 <- function(xl,z,k,q,a){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 # столбцы 
    len <- dim(a)[1] # строки
    dist <-c(0)
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
   
    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z[1:n]))
    }
    #сортировка выборки по расстоянию
    orderedXl <- xl[order(dist), ]
    u<-0
    for (c in 1:len){ # имена классов
        for (i in 1:k){     # соседи       
            if(orderedXl[i,3]==a[c,3]){
                colors[a[c,3]] <- colors[a[c,3]]+q^i # взвешенная сумма для k ближайших соседей
                u<-1
            }          
        }     
    }    
    if (u==1){
        return(names(which.max(colors)))
    }else{
        return("white")
    }
   
}
GaussK <- function(dist) {
  return ((2*pi)^(-0.5)*exp(-0.5*(dist^2)))
}

Parzen <- function(xl, z, h){
    len <- dim(xl)[1]
    n <- dim(xl)[2]
    w <- c()
    dist <-matrix(0,len,2)
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    #qw <- Sorted(xl[,1:3], z)
    for (i in 1:len){
        dist[i, ] <- c(Euclid(xl[i, 1:(n-1)], z[1:(n-1)]), xl[i,n])
    }
    
    qw<-dist[order(dist[, 1]), ]


    for (i in 1:len){ 
      r<-qw[i,1]/h
      #print(r)
      colors[qw[i,2]] <- colors[qw[i,2]]+GaussK(r) 
    }   
    
      return (names(which.max(colors))) # Вернуть класс с максимальным весом
  
   
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
LOO <- function(a,xl,X){
    len <- dim(a)[1]
    l<-dim(xl)[1]
    ANS <- c()
    ANS1 <- c()
    ANS2 <- c()
    ANS3 <- c()
    ANS4 <- c()
    K<-0
    
    for (i in 1:len){
        ANS[i]<-0
        ANS1[i]<-0
        ANS2[i]<-0
        ANS3[i]<-0
        ANS4[i] <- 0
    }
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    for (j in 1:len){# рассматриваем  случайные данные из iris 
        sum <- 0
        z <- a[j, 1:3] # координаты
        if (z[3] != KwNN1(a[-j,1:3],z,6,1,xl)){                
            ANS[j] <- ANS[j]+1                                 
        } 
    } 
        print("done")
         for (j in 1:dim(X)[1]){# рассматриваем  случайные данные из iris 
        sum <- 0
        z <- X[j, 1:3]
        if (z[3] != KNN(X[-j,1:3],z[1:2],6)){                
            ANS1[j] <- ANS1[j]+1                                 
        } 
         }
        print("done1")
         for (j in 1:dim(X)[1]){# рассматриваем  случайные данные из iris 
        sum <- 0
        z <- X[j, 1:3]
        if (z[3] != KwNN(X[-j,1:3],z,6,1)){                
            ANS2[j] <- ANS2[j]+1                                 
        } 
         }
          for (j in 1:dim(X)[1]){# рассматриваем  случайные данные из iris 
        sum <- 0
        z <- X[j, 1:3]
       
        if (z[3] != Parzen(X[-j,1:3],z,0.1)){                
            ANS3[j] <- ANS3[j]+1                                 
        } 
          }
        print("done3")
       
    
    #}
        # ans <- c(ans, sum/len)  #записываем вероятность появления ошибки при каждом k (число соседей)    
  
   
    K <- length(which(ANS!=0))
    print(ANS)  
    print(K)
    K1 <- length(which(ANS1!=0))
    print(ANS1)  
    print(K1)
    K2 <- length(which(ANS2!=0))
    print(ANS2)  
    print(K2)
    K3 <- length(which(ANS3!=0))
    print(ANS3)  
    print(K3)
    # K4 <- length(which(ANS4!=0))
    kMas<-c(K,K1,K2,K3)
    barplot(height = kMas, xlab = "count of mistake", col = "green", main = "Difference between metric algorithms",names.arg=c("with STOLP", "KNN", "KwNN", "Parzen window"))

    #plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)
    
   
   
    
}
Sorted <- function(xl){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 #  столбцы
    dist <-matrix(0,l,l)

    for (i in 1:l){
        for (j in 1:l){
            dist[i,j] <- Euclid(xl[i, 1:n], xl[j,1:n])
        }
    }
    return(dist)
}
LOO_potetial <- function(a){
    colo <- c("setosa" = "coral1", "versicolor" = "chartreuse", "virginica" = "deepskyblue")
    len <- dim(a)[1]
    n <- dim(a)[2]
    
    err<-1
    h<-0.1 #оптимальное значение
    
   
    p<-c()
    for (i in 1:len){
        p[i]<-0
    }
   
    qw <- Sorted(a)
    #print(qw)
    while (err<30){ #!! нужно ограничение для err
      
        for (j in 1:len){ # paccматриваем случайные данные из iris            
            # for (k in 1:len){        
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:len){
                r<-qw[j,i]/h             
                colors[a[j,3]] <- colors[a[j,3]]+p[i]*GaussK(r) # взвешенная сумма                 
            }
            if (a[j, 3] != names(which.max(colors))){ 
                p[j] <- p[j]+1                          
            }
           
        }
        for (j in 1:len){ # paccматриваем случайные данные из iris
        
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:len){
                r<-qw[j,i]/h             
                colors[a[j,3]] <- colors[a[j,3]]+p[i]*GaussK(r) # взвешенная сумма                 
            }
            if (a[j, 3] != names(which.max(colors))){  
                err<-err+1               
                                            
            }
          
        }
    }
    print(p)
    return(p)
  
}

colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")
col <- c("setosa" = "orangered", "versicolor" = "green4", "virginica" = "deepskyblue4")
colo <- c("setosa" = 0.0, "versicolor" = 0.0, "virginica" = 0.0)
xl <- iris[, 3:5]
len <- dim(xl)[1]
n <- dim(xl)[2]
class1 <-c()
margin <- array(0.0,len);
wrong<-0
right<-0
k<-6
color<-c()
lo<-15
#вычисляем отступы 
for (i in 1:len){    
    z<-xl[-i,]
    right <- KwNNforSTOLP(z, xl[i,],k,1)
    wrong <- k-right
    margin[i] <- right-wrong  
    
}
# margin<-sort(margin)
# вычисления для графика
for (i in 1:len){
    if (margin[i]<0){
        color[i]<-'red'
    } else if (margin[i]>0 && margin[i]<round(k/2)){
        color[i]<-'green'
    } else {
        color[i]<-'green4'
    }
    
    
}

#barplot(height = margin, xlab = "margin", col = color, main = "Margin obtained by KwNN")

#stolp 
for (i in 1:len){
    if (margin[i]<0){ # отбрасываю шумовые выбросы
        xl<-xl[-i,]
        len<-len-1
    }
}
# берем по одному эталону из каждого класса
Standart <-iris[1:3, 3:5]
Standart[,1]<-0
Standart[,2]<-0

q<-1
for (i in 1:len){
    
    if (margin[i]==k && colo[xl[i,3]]==0){
        Standart[q,]<-xl[i,]
        q<-q+1
        colo[xl[i,3]]=1
        
    }
    
}


 k<-2

 margin1<-c()
vb<-2
while (dim(Standart)[1]!=len){
    wrong<-0
    right<-0
    for (i in 1:dim(Standart)[1]){
        margin1[i]<-0
    }
  for (i in 1:dim(Standart)[1]){ 
        zi<-sample(1:len, 1)  
        z<-xl[zi,]
        #print(z)
        right <- KwNNforSTOLP(Standart, z,k,1)
        #print(right)
        wrong <- k-right
        margin1[i] <- right-wrong       
    }
    
    #for (i in 1:dim(Standart)[1]){
        
        if (length(which(margin1<=0))<dim(Standart)[1]*0.1){ # отбрасываю шумовые выбросы
            print("YES")
            break
        }
        # print("NO")
        # Standart<-rbind(Standart,xl[i,])
    #     break
    # }
    Standart<-rbind(Standart,z)
  # xl<-xl[-zi,]
    vb<-vb+1
    
    
}
print("FINALLY")
print("__________________________________________________________________________________________")
 #mat1 <- matrix(data = st, nrow = length(st)/length(colo), ncol = length(colo), byrow = TRUE)
print(Standart)
# plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1, main ="STOLP")
# points(Standart[,1:2], pch=2,cex=2,bg = col[Standart[,3]], col=col[Standart[,3]]) 

LOO(xl,Standart,iris[, 3:5])