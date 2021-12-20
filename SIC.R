data = read.csv("kddcup99_csv.csv")
for (i in 1:41){
  dataCol = data[,i]
  dataColNum = unique(dataCol)
  if(length(dataColNum) == 1){
    data[,i]<- NULL
  }
}
data$is_attack = as.integer(data$label !="normal")
dataNew = data
dataNew$label<- NULL

dataCol = dataNew[,1]
dataMin = min(dataCol)
dataMax = max(dataCol)
dataValue = dataMax - dataMin

for (i in 1:494020)
{
  dataCol[i] = ((dataCol[i] - dataMin)/dataValue)
}  
dataNew[,1] = dataCol

for (i in 5:41)
{
  dataCol = dataNew[,i]
  dataMin = min(dataCol)
  dataMax = max(dataCol)
  dataValue = dataMax - dataMin
  for (j in 1:494020)
    {
    dataCol[j] = ((dataCol[j] - dataMin)/dataValue)
    }
  dataNew[,i] = dataCol
}
dataNew$is_host_login <- NULL
write.csv(dataNew,"NewData.csv",row.names = F)


str(dataNew)
Split = sample(2,nrow(dataNew),prob = c(0.3,0.7) , replace = T) 

testData = dataNew[Split == 1,]
trainData = dataNew[Split == 2,]
write.csv(testData,"TestDataset.csv", row.names = F)
write.csv(trainData,"TrainDataset.csv", row.names = F)

