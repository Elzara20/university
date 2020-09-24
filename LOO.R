Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
kNN <- function(xl, z, k){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2] - 1 #  столбцы
    dist <-c(0)

    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z))
    }
    #сортировка выборки по расстоянию
    orderedXl <- xl[order(dist), ]
    #частота появления определенного цвета
    counts <- table(orderedXl[1:k, n +1])
    # определение наиболее часто появляющегося класса
    class <- which.max(counts)
    # cat("CLASS=", class)
    # cat("Name= ", names(class))
    # возвращаем цвет наиболее близкого класса
    return (names(class))
}
LOO <- function(a){
    len <- dim(a)[1]
    ans <- c()
    sum <- 0
     for (j in 1:len-1){ # paccматриваем всех соседей
        sum <- 0
        for (i in 1:len){  # рассматриваем  случайные данные из iris 
            z <- a[i, 1:2] # координаты
            cl <- kNN(a[-i,], z, j) # применяем метод ближайших соседей
            # если классы не совпадают, то прибавляем  1      
            if (a[i, 3] != cl){
                
                sum <- sum + 1
            }   
              
    
        }       
        ans <- c(ans, sum/10)  #записываем вероятность появления ошибки при каждом k (число соседей)    
    }
    plot(1:10,ans, type="l")
    
}
a <- iris[sample(1:150,10),3:5] 
LOO(a)