sweet <- c(1,2,3, 4, 5, 6, 7,9, 10, 11, 12, 13)  
crunch <- c(8,1,5, 9, 2, 6, 8, 4,10,3, 2, 6)
name <- c("bacon", "cheese", "apple", "nuts", "fish","green bean", "cucumber", "pear", "carrot", "orange","banana", "grape")
distance <- function(x,y, x1, y1){
    return (sqrt((x-x1)^2+(y-y1)^2));
}
for(i in 1:20){
print(distance(iris[i, 3], iris[i,4], 1.5, 0.2))
}
print("\n")
for(i in 1:20){
    print(distance(iris[i, 3], iris[i,4], 4, 1.2))
}
print("\n")
for(i in 1:20){
       print(distance(iris[i, 3], iris[i,4], 6.1, 2.2))

}
print("\n")
#plot (sweet, crunch)
colors <- c("versicolor"="green", "setosa"="red", "virginica"="purple")
plot(iris[,3:4], col=colors[iris$Species], pch=20)
points(runif(3, 0.9, 7), runif(3, 0, 2.5), col=colors, bg=colors, pch=24)
#points(4, 1.2, col="black",  pch=16, asp=1)
#points(6.1, 2.2, col="black",  pch=16, asp=1)
