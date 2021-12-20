library(ggplot2)
library(cowplot)
library(randomForest)

dataNew <- read.csv("NewData.csv", header = T)
dataNew$service <- NULL
dataNew$is_attack = as.factor(dataNew$is_attack)

Split = sample(2,nrow(dataNew),prob = c(0.3,0.7) , replace = T) 

dataTrain = dataNew[Split == 1,]
dataTest = dataNew[Split == 2,]

#dataTrain <- read.csv("TrainDataset.csv", header = T)
#dataTest <- read.csv("TestDataset.csv", header = T)



set.seed(222)
#rf <- randomForest(formula = is_attack ~.,data = dataTrain)
print(rf)
attributes(rf)

library(caret)

#prediction and Confusion matrix - train data
p1 <- predict(rf,dataTrain)
confusionMatrix(p1,dataTrain$is_attack)

#prediction and confusion matrix - test data
p2 <- predict(rf,dataTest)
confusionMatrix(p2,dataTest$is_attack)

#Error rate
plot(rf)

#Tune mtry
tuneRF(dataTrain[,-39], dataTrain[,39], 
       stepFactor = 0.5, plot = TRUE, 
       ntreeTry = 30, trace = TRUE,
       improve = 0.05)

#based on tuning mtry and plotting rf we figured that we dont want ntry = 500,
#we will ntry = 30 and mtry value = 12

#rf <- randomForest(formula = is_attack ~., data = dataTrain, ntree = 30)

rf <- randomForest(formula = is_attack ~., data = dataTrain, ntree = 30, 
                  mtry = 6, importance = TRUE )

#Number of Nodes for Tree
hist(treesize(rf), main ="NO. of nodes for Tree", col = "blue")

# variable Importance 
varImpPlot(rf)
#importance(rf)
#varUsed(rf)

#Multi-dimentional Plotting
MDSplot(rf,datTrain$is_attack)
