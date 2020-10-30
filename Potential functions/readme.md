# Потенциальные функции
Модель алгоритма:
1. Дана обучающая выборка xl, случайно выбранная точка z, ширина окна h и массив потенциалов p.
2. Вычисляем расстояние от z до каждого объекта из выбоки xl
3. Проходим по всех объектам выборки
 4.1 Определяем вес с помощью функции ядра K
![](https://github.com/Elzara20/university/blob/master/pictures/parzen_h.jpg)
где значение функции K определяется как расстояние от заданного z до всех объектов выборки деленное на ширину окна
 4.2 Находим взвешанную сумму, где значение ядра умножается на значение потенциала
5. Ответом является максимальное значение взвешанной суммы
```R
Potetial <- function(xl, z, h,p){
    len <- dim(xl)[1]
    n <- dim(xl)[2]
    w <- c()
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    qw <- Sorted(xl[,1:3], z)
    for (i in 1:len){ 
        r<-qw[i,1]/h
        colors[qw[i,2]] <- colors[qw[i,2]]+p[i]*RectK(r) # взвешенная сумма для k ближайших соседей
                      
    }     
    
    return(names(which.max(colors)))  
}
```
Потенциал или мера воздействия проверяет на близость объекта к обучающей выборке. От него зависит определение принадлежности к классу.
##Алгорит нахождения потенциалов
Можно рассмотреть 2 способа получения потенциаловю. Первый способ представлен внизу. Главная идея - выбор случайной точки из выборки и проверки ее на совпадение (спомощью алгоритма потенциальных функций). 
Выбор продолжается до тех пор, пока встречаем ошибочную классификацию.
```R
LOO <- function(a){
    colo <- c("setosa" = "coral1", "versicolor" = "chartreuse", "virginica" = "deepskyblue")
    len <- dim(a)[1]
    n <- dim(a)[2]
  
    err<-1
    h<-0.1#оптимальное значение
    
    p<-c()
    for (i in 1:len){
        p[i]<-0
    }
    qw<- c()
    
    while (err<30){ #!! нужно ограничение для err
      while(TRUE){
        #до тех пор пока находим ошибочные классы 
        z <- sample(1:len, 1)
        qw <- Sorted(a[,1:3], z)
                        
        colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
        for (i in 1:len){
          r<-qw[i]/h             
          colors[z] <- colors[z]+p[i]*GaussK(r) # взвешенная сумма   
        }
          
        if (a[z, 3] != names(which.max(colors))){  
          p[z] <- p[z]+1 
          break               
        }
      }
        z <- sample(1:len, 1)
        qw <- Sorted(a[,1:3], z)
        
            
        colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
        for (i in 1:len){
            r<-qw[i]/h             
            colors[z] <- colors[z]+p[i]*GaussK(r) # взвешенная сумма   
        }
        if (a[z, 3] != names(which.max(colors)) ){  
            err<-err+1                                                        
        }
           
    } 
}

```
Второй способ заключается в прохождении всей выборки с учетом увеличения ошибки.
```R
LOO <- function(a){
    colo <- c("setosa" = "coral1", "versicolor" = "chartreuse", "virginica" = "deepskyblue")
    len <- dim(a)[1]
    n <- dim(a)[2]
    
    err<-1
    h<-0.4 #оптимальное значение
    
   
    p<-c()
    for (i in 1:len){
        p[i]<-0
    }
   
    qw <- Sorted(a)
    #print(qw)
    while (err<30){ #!! нужно ограничение для err
      
        for (j in 1:len){ # paccматриваем случайные данные из iris            
            # for (k in 1:len){        
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:len){
                r<-qw[j,i]/h             
                colors[a[j,3]] <- colors[a[j,3]]+p[i]*EpanechnikovK(r) # взвешенная сумма                 
            }
            if (a[j, 3] != names(which.max(colors))){  
                print("DONE")
                print(names(which.max(colors)))
                print(a[j, 3])
                p[j] <- p[j]+1 
                # break                
                                            
            }
           # }
        }
        for (j in 1:len){ # paccматриваем случайные данные из iris
            # for (k in 1:len){
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:len){
                r<-qw[j,i]/h             
                colors[a[j,3]] <- colors[a[j,3]]+p[i]*EpanechnikovK(r) # взвешенная сумма                 
            }
            if (a[j, 3] != names(which.max(colors))){  
                err<-err+1               
                                            
            }
          
        }
     }
 }
``

Карта классификации для Гауссовского ядра:

![](https://github.com/Elzara20/university/blob/master/Potential%20functions/potentials_G.jpg)
