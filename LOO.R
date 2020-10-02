Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
KNN <- function(xl, z, k){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2] - 1 #  столбцы
    dist <-c(0)

    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z))
    }
    #сортировка выборки по расстоянию
    OrderedXl <- xl[order(dist), ]
    #создаем таблицу
    counts <- table(OrderedXl[1:k, n +1])
    # определение наиболее часто появляющегося класса
    class <- which.max(counts)
    # возвращаем цвет наиболее близкого класса
    return (names(class))
}
LOO <- function(a){
    len <- dim(a)[1]
    ans <- c()
    sum <- 0
     for (j in 1:len){ # paccматриваем всех соседей
        sum <- 0
        for (i in 1:len){  # рассматриваем  случайные данные из iris 
            z <- a[i, 1:2] # координаты
            cl <- KNN(a[-i,], z, j) # применяем метод ближайших соседей
            # если классы не совпадают, то прибавляем  1      
            if (a[i, 3] != cl){                
                sum <- sum + 1
            }              
    
        }       
        ans <- c(ans, sum/len)  #записываем вероятность появления ошибки при каждом k (число соседей)    
    }
    plot(1:len,ans, type="l")
    kj <- 0
     for (j in 1:10){
        if (ans[j]==min(ans)){
            kj <- j
        }
    }
    print(kj)
    
}
a <- iris[, 3:5]
LOO(a)
