#Reading the data from kaggle
library(h2o)
if(Sys.info()['sysname'] == "Darwin" && Sys.info()['release'] == '13.4.0'){ quit(save="no") }else{ h2o.init(nthreads = 2) } 
train=h2o.uploadFile("C:/Computational Statistics/Kaggle/car/train.csv")
test=h2o.uploadFile("C:/Computational Statistics/Kaggle/car/test.csv")

#Replacing missing values by NA
train[train==-1]=NA
test[test==-1]=NA
library(randomForest)
library(caret)

gbm=h2o.gbm(training_frame = train,x=3:59,y=2,model_id = "gbm_covType1",seed=2000)
predict=h2o.predict(gbm,test)
predict
p=as.data.frame(test$id,predict)
write.table(p, "C:/Computational Statistics/Kaggle/car/submition.txt", sep="\t")
