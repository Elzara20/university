# Линейный	дискриминант	Фишера	– ЛДФ
Главное отличие от подстановочного алгоритма в том, что считаем, что все  ковариационные матрицы классов равными (даже если они не равны). Тогда, достаточно оценить только одну ковариационную матрицу ![](https://latex.codecogs.com/gif.latex?\hat{\Sigma}), задействовав для этого все объекты выбоки. При этом разделяющая поверхность является линейной (вид-прямая), если классов два, и кусочно-линейной, если классов больше. 

В данном алгоритмеразделяющих классов будет 2, значит основной задачей алгоритма будет найти коэффициенты прямой:

![](https://latex.codecogs.com/gif.latex?a%28x%29%3Darg%5Cmax_%7By%20%5Cin%20Y%7D%28%5Clambda_yP_yp_y%28x%29%29%3D%20arg%5Cmax_%7By%20%5Cin%20Y%7D%28%5Cunderbrace%7Bln%28%5Clambda_yP_y%29-%5Cfrac%7B1%7D%7B2%7D%5Chat%7B%5Cmu%20%7D%5ET_y%5Chat%7B%5CSigma%7D%5E%7B-1%7D%5Chat%7B%5Cmu%20%7D_y%7D_%7B%5Cbeta%20%7D&plus;x%5ET%5Cunderbrace%7B%5Chat%7B%5CSigma%7D%5E%7B-1%7D%5Chat%7B%5Cmu%20%7D%7D_%7B%5Calpha%20%7D%29%3D%5C%21%20%3Darg%5Cmax_%7By%20%5Cin%20Y%7D%28x%5ET%5Calpha_y&plus;%5Cbeta_y%29)


так как выборка нормированная, то ![](https://latex.codecogs.com/gif.latex?\lambda_y=1), a ![](https://latex.codecogs.com/gif.latex?P_y=\frac{1}{2}=0.5)- так как класса всего 2
 
Нахождения математического ожидания каждого из классов (среднее арифметическое):
```R
mu_1<-matrix(0,col,1)
mu_1<-colMeans(df)
mu_2<-matrix(0,col,1)
mu_2<-colMeans(df1)
```

Нахождение матрицы ковариации:

![](https://latex.codecogs.com/gif.latex?\hat{\Sigma}=\frac{1}{m-2}\sum_{i=1}^{m}(x_i&space;-\hat{\mu&space;})(x_i&space;-\hat{\mu&space;})^T)

```R
s<-matrix(0,col,col)
df<-as.matrix(df)
for (i in 1:row){  
  s <- s + ((df[i,]- mu_1) %*% t(df[i,] - mu_1))     
}

df1<-as.matrix(df1)
for (i in 1:row){         
  s<- s + ((df1[i,] - mu_2) %*% t(df1[i,] - mu_2))     
}
s<-s/(row-col)

```
Нахождение коэффициентов прямой ![](https://latex.codecogs.com/gif.latex?\alpha) и ![](https://latex.codecogs.com/gif.latex?\beta):
```R
a<-solve(s)%*%(mu_2-mu_1)
b<-log(0.5)-0.5*t((mu_2-mu_1))%*%solve(s)%*%(mu_2-mu_1)
```

Результат алгоритма:

 