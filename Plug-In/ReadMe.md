# Подстановочный алгоритм (plug-in)
Основной идеей подстановочного алгоритма является то, что **подставляем** полученные вычисления (матожидание и матрицу ковариации) в алгоритм классификации. 
##### Алгоритм
Дана обучающая выборка, которая имеет нормальную плотность распределения. 
>Выборку с нормальной плотностью распределения можно получить по преобразованию Бокса—Мюллера, но и с помощью функции  ***mvrnorm(n, mu, Sigma)***, где  n- количество точек, mu - матожидание,  Sigma - матрица ковариации (в коде есть реализация обоих).

Просчитываем математическое ожидание для гауссовской плотности (среднее арифметическое) и матрицу ковариации:
![](https://latex.codecogs.com/gif.latex?\hat{\mu}=\frac{1}{m}\sum_{i=1}^{m}x_i)


![](https://latex.codecogs.com/gif.latex?\hat{\Sigma}=\frac{1}{m}\sum_{i=1}^{m}(x_i&space;-\hat{\mu&space;})(x_i&space;-\hat{\mu&space;})^T)
Вероятностное распределение с плотностью:
![](https://latex.codecogs.com/gif.latex?p(x)=N(x,\hat{\mu},\hat{\Sigma})=\frac{1}{2\pi&space;\sqrt{\left&space;|&space;\Sigma&space;\right&space;|}}e^{-\frac{1}{2}(x-\hat{\mu})^T\Sigma^{-1}(x-\hat{\mu})})

называется двумерным нормальным (гауссовским) распределением с вектором матожидания и ковариационной матрицей. Предполагается, что матрица ![](https://latex.codecogs.com/gif.latex?\hat{\Sigma})  симметричная, невырожденная (определитель не равен нулю) и положительно определённая.
Все полученные вычисления (оценки) подставляем в формулу:
![](https://latex.codecogs.com/gif.latex?a(x)=\arg&space;\max_{y\in&space;Y}\lambda_yP_yp_y(x))
где ![](https://latex.codecogs.com/gif.latex?\lambda) - вечилина потери ( ![](https://latex.codecogs.com/gif.latex?\lambda=1), так как классы из обучающей выборки равнозначны, оба с нормальным распределением); ![](https://latex.codecogs.com/gif.latex?P) - априорная вероятность:
![](https://latex.codecogs.com/gif.latex?P_y=\frac{l_y}{l})

![](https://latex.codecogs.com/gif.latex?l_y)-количество всей выбоки (из всех классов), ![](https://latex.codecogs.com/gif.latex?l)-количество элементов из класса ![](https://latex.codecogs.com/gif.latex?y). Так как используются только 2 класса, то ![](https://latex.codecogs.com/gif.latex?P=\frac{1}{2}=0.5).
***Весь алгоритм заключается в построении кривой второго порядка***, для которой выполняется уравнение 
![](https://latex.codecogs.com/gif.latex?\lambda_{green}P_{green}p_{green}(x)=\lambda_{black}P_{black}p_{black}(x))

подставляем известные нам значения:

![](https://latex.codecogs.com/gif.latex?0.5p_{green}(x)=0.5p_{black}(x))
![](https://latex.codecogs.com/gif.latex?0.5p_{green}(x)-0.5p_{black}(x)=0)

 Общий вид кривой второго порядка:
 ![](https://latex.codecogs.com/gif.latex?a_{11}x^2&plus;a_{22}y^2&plus;2a_{12}xy&plus;2a_{13}x&plus;2a_{23}y&plus;a_{33}=0)
 где все коэффициенты находим следующим образом:
 вычисляем матрицу ![](https://latex.codecogs.com/gif.latex?final=\hat{\Sigma&space;}^{-1}_{green}-\hat{\Sigma&space;}^{-1}_{black})
 ![](https://latex.codecogs.com/gif.latex?a_{11}=final[1,1]) 
 
 ![](https://latex.codecogs.com/gif.latex?a_{22}=final[2,2]) 
 
 ![](https://latex.codecogs.com/gif.latex?a_{12}=final[1,2])  ( матрица симметрична, поэтому ![](https://latex.codecogs.com/gif.latex?final[1,2]=final[2,1]))
 вычисляем вектор ![](https://latex.codecogs.com/gif.latex?final2=\hat{\Sigma&space;}^{-1}_{green}\hat{\mu}_{green}-\hat{\Sigma&space;}^{-1}_{black}\hat{\mu}_{black})
 
![](https://latex.codecogs.com/gif.latex?a_{13}=final2[1])
 
![](https://latex.codecogs.com/gif.latex?a_{23}=-final2[2])

![](https://latex.codecogs.com/gif.latex?a_%7B33%7D%3Dln%28abs%28%5Cleft%20%7C%20%5CSigma_%7Bgreen%7D%20%5Cright%20%7C%29%29%20&plus;%20%5Chat%7B%5Cmu%20%7D%5ET_%7Bgreen%7D%5CSigma_%7Bgreen%7D%5E%7B-1%7D%5Chat%7B%5Cmu%20%7D_%7Bgreen%7D-%20%28ln%28abs%28%5Cleft%20%7C%20%5CSigma_%7Bblack%7D%20%5Cright%20%7C%29%29%20&plus;%20%5Chat%7B%5Cmu%20%7D%5ET_%7Bblack%7D%5CSigma_%7Bblack%7D%5E%7B-1%7D%5Chat%7B%5Cmu%20%7D_%7Bblack%7D%29)
(аналогия с наивным байесовским классификатором)
Код:
```R
final<-matrix(0,col,col)
final<-solve(s_2)-solve(s_1)
final2<-matrix(0,col,1)
final2<-solve(s_2)%*%mu_2-solve(s_1)%*%mu_1

f <- log(abs(det(s_2))) - log(abs(det(s_1))) + t(mu_2) %*% solve(s_2) %*% mu_2 - t(mu_1) %*% solve(s_1) %*% mu_1
grid <- outer(
  x,
  y,
  function(x, y) 
    final[1,1]*x^2+final[2,2]*y^2+2*final[1,2]*x*y-2*final2[1,1]*x-2*final2[2,1]*y+f[1]
  
)
```
Основные классификации кривых вторго порядка:
- эллипс 
![](https://latex.codecogs.com/gif.latex?a_{11}a_{22}-a_{12}^2>0)
- гипербола
![](https://latex.codecogs.com/gif.latex?a_{11}a_{22}-a_{12}^2<0)
- парабола
![](https://latex.codecogs.com/gif.latex?a_{11}a_{22}-a_{12}^2=0)



 Результат работы:
 ![](https://github.com/Elzara20/university/blob/master/pictures/PlugInHyperbola.jpeg)
 
 ![](https://github.com/Elzara20/university/blob/master/pictures/PlugInParabola.jpeg)
 
 ![](https://github.com/Elzara20/university/blob/master/pictures/PlugInEl.jpeg)

 
