library(ggplot2)
library(kernlab)
library(e1071)

data=data.frame(x=iris[100:150,1], y=iris[100:150,2], class=iris[100:150,5])
data= rbind(data,data.frame(x=iris[50:100,1], y=iris[50:100,2], class=iris[50:100,5]))

ggplot(data, aes(x,y, color=class)) +   geom_point(size=3) 


svm_model= ksvm(class ~ x+ y, data=data, kernel='vanilladot')
svm_model
coef(svm_model)

b(svm_model)
alpha(svm_model)
coef(svm_model)
data[alphaindex(svm_model)[[1]],c('x','y')]
coef(svm_model) * data[alphaindex(svm_model)[[1]],c('x','y')]
w = colSums(coef(svm_model) * data[alphaindex(svm_model)[[1]],c('x','y')])  

b = b(svm_model)
b
data[, 1:2] = sapply(data[,1:2], scale)
w
print(w[2]/w[1])
print(w[1]/w[2])
k=min(w[2]/w[1],w[1]/w[2])
k
b/min(abs(w))
w
ggplot(data,aes(x, y, color=class)) +
  geom_point(size=3) + geom_abline(intercept=b/sqrt(sum(w^2)), slope=sqrt(sum(w^2))) 
table(data[3])[1]

#ROC
FPR<-c()
FPR[1]=0
TPR<-c()
TPR[1]=0
AUC<-0
m1=table(data[3])[[1]]
m2=table(data[3])[[2]]
orderedXl <- data[order(data[1],data[1], decreasing=T), ]
orderedXl

for (i in 2:dim(orderedXl)[1]){
  if (orderedXl[i,3]=="versicolor"){
    FPR[i]=FPR[i-1]+(1/m2)
    TPR[i]=TPR[i-1]
    AUC=AUC+(1/m2)*TPR[i]
  }else{
    FPR[i]=FPR[i-1]
    TPR[i]=TPR[i-1]+(1/m1)
  }
}
AUC
FPR
TPR
plot(FPR,TPR, type="l", main ="ROC-кривая")

x<-iris[51:150,3]
y<-iris[51:150,4]
color<-iris[51:150,5]

data=data.frame(x=x[1:50], y=y[1:50], class=color[1:50])
data= rbind(data,data.frame(x=x[51:100], y=y[51:100], class=color[51:100]))
X1=rbind(x,y)
X1
ggplot(data, aes(x,y, color=class)) +   geom_point(size=3) 

set.seed(123)
# sample training data and fit model
train <- base::sample(100,1, replace = FALSE)
svmfit <- svm(color~., data = X1[train,], kernel = "radial", gamma = 1, cost = 1)
# plot classifier
plot(svmfit, dat)
kernfit <- ksvm(X1[train,],color[train],  type = "C-svc", kernel = 'radial', C = 1, scaled = c())
# Plot training data
plot(kernfit, data = X1[train,])













data=data.frame(x=iris[100:150,1], y=iris[100:150,2], class=iris[100:150,5])
data= rbind(data,data.frame(x=iris[51:100,1], y=iris[51:100,2], class=iris[51:100,5]))

svm_model= ksvm(class ~ x+ y, data=data, kernel="rbfdot")

w = colSums(coef(svm_model) * data[alphaindex(svm_model)[[1]],c('x','y')])  
b = b(svm_model)
data[, 1:2] = sapply(data[,1:2], scale)

ggplot(data,aes(x, y, color=class)) +
  geom_point(size=3) + geom_abline(intercept=b/sqrt(sum(w^2)), slope=sqrt(sum(w^2))) 

