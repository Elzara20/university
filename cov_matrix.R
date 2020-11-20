library(ggplot2)
library(viridis)
library(wesanderson)
NormalDistribution<- function(A){
    # dem(A) определитель
    # solve(A) обратна€ матрица
    x <- seq(-10, 10, by = 0.1)
    y <- seq(-10, 10, by = 0.1)
    z<-c()
    #ans<-matrix(0,nrow = length(x), ncol = 3)
    for (i in 1:length(x)){
        z[i]<-0
    }
    for (i in 1:length(x)){
        z[i]<- (1/(2*pi*sqrt(det(A))))*exp(-1/2*(x[i]^2+y[i]^2))
    }
    #print(z)
    ans<-data.frame(x, y, z)
    #print(ans)
    #ggplot(data=ans,aes(x=x, y=y, z=z))
    x <- y <- seq(-10, 10, by = 0.1)
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
    
    
    #filled.contour(x, y, z)
    # geom_point()+stat_ellipse()
    #ggplot(data = ans)
    #plot(ans)
    # wireframe(z~x*y, data=ans, aspect=c(1, .5), shade=TRUE)
    
}
# сфера - определитель ковариационной матрицы равен 1, а коэффициент коррел€ции r=0
A<-matrix(c(1,0,0,1),2,2)
# наклоненный эллипс - определитель ковариационной матрицы>1, коэффициент коррел€ции r!=0
A1<-matrix(c(4,1,1,2),2,2)
# наклоненный эллипс - определитель ковариационной матрицы>1, коэффициент коррел€ции r=0
A2<-matrix(c(1,0,0,4),2,2)
A3<-matrix(c(8,-2,-2,3),2,2)
NormalDistribution(A3)

