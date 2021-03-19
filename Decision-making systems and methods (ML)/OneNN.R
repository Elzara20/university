Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
OneNN <- function(xl, z){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2] - 1 #  столбцы
    dist <-c(0) #расстояние 
    # вычисление расстояния 
    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z))
    }
    # сортировка выборки по расстоянию
    OrderedXl <- xl[order(dist), ]
    # определяем к какому классу принадлежит самый первый сосед
    class <- OrderedXl[1,n+1]  
    return (class)
}
colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)
z <- c(runif(1, 1, 7), runif(1, 0.1, 2.5))
xl <- iris[, 3:5]

class <- OneNN(xl, z)
points(z[1], z[2], pch = 24, bg = colors[class])
