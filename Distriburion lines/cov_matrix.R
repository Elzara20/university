library(ggplot2)
library(viridis)
library(wesanderson)
library(MASS)

NormalDistribution<- function(A){
    # dem(A) определитель
    # solve(A) обратна€ матрица
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
            (1/(2*pi*sxy*sqrt(1-r^2)))*exp(-1/2*((x)^2/(sx*(1-r^2))-(2*r*(x)*(y))/(sxy*(1-r^2))+(y)^2/(sx*(1-r^2))))
        }
    );
    
    filled.contour(x,y,grid, col=viridis(20),asp=1, plot.axes={contour(x,y,grid, add=TRUE)})
    }else{
    
            grid <- outer(
                x,
                y,
                function(x, y) {
                    (1/(2*pi*sqrt(det(A))))*exp(-1/2*(x^2/sx+y^2/sy))
                }
            );
            
            filled.contour(x,y,grid, col=viridis(30),asp=1, plot.axes={contour(x,y,grid, add=TRUE)})

        
    }
   
}

# сфера - определитель ковариационной матрицы равен 1, а коэффициент коррел€ции r=0
A<-matrix(c(16,0,0,16),2,2)

NormalDistribution(A)
# наклоненный эллипс - определитель ковариационной матрицы>1, коэффициент коррел€ции r!=0
A1<-matrix(c(9,1,1,6),2,2)
NormalDistribution(A1)
#эллипс - определитель ковариационной матрицы>1, коэффициент коррел€ции r=0
A2<-matrix(c(11,0,0,7),2,2)
NormalDistribution(A2)


