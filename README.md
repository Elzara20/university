# Метрические алгоритмы классификации
***Метрические методы классификации*** - это методы обучения, основанные на исследовании сходства объектов.
К метрическим методам относятся:
- алгоритм ближайших соседей
- метод парзеновского окна
- метод потенциальных функций
- отбор эталонных объектов
## Алгоритм ближайших соседей
Данный алгоритм классифицирует объект к тому классу, которому принадлежат его соседи.
В дальнейшем, при рассмотрении методов алгоритма, обучающей выборкой будет набор данных - Ирисы Фишера (длина и ширина лепестка), а принадлежность к классу определять по виду ириса. Для подсчета расстояния использую расстояние Евклида.
### Метод первого ближайшего соседа
Модель алгоритма:
1. Дана обучающая выборка xl и случайно выбранная точка z (z нужно классифицировать)
2. Вычисляем расстояние от z до каждого объекта из выбоки xl
3. Сортируем расстояния от минимума к максимуму
4. Определяем к какому классу относиться объект по первому соседу
 ```R
OneNN <- function(xl, z){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2] - 1 #столбцы
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
```

Пример работы алгоритма показана на рисунках
![](https://github.com/Elzara20/university/tree/master/pictures/1OneNN.jpg)
![](https://github.com/Elzara20/university/tree/master/pictures/2OneNN.jpg)
![](https://github.com/Elzara20/university/tree/master/pictures/3OneNN.jpg)

### Метод k ближайших соседей
Модель алгоритма:
1. Дана обучающая выборка xl, случайно выбранная точка z, количество соседей k (k выбираю сама)
2. Вычисляем расстояние от z до каждого объекта из выбоки xl
3. Сортируем расстояния от минимума к максимуму
4. Определяем какой класс среди k ближайших соседей часто встречается
```R
KNN <- function(xl, z, k){
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
```
Однако не всегда случайно подобранное k является правильным параметром. Критерий скользящего контроля с исключением объектов по одному (LOO, leave-one-out) позволяет определить оптимальное значение k. 
Принцип работы критерия: 
1. "Прячем" объект из выборки
2. С помощью метода ближайших соседей (по порядку определяя k) определяем к какому классу принадлежит объект
3. Сравниваем полученные значения
3.1 Если полученный класс совпадает с действительным классом объекта, то ошибка равна 0
3.2 Если полученный класс не совпадает с действительным классом объекта, то ошибка равна 1
4. Суммируем полученные ошибки и определяем вероятность появления ошибки при каждом k
5. Ответом будет k с наименьшим значением вероятности 
 ```R
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
        qw <- Sorted(a[-j,1:3], z) # функция Sorted возвращает отсортированные данные по расстоянию
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
    }
```
![](https://github.com/Elzara20/university/tree/master/pictures/LOO.jpg)
Для Ирисов Фишера подходящим k является 6.

![](https://github.com/Elzara20/university/tree/master/pictures/map_KNN.jpg)

Значение LOO:

![](https://github.com/Elzara20/university/tree/master/pictures/LOO_knn.jpg)

Однако недостатком метода ближайших k соседей является то, что правильная классификация объекта (распознавание) может достигаться на нескольких классах. Например, при четном числе соседей, наиболее встречающихся классов может быть поровну. Более подходящий вариант для многих классах - это ввести строго убывающую последовательность вещественных весов.
### Метод k взвешенных ближайших соседей
Модель алгоритма:
1. Дана обучающая выборка xl, случайно выбранная точка z, количество соседей k (k=6), параметр для нахождения весов q.
2. Вычисляем расстояние от z до каждого объекта из выбоки xl
3. Сортируем расстояния от минимума к максимуму
4. Определяем какой класс встречается чаще среди k ближайших соседей 
    4.1 Просчитываем взвешенную сумму по q^i
    4.1 Определяем максимальное значение

q принадлежит промежутку [0.0067,1] и можно также подобрать по LOO.
```R
KwNN <- function(xl,z,k,q){
    l <- dim(xl)[1] # строки
    n <- dim(xl)[2]-1 # столбцы 
    dist <-c(0)
    Colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    for (i in 1:l){
        dist[i] <- c(Euclid(xl[i, 1:n], z[,1:n]))
    }
    #сортировка выборки по расстоянию
    OrderedXl <- xl[order(dist), ]
    for (c in names(Colors)){ # имена классов
        for (i in 1:k){     # соседи       
            if(OrderedXl[i,3]==c){
                Colors[c] <- Colors[c]+q^i # взвешенная сумма для k ближайших соседей
            }           
        }     
    }
    return(names(which.max(Colors)))
}
```
Для Ирисов Фишера подходящим q по LOO является 1.

![](https://github.com/Elzara20/university/tree/master/pictures/map_KwNN.jpg)

Значение LOO:

![](https://github.com/Elzara20/university/tree/master/pictures/kwNN_LOO.jpg)

### Сравнение алгоритмов kNN и kwNN
Рассмотрим пример. Пусть синие точки относятся к классу "0", а красные - "1". Алгоритм kNN классифицирует красную точку как класс "0", однако очевидно, что эта точка относится к классу "1" (алгоритм kwNN). 

![](https://github.com/Elzara20/university/tree/master/pictures/example_dif.jpg)

### Потенциальные функции
Модель алгоритма:
1. Дана обучающая выборка xl, случайно выбранная точка z, ширина окна h и массив потенциалов p.
2. Вычисляем расстояние от z до каждого объекта из выбоки xl
3. Проходим по всех объектам выборки
 4.1 Определяем вес с помощью функции ядра K
![](https://github.com/Elzara20/university/tree/master/pictures/parzen_h.jpg)
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
Алгорит нахождения потенциалов:
```R
    LOO <- function(a){
    colo <- c("setosa" = "coral1", "versicolor" = "chartreuse", "virginica" = "deepskyblue")
    len <- dim(a)[1]
    n <- dim(a)[2]
    ANS <- c()
    K<-0
    eps<-10
    err<-eps+0.1
    h<-0.4 #оптимальное значение
    
    h_seq <- seq(0.1, 2, 0.1)
    for (i in 1:length(h_seq)){
        ANS[i]<-0
    }
    p<-c()
    for (i in 1:len){
        p[i]<-0
    }
    qw<- matrix(0, len, len)
    qw <- Sorted(a)
    while (err>eps && err<11){ 
        
        for (j in 1:len){ 
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:len){
                r<-qw[j,i]/h
                colors[a[i,3]] <- colors[a[i,3]]+p[i]*RectK(r) # взвешенная сумма   
            }
                if (a[j, 3] != names(which.max(colors)) ){  
                    p[j] <- p[j]+1          
                                            
                }
            
        }
                
            
                    
        
        for (j in 1:len){      
            colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
            for (i in 1:(len-1)){                
                r<-qw[j,i]/h
                colors[a[i,3]] <- colors[a[i,3]]+p[i]*RectK(r) # взвешенная сумма   
            }
                
            if (a[j, 3] != names(which.max(colors))){   
                err<-err+1                                
            }
        }
        
            
     }
    return(p)
}

```

Карта классификации для прямоугольного ядра:

![](https://github.com/Elzara20/university/tree/master/pictures/Potential_rect.jpg)
