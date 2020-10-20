#  Разделение смеси распределений


В тех случаях, когда «форму» класса не удаётся описать каким-либо одним распределением, можно попробовать описать её смесью распределений.

![equation](CodeCogsEqn.gif) 

где ![](https://latex.codecogs.com/gif.latex?p_j(x)) — функция правдоподобия ![](https://latex.codecogs.com/gif.latex?j)-ой компоненты смеси, ![](https://latex.codecogs.com/gif.latex?w_j) — её априорная вероятность.

>**Априорная  (безусловная) вероятность** представляет собой степень уверенности в том, что данное событие произошло, в отсутствие любой другой информации, связанной с этим событием. Представление в задачах: вероятность принадлежности объекта ![](https://latex.codecogs.com/gif.latex?X) к классу ![](https://latex.codecogs.com/gif.latex?A) без учета его признаков.
>**Значение правдоподобия** - согласование (схожесть) с выборкой.

Иными словами, "выбрать объект x из смеси ![](https://latex.codecogs.com/gif.latex?p(x))" означает сначала выбрать ![](https://latex.codecogs.com/gif.latex?j)-ю компоненту смеси из дискретного распределения ![](https://latex.codecogs.com/gif.latex?\{w_1,&space;\dots&space;,&space;w_k\}), затем выбрать объект ![](https://latex.codecogs.com/gif.latex?x) согласно плотности ![](https://latex.codecogs.com/gif.latex?p_j(x)).
**Задача разделения смеси** - оценить вектор параметров, имея выборку,  смесь, количество распределений и функцию распределения.
## EM-алгоритм (expectation-maximization)
***Почему используем***
Принцип максимума правдоподобия «в лоб», приводит к слишком громоздкой оптимизационной задаче (долго решается).  
***Идея алгоритма***
Искусственно вводится вспомогательный вектор скрытых (hidden) переменных ![](https://latex.codecogs.com/gif.latex?G), обладающий двумя замечательными свойствами. 
EM-алгоритм состоит из итерационного повторения двух шагов. 
На ![](https://latex.codecogs.com/gif.latex?E)-шаге вычисляется ожидаемое значение (expectation) вектора скрытых переменных ![](https://latex.codecogs.com/gif.latex?G) по текущему приближению вектора параметров ![](https://latex.codecogs.com/gif.latex?\Theta). На ![](https://latex.codecogs.com/gif.latex?M)-шаге решается задача максимизации правдоподобия (maximization) и находится следующее приближение вектора параметров по текущим значениям векторов ![](https://latex.codecogs.com/gif.latex?G) и ![](https://latex.codecogs.com/gif.latex?\Theta).
### E-шаг (expectation)
Обозначим через ![](https://latex.codecogs.com/gif.latex?p(x,\theta_j)) плотность вероятности того, что объект ![](https://latex.codecogs.com/gif.latex?x) получен из ![](https://latex.codecogs.com/gif.latex?j)-й компоненты смеси. По формуле условной вероятности

![](https://latex.codecogs.com/gif.latex?p(x,\theta_j)=p(x)P(\theta_j|x)=w_jp_j(x))

Введём обозначение ![](https://latex.codecogs.com/gif.latex?g_{ij}\equivP(\theta_j|x_i)). Это неизвестная апостериорная вероятность того, что обучающий объект ![](https://latex.codecogs.com/gif.latex?x_i) получен из ![](https://latex.codecogs.com/gif.latex?j)-й компоненты смеси. Каждый объект обязательно принадлежит какой-то компоненте, поэтому справедлива формула полной вероятности:
![](https://latex.codecogs.com/gif.latex?\sum_{j=1}^kg_{ij}=1) для всех ![](https://latex.codecogs.com/gif.latex?i=1,\dots, l)
Тогда
![](https://latex.codecogs.com/gif.latex?g_{ij}=\frac{w_jp_j(x_i)}{\sum_{s=1}^k w_sp_s(x_i)})
### M-шаг (maximization)
M-шаг сводится к вычислению весов компонент ![](https://latex.codecogs.com/gif.latex?w_j) как средних арифметических и оцениванию параметров компонент ![](https://latex.codecogs.com/gif.latex?\thete_j) путём решения ![](https://latex.codecogs.com/gif.latex?k) независимых оптимизационных задач.Разделение переменных возможно благодаря удачному введению скрытых переменных.




