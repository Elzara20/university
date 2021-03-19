library(ggplot2)
NormalDistribution<- function(A){
    # dem(A) определитель
    # solve(A) обратная матрица
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
    print(z)
    ans<-data.frame(x, y, z)
    print(ans)
    # print(length(x))
    # print("ans")
    # print(ans)
   
    # filled.contour(x,y,ans, nlevels=20, asp=0, plot.axs={
    #     axis(1)
    #     axis(2)
    #     contour(x,y,z,add=TRUE)
    #   })
    # return(ans)   
#     filled.contour(x = seq(0, 1, length.out = nrow(ans)),
#                y = seq(0, 1, length.out = ncol(ans)),
#                ans,
#                xlim = range(x, finite = TRUE),
#                ylim = range(y, finite = TRUE),
#                zlim = range(ans, finite = TRUE),
#                levels = pretty(zlim, nlevels), nlevels = 20,
#                color.palette = function(n) hcl.colors(n, "YlOrRd", rev = TRUE),
#                col = color.palette(length(levels) - 1),
#                plot.title, plot.axes, key.title, key.axes,
#                asp = NA, xaxs = "i", yaxs = "i", las = 1,
#                axes = TRUE, frame.plot = axes) 



ggplot(ans, aes(x=x, y=y,z=z, colour="red"))+
geom_point()
#ggplot(data = ans)
#plot(ans)

}
A<-matrix(c(1,0,0,1),2,2)

NormalDistribution(A)