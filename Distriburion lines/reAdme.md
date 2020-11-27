# Линии	уровня	нормального	распределения
Специальный случай байесовской классификации - нормальный дискриминантный анализ, когда предполагается, что плотности всех классов ![](https://latex.codecogs.com/gif.latex?p_y(x),&space;y&space;\in&space;Y), являются многомерными нормальными. 
Стандартное нормальное распределение заключается в том, что мат. ожидание равно нулю, а отклонение равно 1. 
![](https://latex.codecogs.com/gif.latex?\mathcal{N}(0,1)\Rightarrow&space;\mu&space;=0,&space;\sigma&space;=1)
>**Математическое ожидание** характеризует среднее значение случайной величины.
**Стандартное отклонение** — показатель рассеивания значений случайной величины относительно её математического ожидания.
**Коэффициент корреляции** - показатель, характеризующий силу статистической связи двумя или несколькими случайными величинами

Для построения алгоритма использую двумерное распределение.
Если в качестве параметров рассеивания принять  математические ожидания  ![](https://latex.codecogs.com/gif.latex?\mu_1,\mu_2) и среднеквадратичные отклонения ![](https://latex.codecogs.com/gif.latex?\sigma_1,\sigma_2) и дополнительно ввести
в рассмотрение коэффициент корреляции ![](https://latex.codecogs.com/gif.latex?-1\leqslant&space;\rho&space;\leqslant&space;1) (но так как матрица ковариации положительно определена и симметрична, то в этой задаче ![](https://latex.codecogs.com/gif.latex?0\leqslant&space;\rho&space;\leqslant&space;1)), то закон нормального распределения плотности вероятности двумерной случайности нужно записать в следующем виде:

![](https://latex.codecogs.com/gif.latex?f(x_1,x_2)=\frac{1}{2\pi&space;\sigma_1&space;\sigma_2\sqrt{1-\rho^{2}}}e^{-\frac{1}{2(1-\rho^{2})}\left&space;[&space;\frac{(x_1-\mu_1)^2}{\sigma_1^2}-\rho&space;\frac{2(x_1-\mu_1)(x_2-\mu_2)}{\sigma_1\sigma_2}&plus;\frac{(x_2-\mu_2)^2}{\sigma_2^2}&space;\right&space;]})
### Ковариационная матрица
У функции плотности нормального распределения случайных величин (причём – любых размерностей!) есть замечательное свойство: эта функция полностью определена своими первыми двумя моментами, и это определение содержится именно в матрице ковариаций K.
По аналогии с тензором инерции твёрдого тела ковариационная матрица
К представляет собой симметрическую матрицу вторых моментов функции ![](https://latex.codecogs.com/gif.latex?f(x_1,x_2)).  При этом, главные моменты функции ![](https://latex.codecogs.com/gif.latex?f(x_1,x_2)) равны диагональным дисперсиям компонент случайного вектора, а недиагональные элементы матрицы, равные перекрёстному второму моменту, в их выражении через диагональные элементы матрицы однозначно определяют величину и знак получаемого множителя согласования - упомянутого коэффициента корреляции ![](https://latex.codecogs.com/gif.latex?\rho)
>**Момент случайной величины** — числовая характеристика распределения данной случайной величины.

![](https://latex.codecogs.com/gif.latex?%5CSigma%20%3D%20%5Cbegin%7Bpmatrix%7D%20k_%7B11%7D%20%26%20k_%7B12%7D%5C%5C%20k_%7B21%7D%20%26%20k_%7B22%7D%20%5Cend%7Bpmatrix%7D%3D%5Cbegin%7Bpmatrix%7D%20k_%7B11%7D%20%26%20%5Crho%20%5Csqrt%7Bk_%7B11%7D%7D%5Csqrt%7Bk_%7B22%7D%7D%5C%5C%20%5Crho%20%5Csqrt%7Bk_%7B11%7D%7D%5Csqrt%7Bk_%7B22%7D%7D%20%26%20k_%7B22%7D%20%5Cend%7Bpmatrix%7D%3D%5Cbegin%7Bpmatrix%7D%20%5Csigma_1%5E%7B2%7D%20%26%20%5Crho%20%5Csigma_1%5Csigma_2%5C%5C%20%5Crho%20%5Csigma_1%5Csigma_2%20%26%20%5Csigma_2%5E%7B2%7D%20%5Cend%7Bpmatrix%7D)

Определитель ковариационной матрицы равен ![](https://latex.codecogs.com/gif.latex?\Delta&space;=\sigma_1^2\sigma_2^2(1-\rho^2)), где ![](https://latex.codecogs.com/gif.latex?\rho=\frac{\sigma_{12}}{\sigma_{1}\sigma_{2}}).


В соответствии с теорией кривых второго порядка уравнение постоянства функции ![](https://latex.codecogs.com/gif.latex?f(x_1,x_2)):


![](https://latex.codecogs.com/gif.latex?\frac{(x_1-\mu_1)^2}{\sigma_1^2}-\rho&space;\frac{2(x_1-\mu_1)(x_2-\mu_2)}{\sigma_1\sigma_2}&plus;\frac{(x_2-\mu_2)^2}{\sigma_2^2}=\lambda^2)


относительно компонент вектора ![](https://latex.codecogs.com/gif.latex?X(x_1,x_2)) представляет собой уравнение эллипса ("эллипса равной плотности вероятности”) или "эллипса рассеивания", определяющего минимальную площадь рассеивания ![](https://latex.codecogs.com/gif.latex?X) с данной вероятностью ![](https://latex.codecogs.com/gif.latex?\rho(\lambda)).
 ### Код
 Значение ![](https://latex.codecogs.com/gif.latex?x_1) и ![](https://latex.codecogs.com/gif.latex?x_2) определяю последовательностью чисел от -10 до 10 с интервалом 0.1, подставляю данные значения в формулу ![](https://latex.codecogs.com/gif.latex?f(x_1,x_2)=\frac{1}{2\pi&space;\sigma_1&space;\sigma_2\sqrt{1-\rho^{2}}}e^{-\frac{1}{2(1-\rho^{2})}\left&space;[&space;\frac{(x_1-\mu_1)^2}{\sigma_1^2}-\rho&space;\frac{2(x_1-\mu_1)(x_2-\mu_2)}{\sigma_1\sigma_2}&plus;\frac{(x_2-\mu_2)^2}{\sigma_2^2}&space;\right&space;]})
 
 Для обозначения графика на плоскости использую функцию outer
 ```R
 NormalDistribution<- function(A){
    # dem(A) определитель
    # solve(A) обратная матрица
    x <- seq(-10, 10, by = 0.1)
    y <- seq(-10, 10, by = 0.1)
    sx<-A[1,1]
    sy<-A[2,2]
    sxy<-A[1,2]
    r<-sxy/(sx*sy)
    print(r)
    if (r!=0){
    grid <- outer(
        x,
        y,
        function(x, y) {
            (1/(2*pi*sqrt(det(A))))*exp(-1/2*(x^2/(sx*(1-r^2))-(2*r*x*y)/(sxy*(1-r^2))+y^2/(sx*(1-r^2))))
        }
    );
    
    filled.contour(grid, axes = FALSE, col=viridis(10),asp=1);
    }else{
    
            grid <- outer(
                x,
                y,
                function(x, y) {
                    (1/(2*pi*sqrt(det(A))))*exp(-1/2*(x^2/sx+y^2/sy))
                }
            );
            
            filled.contour(grid, axes = FALSE, col=viridis(10),asp=1);
        
    }
    
    
}
 
 ```
 Результат
 Cфера - дисперсии случайных величин равны, а коэффициент корреляции r=0
 
 
 ![](https://github.com/Elzara20/university/blob/master/Distriburion%20lines/sphere.jpeg)
 
 
 Наклоненный эллипс - определитель ковариационной матрицы>1, коэффициент корреляции r!=0
 
 
 ![](https://github.com/Elzara20/university/blob/master/Distriburion%20lines/tiltedel.jpeg)
 
 
 Эллипс - определитель ковариационной матрицы>1, коэффициент корреляции r=0
 
 
 ![](https://github.com/Elzara20/university/blob/master/Distriburion%20lines/el.jpeg)
 
 Использованная литература
 
 
[1 источник](https://www.keldysh.ru/kur/akp.pdf)


[2 источник](https://ru.wikipedia.org/wiki/%D0%9C%D0%BD%D0%BE%D0%B3%D0%BE%D0%BC%D0%B5%D1%80%D0%BD%D0%BE%D0%B5_%D0%BD%D0%BE%D1%80%D0%BC%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5_%D1%80%D0%B0%D1%81%D0%BF%D1%80%D0%B5%D0%B4%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5)


 















