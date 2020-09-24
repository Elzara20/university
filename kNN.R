Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
kNN <- function(xl, z, k){
    l <- dim(xl)[1]  # строки
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
    # возвращаем цвет наиболее близкого класса
    return (names(class))
}
colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)
z <- c(runif(1, 0.9, 7), runif(1, 0, 2.5))
xl <- iris[, 3:5]

k <- readline(prompt = "k = ")
class1 <- kNN(xl, z, k)
points(z[1], z[2], pch = 24, bg = colors[class1])