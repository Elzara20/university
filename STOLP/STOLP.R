Euclid <- function(u, v){
    return(sqrt(sum((u - v)^2)))
}
KwNN <- function(xl,z,k,q){
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
    right <- KwNN(z, xl[i,],k,1)
    wrong <- k-right
    margin[i] <- right-wrong  
    
}
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

# barplot(height = margin, xlab = "margin", col = color, main = "Margin obtained by KwNN")

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
        print(z)
        right <- KwNN(Standart, z,k,1)
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
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1, main ="STOLP")
points(Standart[,1:2], pch=2,cex=2,bg = col[Standart[,3]], col=col[Standart[,3]]) 