
# free memory
rm(list = ls())
gc()


###################################################
dim(iris)
names(iris)
str(iris)
attributes(iris)



###################################################
iris[1:5,]
head(iris)
tail(iris)



###################################################
iris[1:10, "Sepal.Length"]
iris$Sepal.Length[1:10]



###################################################
summary(iris)



###################################################
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, c(.1, .3, .65))


###################################################
var(iris$Sepal.Length)
hist(iris$Sepal.Length)



###################################################
plot(density(iris$Sepal.Length))



###################################################
table(iris$Species)
pie(table(iris$Species))



###################################################
barplot(table(iris$Species))


###################################################
cov(iris$Sepal.Length, iris$Petal.Length)
cov(iris[,1:4])
cor(iris$Sepal.Length, iris$Petal.Length)
cor(iris[,1:4])



###################################################
aggregate(Sepal.Length ~ Species, summary, data=iris)



###################################################
boxplot(Sepal.Length~Species, data=iris)



###################################################
with(iris, plot(Sepal.Length, Sepal.Width, col=Species, pch=as.numeric(Species)))




###################################################
pairs(iris)



###################################################
library(scatterplot3d)
scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)




###################################################
library(MASS)
parcoord(iris[1:4], col=iris$Species)


###################################################
library(lattice)
parallelplot(~iris[1:4] | Species, data=iris)


###################################################
library(ggplot2)
qplot(Sepal.Length, Sepal.Width, data=iris, facets=Species ~.)

###################################################
str(iris)
set.seed(1234) 
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]



myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

###################################################
### code chunk number 14: ch-decision-trees.rnw:169-174
###################################################

library(rpart)

iris_rpart <- rpart(myFormula, data=trainData, 
                    control = rpart.control(minsplit = 5))
attributes(iris_rpart)

print(iris_rpart)


###################################################
### code chunk number 10: ch-decision-trees.rnw:114-116
###################################################


library(rpart.plot)
prp(iris_rpart,extra=1)

trainPred <- predict(iris_rpart, newdata = trainData, type="class")
table(trainPred, trainData$Species)

testPred <- predict(iris_rpart, newdata = testData, type="class")
table(testPred, testData$Species)


###################################################
### code chunk number 3: ch-clustering.rnw:22-25
###################################################
iris2 <- iris
iris2$Species <- NULL
(kmeans.result <- kmeans(iris2, 7)) 
kmeans.result$totss
kmeans.result$withinss
kmeans.result$tot.withinss
kmeans.result$betweenss



###################################################
### code chunk number 4: ch-clustering.rnw:30-31
###################################################
table(iris$Species, kmeans.result$cluster)



###################################################
### code chunk number 5: ch-clustering.rnw:38-42
###################################################
plot(iris2[c("Sepal.Length", "Sepal.Width")], col = kmeans.result$cluster)
# plot cluster centers
points(kmeans.result$centers[,c("Sepal.Length", "Sepal.Width")], col = 1:3, 
       pch = 8, cex=2)


###################################################
### code chunk number 10: ch-clustering.rnw:131-132
###################################################
set.seed(2835)


###################################################
### code chunk number 11: ch-clustering.rnw:134-138
###################################################
idx <- sample(1:dim(iris)[1], 40)
irisSample <- iris[idx,]
irisSample$Species <- NULL
hc <- hclust(dist(irisSample), method="ave")


###################################################
### code chunk number 12: ch-clustering.rnw:144-148
###################################################

plot(hc, labels=iris$Species[idx])
# cut tree into 3 clusters
rect.hclust(hc, k=3)
groups <- cutree(hc, k=3)

###################################################
### Application of naive bayes
###################################################


library(e1071)
model=naiveBayes(Species ~ .,data=trainData)
attributes(model)

trainPredBayes <- predict(model, newdata = trainData)
table(trainPredBayes, trainData$Species)
testPredBayes <-predict(model,newdata=testData) 
m<-table(testPredBayes, testData$Species)
table(testPredBayes, testData[,5])

evaluator <- function(model,test,n) {
  #predictions used for the confusion matrix
  predictions<-predict(model,test)
  #Confusion Matix
  cm<-table(predictions,test[,n])
  #Calculate Recall taking True Positives and
   #divised by True Positive and False Positive for each Trhee Class
    precision<-diag(cm)/rowSums(cm)
    #Calculate Recall taking True Positives and 
    #divised by True Positive and False Negatives for each Trhee Class
    recall <- (diag(cm) / colSums(cm))
    #Calculate Accuracy taking the total of the True Positives of every class and 
    #divised by the total of the training set
    accuracy<- sum(diag(cm)) / sum(cm)
    #Calculate the Error Rate taking the not correctly predicted instances 
    #divised by the total rows of the training set
    #errorRate<- sum(iris.test$Species != predict(model, iris.test[,1:4], type="raw")) / nrow(iris.test)
    errorRate<-1-accuracy
    print(cm)
    print("--------------Precision-------------------------")
    print(precision)
    print("--------------Recall-------------------------")
    print(recall)
    print("--------------Accuracy-------------------------")
    print(accuracy)
    print("--------------Error-------------------------")
    print(errorRate)
   }

evaluator(model,testData,5)

iris2 <- iris
iris2$Species <- NULL
(kmeans.result <- kmeans(iris2, 6)) 
kmeans.result$totss
kmeans.result$withinss
kmeans.result$tot.withinss
kmeans.result$betweenss
explique <-kmeans.result$betweenss /kmeans.result$totss
explique

###################################################
### code chunk number 4: ch-clustering.rnw:30-31
###################################################
m <-table(iris$Species, kmeans.result$cluster)
m


s<-0
for (i in 1:ncol(m))
{
  p<- max(m[,i]) / sum(m[,i])
  out <- c("pureté du cluster ", i, "est :",p )
print(out)}

