Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
kwNN <- function(xl, z, k){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2] - 1 # столбцы 
    dist <-c(0)
    weight1_setosa <- 0
    weight2_versicolor <- 0
    weight3_virginica <- 0

    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z))
    }
    #сортировка выборки по расстоянию
    orderedXl <- xl[order(dist), ]
    
    for (i in 1:k){
       
        if(orderedXl[i,3]=='setosa'){
            weight1_setosa=weight1_setosa+(1/dist[i])^2 # взвешенная сумма для класса 'setosa'
        }else if (orderedXl[i,3]=='versicolor'){
            weight2_versicolor=weight2_versicolor+(1/dist[i])^2 # взвешенная сумма для класса 'versicolor'
        }else if (orderedXl[i,3]=='virginica'){
            weight3_virginica=weight3_virginica+(1/dist[i])^2  # взвешенная сумма для класса 'virginica'
        }
    }
    if (max(weight1_setosa,weight2_versicolor,weight3_virginica)==weight1_setosa){
        return("setosa")
    }else if (max(weight1_setosa,weight2_versicolor,weight3_virginica)==weight2_versicolor){
        return("versicolor")
    }else{
        return("virginica")
    }
   
}
colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)
z <- c(runif(1, 0.9, 7), runif(1, 0, 2.5))
xl <- iris[, 3:5]

k <- readline(prompt = "k = ")
class1 <- kwNN(xl, z, k)
points(z[1], z[2], pch = 24, bg = colors[class1])