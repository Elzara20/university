# Парзеновское окно
Модель алгоритма:
1. Дана обучающая выборка xl, случайно выбранная точка z, ширина окна h.
2. Вычисляем расстояние от z до каждого объекта из выбоки xl
3. Сортируем расстояния от минимума к максимуму
4. Проходим по всех объектам выборки

 4.1 Определяем вес с помощью функции ядра K
 
![](https://github.com/Elzara20/university/blob/master/Parzen%20window/parzen_h.jpg)

где значение функции K определяется как расстояние от заданного z до всех объектов выборки деленное на ширину окна

 4.2 Находим взвешанную сумму 
 
5. Ответом является максимальное значение взвешанной суммы
```R
Parzen <- function(xl, z, h){
    len <- dim(xl)[1]
    n <- dim(xl)[2]
    w <- c()
    colors <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)
    qw <- Sorted(xl[,1:3], z)

    for (i in 1:len){ 
      r<-qw[i,2]/h
      colors[qw[i,3]] <- colors[qw[i,3]]+RectK(r) 
    }   
    return(names(which.max(colors)))
}
```
Ширина окна h влияет на качество плотности. При h, близкое к нулю, плотность определяется вблизи обучающих объектов, а при h, близкое к бесконечности, плотность сглаживается и вырождается в константу.
Функция ядра K не влияет на качество плотности, но влияет на степень гладкости при вычислении парзеновского окна и эффективность вычислений.
Используемые ядра:
1. Прямоугольное ядро
```R
RectK <- function(dist) {
  if (abs(dist) <= 1) {
    return (0.5)
  } else {
    return (0)
  }
}
```
Подобранное h для прямоугольного ядра равна 0.4 с помощью LOO
![](https://github.com/Elzara20/university/blob/master/Parzen%20window/RectKernel.jpg)

2. Треугольное ядро
```R
TriangleK <- function(dist) {
  if (abs(dist) <= 1) {
    return (1-abs(dist))
  } else {
    return (0)
  }
}
```
Подобранное h для треугольного ядра равна 0.4 с помощью LOO
![](https://github.com/Elzara20/university/blob/master/Parzen%20window/TKernel.jpg)

3. Квадратичное ядро
```R
SquareK <- function(dist) {
  if (abs(dist) <= 1) {
    return ((15/16)*(1-dist^2)^2)
  } else {
    return (0)
  }
}
```
Подобранное h для прямоугольного ядра равна 0.4 с помощью LOO
![](https://github.com/Elzara20/university/blob/master/Parzen%20window/SquareKernel.jpg)

4. Ядро Епанечникова
```R
EpanechnikovK <- function(dist) {
  if (abs(dist) <= 1) {
    return ((3/4)*(1-dist^2))
  } else {
    return (0)
  }
}
```
Подобранное h для ядра Епанечникова равна 0.4 с помощью LOO
![](https://github.com/Elzara20/university/blob/master/Parzen%20window/EKernel.jpg)


5. Гауссовское ядро
```R
GaussK <- function(dist) {
  return ((2*pi)^(-0.5)*exp(-0.5*(dist^2)))
}
```

Подобранное h для ядра Гауссовского равна 0.1 с помощью LOO
![](https://github.com/Elzara20/university/blob/master/Parzen%20window/GKernel.jpg)
### Главные различия алгоритма
- Преимуществом парзеновского окна от алгоритма ближайших соседей является задание определенной величины области исследования. Подробно рассмотрено на рисунке
![](https://github.com/Elzara20/university/blob/master/Parzen%20window/example.jpg)
Есть фиксированнное расстояние от задаваемого объекта, и рассчитываем (классифицируем) не по рангу ( как в методе ближайших соседей), а по расстоянию. 
- Используя заданную *функцию ядра*, данный метод аппроксимирует заданное распределение обучающей выборки с помощью линейной комбинации ядер, центрированных на наблюдаемых точках.




