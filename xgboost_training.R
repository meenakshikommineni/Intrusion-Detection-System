# importing libraries
library(xgboost)
library(dplyr)

# reading datasets
train = read.csv("newdatatrain.csv")
test = read.csv("newdatatest.csv")

# manipulating datasets
train_data = as.data.frame(model.matrix(~.-1, data = train))
train_label = train[, "is_attack"]
train_dmatrix = xgb.DMatrix(as.matrix(train_data %>% select(-is_attack)), label = train_label)
test_data = as.data.frame(model.matrix(~.-1, data = test))
test_label = test[, "is_attack"]
test_dmatrix = xgb.DMatrix(as.matrix(test_data %>% select(-is_attack)), label = test_label)
watchlist = list(train = train_dmatrix, test = test_dmatrix)


# train accuracy 99.6%, test accuracy 41.3%
model_1 = xgb.train(data = train_dmatrix, 
                  nrounds = 100, 
                  max_depth = 3, 
                  eta = 0.3, 
                  watchlist = watchlist, 
                  early_stopping_rounds = 20, 
                  objective = "binary:logistic")

# train accuracy 99.9%, test accuracy 92.3%
model_2 = xgb.train(data = train_dmatrix, 
                  nrounds = 100, 
                  max_depth = 6, 
                  eta = 0.3, 
                  watchlist = watchlist, 
                  early_stopping_rounds = 20, 
                  objective = "binary:logistic")

# train accuracy 99.9%, test accuracy 95.1%
model_3 = xgb.train(data = train_dmatrix, 
                  nrounds = 100, 
                  max_depth = 6, 
                  eta = 0.1, 
                  watchlist = watchlist, 
                  early_stopping_rounds = 20, 
                  objective = "binary:logistic")

# train accuracy 99.9%, test accuracy 98.3%
model_4 = xgb.train(data = train_dmatrix, 
                  nrounds = 100, 
                  max_depth = 9, 
                  eta = 0.1, 
                  watchlist = watchlist, 
                  early_stopping_rounds = 20, 
                  objective = "binary:logistic")
