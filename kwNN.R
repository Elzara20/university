Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
KwNN <- function(xl,z,k,q){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 # столбцы 
    dist <-c(0)
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
   
    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z[,1:n]))
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
Sorted <- function(xl, z){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 #  столбцы
    dist <-c(0)

    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z[1:n]))
    }
    #сортировка выборки по расстоянию
    OrderedXl <- xl[order(dist), ]
    return(OrderedXl)
}
LOO <- function(a){
    len <- dim(a)[1]
    ans <- c()
    sum <- 0
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    for (j in 1:len){# рассматриваем  случайные данные из iris 
        sum <- 0
        z <- a[j, 1:2] # координаты
        qw <- Sorted(a[-j,1:3], z)

        for (i in 1:len){  # paccматриваем всех соседей
           
            #cl <- KwNN(a[-j,], z,6, (i/len)) # применяем метод ближайших соседей
            for (c in names(colors)){ # имена классов
                for (l in 1:6){     # соседи                       
                        colors[qw[l,3]] <- colors[qw[l,3]]+(i/len)^l # взвешенная сумма для k ближайших соседей
                              
                }     
            }    
    # return(names(which.max(colors)))
            # если классы не совпадают, то прибавляем  1      
            if (a[j, 3] != names(which.max(colors))){
                
                sum <- sum + 1
            }   
              
    
        }       
        ans <- c(ans, sum/len)  #записываем вероятность появления ошибки при каждом k (число соседей)    
  
    }
    print(min(ans))
    for (j in 1:10){
        if (ans[j]==min(ans)){
            kj <- j
        }
    }
    print(kj)   
}
colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")
a <- iris[,3:5]
LOO(a)
