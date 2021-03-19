Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
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
    n <- dim(a)[2]
    ANS <- c()
    K<-0
 
    
    for (i in 1:(len-1)){
        ANS[i]<-0
    }
     for (j in 1:len){ # paccматриваем случайные данные из iris
        sum <- 0
        z <- a[j,1:3] # координаты
        qw <- Sorted(a[-j,1:3], z)
        for (i in 1:(len-1)){  # рассматриваем всех соседей         
            counts <- table(qw[1:i,3])
            cl <- which.max(counts)
          
            if (a[j, 3] != names(cl)){                
                ANS[i] <- ANS[i]+1                                 
            } 
        } 
    }
   
    # print(ANS)
    K <- which.min(ANS)    
    print(K)  
    plot(1:(len-1), ANS/len, xlab="Количество соседей", ylab="Вероятность ошибки", type="l")
    points (K,ANS[K], pch = 21, bg = "blue", col = "blue", asp = 1)
}
a <- iris[, 3:5]
LOO(a)
#Далее следует правильный код, который работает 2 часа. Наверху оптимизированный код


# Euclid <- function(u, v){
#     return(sqrt(sum((u - v)^2)))
# }
# KNN <- function(xl, z, k){
#     l <- dim(xl)[1] # строки
#     n <- dim(xl)[2] - 1 #  столбцы
#     dist <-c(0)

#     for (i in 1:l){
#         dist[i] <- c(Euclid(xl[i, 1:n], z))
#     }
#     #сортировка выборки по расстоянию
#     OrderedXl <- xl[order(dist), ]
#     #создаем таблицу
#     counts <- table(OrderedXl[1:k, n +1])
#     # определение наиболее часто появляющегося класса
#     class <- which.max(counts)
#     # возвращаем цвет наиболее близкого класса
#     return (names(class))
# }
# LOO <- function(a){
#     len <- dim(a)[1]
#     ans <- c()
#     sum <- 0
#      for (j in 1:len-1){ # paccматриваем всех соседей
#         sum <- 0
#         for (i in 1:len){  # рассматриваем  случайные данные из iris 
#             z <- a[i, 1:2] # координаты
#             cl <- KNN(a[-i,], z, j) # применяем метод ближайших соседей
#             # если классы не совпадают, то прибавляем  1      
#             if (a[i, 3] != cl){                
#                 sum <- sum + 1
#             }              
    
#         }       
#         ans <- c(ans, sum/len)  #записываем вероятность появления ошибки при каждом k (число соседей)    
#     }
#     plot(1:(len-1),ans, type="l")
#     kj <- 0
#      for (j in 1:10){
#         if (ans[j]==min(ans)){
#             kj <- j
#         }
#     }
#     print(kj)
    
# }
# a <- iris[, 3:5]
# LOO(a)
