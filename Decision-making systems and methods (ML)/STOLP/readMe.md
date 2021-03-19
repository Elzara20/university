# STOLP
С помощью алгоритма  STOLP классифицируем объекты на эталонные, неинформативные, шумовые. Классификация объектов на данные типы выполняется благодаря отступам. Отступ показывает степень типичности объекта. 
Формула вычисления отступа:

![](https://latex.codecogs.com/gif.latex?M(x_i)=W_{y_i}(x_i,X^l)-\max_{y&space;\in&space;Y&space;/\{y_i\}}W_y(x_i,X^l).)

Объяснение на примере

![](https://github.com/Elzara20/university/blob/master/pictures/exampleForSTOLP.jpg)

Дана выборка из двух классов, значение х принадлежит классу "+". Рассмотрим классификацию 3NN. Правильно классифицируется 1 объект, а остальные 2 неправильно, тогда отступ равен: ![](https://latex.codecogs.com/gif.latex?M(x_i)=1-2=-1).Значит, алгоритм классификации для значения х неверный -- допускает ошибку.
В зависимости от значений отступа объекты условно делятся на пять типов:
 -  **Эталонные** объекты имеют большой положительный отступ
 -  **Неинформативные** объекты имеют положительный отступ. Изъятие этих объектов из выборки (при условии, что эталонные объекты остаются), не влияет на качество классификации.
 -  **Пограничные** объекты имеют отступ, близкий к нулю. 
 -  **Ошибочные** объекты имеют отрицательные отступы и классифицируются неверно (возможная причина -- неудачно выбранная метрика).
 -  **Шумовые** объекты или выбросы — это небольшое число объектов с большими отрицательными отступами. Они плотно окружены объектами чужих классов и классифицируются неверно. (целесообразно удалять из выборки)
 
 Если выборка имеет в основном положительные(+) отступы, то классификация будет успешной; если (-) отступы -- гипотеза компактности не выполняется (метрические алгоритмы не подойдут); если (![](https://latex.codecogs.com/gif.latex?\approx0)) отступы -- невозможна надежная классификация.
Результатом работы алгоритма STOLP является разбиение обучающих объектов на три категории: шумовые, эталонные и неинформативные.

## Модель алгоритма STOLP:
1. Найти шумовые объекты и отбросить их из обучающейся выборки
2. Формируем начальное приближение: в матрицу Standart записываем по одному эталону из каждого класса
3. Наращиваем множество эталонов

    3.1. До тех пор, пока количество эталонов не равно количеству выборки
    
    3.2. Классифицируем объекты, используя в качестве обучающей выборки множество эталонов
    
    3.3. Пересчитываем отступы
    
    3.4. Среди объектов каждого класса, распознанных неправильно, выбрать объекты с отрицательным отступом и добавить их к множеству эталонов
    
```R
#вычисляем отступы 
for (i in 1:len){    
    z<-xl[-i,]
    right <- KwNN(z, xl[i,],k,1)
    wrong <- k-right
    margin[i] <- right-wrong  
    
}
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
        wrong <- k-right
        margin1[i] <- right-wrong       
    }
    if (length(which(margin1<=0))<dim(Standart)[1]*0.1){ # отбрасываю шумовые выбросы, 10% ошибка от числа элементов
        break
    }
    Standart<-rbind(Standart,z)
}
```

![](https://github.com/Elzara20/university/blob/master/pictures/margin_by_kwnn.jpg)


![](https://github.com/Elzara20/university/blob/master/pictures/STOLP.jpeg)

Сравнение с другими алгоритмами:


![](https://github.com/Elzara20/university/blob/master/pictures/comparison_metric.jpeg)