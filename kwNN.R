Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
kwNN <- function(xl,z,k,q){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 # столбцы 
    dist <-c(0)
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
   
    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z[,1:n]))
    }
    #сортировка выборки по расстоянию
    orderedXl <- xl[order(dist), ]
    
    for (c in names(colors)){ 
        for (i in 1:k){            
            if(orderedXl[i,3]==c){
                colors[c] <- colors[c]+q^i # взвешенная сумма для k ближайших соседей
            }
            
        }
        
        
    }
    #print(colors)
    return(names(which.max(colors)))
   
}
LOO <- function(a){
    len <- dim(a)[1]
    ans <- c()
    sum <- 0
     for (j in 1:len){ # paccматриваем всех соседей
        sum <- 0
        for (i in 1:len){  # рассматриваем  случайные данные из iris 
            z <- a[i, 1:2] # координаты
            cl <- kwNN(a[-i,], z,6, (j/10)) # применяем метод ближайших соседей
            # если классы не совпадают, то прибавляем  1      
            if (a[i, 3] != cl){
                
                sum <- sum + 1
            }   
              
    
        }       
        ans <- c(ans, sum/len)  #записываем вероятность появления ошибки при каждом k (число соседей)    
        #jk <- j
    }
    #print(min(ans))
    for (j in 1:10){
        if (ans[j]==min(ans)){
            kj <- j
        }
    }
    print(kj)
    print(ans)
    plot(1:len,ans, type="l")
    
}
colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")

plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)
z <- iris[67,3:5]
xl <- iris[-67, 3:5]
a <- iris[,3:5]
#k <- readline(prompt = "k = ")
#kwNN(xl,z,6,0.1)
LOO(a)
#class1 <- kwNN(xl,k)
#points(z[1], z[2], pch = 24, bg = colors[class1])
